const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3002;

app.use(cors());
app.use(express.json());

// Dummy character assets config
const characterConfig = {
    genders: ['boy', 'girl'],
    skinTones: ['light', 'medium', 'dark'],
    hairStyles: ['short', 'long', 'curly'],
    hairColors: ['black', 'brown', 'blonde'],
    glasses: [true, false]
};

app.get('/api/v1/personalize/config', (req, res) => {
    res.json(characterConfig);
});

app.post('/api/v1/personalize/preview', (req, res) => {
    const { bookId, personalization } = req.body;

    // Logic to return combined layer URLs based on personalization
    // For now, return mock paths
    res.json({
        previewUrl: 'https://storage.googleapis.com/flutterappfortesting/previews/sample.png',
        layers: [
            `characters/${personalization.gender}/skin/${personalization.skinTone}.png`,
            `characters/${personalization.gender}/hair/${personalization.hairStyle}_${personalization.hairColor}.png`,
            personalization.hasGlasses ? `characters/accessories/glasses.png` : null
        ].filter(Boolean)
    });
});

app.get('/health', (req, res) => {
    res.json({ status: 'UP', service: 'personalization-service' });
});

app.listen(PORT, () => {
    console.log(`Personalization service running on port ${PORT}`);
});
