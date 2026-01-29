const express = require('express');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');
const { Storage } = require('@google-cloud/storage');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3004;

app.use(cors());
app.use(express.json());

const supabase = createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_ANON_KEY
);

const storage = new Storage({
    projectId: process.env.GCP_PROJECT_ID,
});
const bucket = storage.bucket(process.env.GCS_BUCKET_NAME);

// Book Management
app.post('/api/v1/admin/books', async (req, res) => {
    const { title, slug, base_price, cover_asset_path } = req.body;
    const { data, error } = await supabase
        .from('books')
        .insert([{ title, slug, base_price, cover_asset_path }])
        .select();
    if (error) return res.status(500).json({ error: error.message });
    res.status(201).json(data[0]);
});

// Story Page Management
app.post('/api/v1/admin/stories', async (req, res) => {
    const { book_id, page_number, text_template, image_layer_paths } = req.body;
    const { data, error } = await supabase
        .from('stories')
        .insert([{ book_id, page_number, text_template, image_layer_paths }])
        .select();
    if (error) return res.status(500).json({ error: error.message });
    res.status(201).json(data[0]);
});

app.get('/health', (req, res) => {
    res.json({ status: 'UP', service: 'admin-service' });
});

app.listen(PORT, () => {
    console.log(`Admin service running on port ${PORT}`);
});
