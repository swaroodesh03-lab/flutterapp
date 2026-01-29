const express = require('express');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3002;

app.use(cors());
app.use(express.json());

const supabase = createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_ANON_KEY
);

app.post('/api/v1/personalize/preview', async (req, res) => {
    const { bookId, personalization } = req.body;

    // Logic to fetch story templates and map them to the character
    const { data: stories, error } = await supabase
        .from('stories')
        .select('*')
        .eq('book_id', bookId)
        .order('page_number', { ascending: true });

    if (error) return res.status(500).json({ error: error.message });

    // Process templates
    const personalizedStories = stories.map(story => ({
        pageNumber: story.page_number,
        text: story.text_template.replace(/{NAME}/g, personalization.name),
        layers: story.image_layer_paths
    }));

    res.json({
        stories: personalizedStories,
        previewImageUrl: `https://storage.googleapis.com/${process.env.GCS_BUCKET_NAME}/previews/${personalization.gender}_preview.png`
    });
});

app.get('/health', (req, res) => {
    res.json({ status: 'UP', service: 'personalization-service' });
});

app.listen(PORT, () => {
    console.log(`Personalization service running on port ${PORT}`);
});
