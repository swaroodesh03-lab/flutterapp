const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3004;

app.use(cors());
app.use(express.json());

app.post('/api/v1/admin/books', (req, res) => {
    // Mock book creation
    res.json({ message: 'Book created', bookId: 'new-book-id' });
});

app.post('/api/v1/admin/assets/upload', (req, res) => {
    // Mock asset upload logic (GCS)
    res.json({ message: 'Asset uploaded', path: 'gs://bucket/path/to/asset.png' });
});

app.get('/health', (req, res) => {
    res.json({ status: 'UP', service: 'admin-service' });
});

app.listen(PORT, () => {
    console.log(`Admin service running on port ${PORT}`);
});
