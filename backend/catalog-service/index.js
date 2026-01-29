const express = require('express');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

app.get('/api/v1/books', async (req, res) => {
  const { data, error } = await supabase
    .from('books')
    .select('*')
    .eq('is_active', true);

  if (error) {
    return res.status(500).json({ error: error.message, details: 'Try seeding the database if this table is missing' });
  }
  res.json(data);
});

app.get('/api/v1/books/:slug', async (req, res) => {
  const { data, error } = await supabase
    .from('books')
    .select('*')
    .eq('slug', req.params.slug)
    .single();

  if (error) {
    return res.status(404).json({ error: 'Book not found' });
  }
  res.json(data);
});

app.get('/health', (req, res) => {
  res.json({ status: 'UP', service: 'catalog-service' });
});

app.listen(PORT, () => {
  console.log(`Catalog service running on port ${PORT}`);
});
