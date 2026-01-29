-- SQL for Supabase Editor

-- 1. Create Books table
CREATE TABLE books (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    page_count INTEGER DEFAULT 18,
    base_price DECIMAL(10,2) NOT NULL,
    cover_asset_path TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Create Stories table
CREATE TABLE stories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    book_id UUID REFERENCES books(id) ON DELETE CASCADE,
    page_number INTEGER NOT NULL,
    text_template TEXT NOT NULL,
    image_layer_paths JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Create Orders table
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID,
    personalization_json JSONB NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status TEXT DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Seed Dummy Book
INSERT INTO books (title, slug, base_price, cover_asset_path)
VALUES ('The Magical Adventure of {NAME}', 'magical-adventure', 24.99, 'book/cover.jpg');

-- 5. Seed Story Pages
WITH book_info AS (SELECT id FROM books WHERE slug = 'magical-adventure' LIMIT 1)
INSERT INTO stories (book_id, page_number, text_template, image_layer_paths)
VALUES 
((SELECT id FROM book_info), 1, 'Once upon a time, there was a kind child named {NAME}.', '["book/page1.jpg"]'),
((SELECT id FROM book_info), 2, '{NAME} found a glowing map!', '["book/page2.jpg"]'),
((SELECT id FROM book_info), 3, 'The adventure begins for {NAME}!', '["book/page3.jpg"]');
