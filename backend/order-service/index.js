const express = require('express');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3003;

app.use(cors());
app.use(express.json());

const supabase = createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_ANON_KEY
);

app.post('/api/v1/orders', async (req, res) => {
    const { personalization, totalPrice, userId } = req.body;

    const { data, error } = await supabase
        .from('orders')
        .insert([
            {
                user_id: userId,
                personalization_json: personalization,
                total_price: totalPrice,
                status: 'pending'
            }
        ])
        .select();

    if (error) return res.status(500).json({ error: error.message });

    res.status(201).json({
        message: 'Order created',
        order: data[0],
        checkoutUrl: 'https://checkout.stripe.com/mock' // Mock for now as requested to skip Stripe
    });
});

app.get('/api/v1/orders/:userId', async (req, res) => {
    const { data, error } = await supabase
        .from('orders')
        .select('*')
        .eq('user_id', req.params.userId);

    if (error) return res.status(500).json({ error: error.message });
    res.json(data);
});

app.get('/health', (req, res) => {
    res.json({ status: 'UP', service: 'order-service' });
});

app.listen(PORT, () => {
    console.log(`Order service running on port ${PORT}`);
});
