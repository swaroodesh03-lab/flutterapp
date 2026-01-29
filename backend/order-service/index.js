const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3003;

app.use(cors());
app.use(express.json());

app.post('/api/v1/cart/add', (req, res) => {
    const { bookId, personalization } = req.body;
    // Mock cart logic
    res.json({ message: 'Added to cart', cartId: 'mock-cart-123' });
});

app.post('/api/v1/checkout', (req, res) => {
    // Mock checkout logic
    res.json({ message: 'Checkout initiated', checkoutUrl: 'https://checkout.stripe.com/mock' });
});

app.get('/health', (req, res) => {
    res.json({ status: 'UP', service: 'order-service' });
});

app.listen(PORT, () => {
    console.log(`Order service running on port ${PORT}`);
});
