const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

// Dummy data for initial phase
const books = [
  {
    id: '1',
    title: 'The Magical Adventure of {NAME}',
    slug: 'magical-adventure',
    pageCount: 18,
    basePrice: 24.99,
    coverAssetPath: 'books/magical-adventure/cover.jpg',
    isActive: true
  }
];

app.get('/api/v1/books', (req, res) => {
  res.json(books);
});

app.get('/api/v1/books/:slug', (req, res) => {
  const book = books.find(b => b.slug === req.params.slug);
  if (book) {
    res.json(book);
  } else {
    res.status(404).json({ message: 'Book not found' });
  }
});

app.get('/health', (req, res) => {
  res.json({ status: 'UP', service: 'catalog-service' });
});

app.listen(PORT, () => {
  console.log(`Catalog service running on port ${PORT}`);
});
