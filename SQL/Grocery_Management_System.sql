CREATE DATABASE grocery_management;

USE grocery_management;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DOUBLE NOT NULL
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE product_categories (
    product_id INT,
    category_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (category_id) REFERENCES categories(id),
    PRIMARY KEY (product_id, category_id)
);

CREATE TABLE suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact VARCHAR(20)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT,
    order_date DATE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO products (name, price) VALUES ('Rice (Basmati)', 99.99);
INSERT INTO products (name, price) VALUES ('Wheat Flour (Atta)', 49.99);
INSERT INTO products (name, price) VALUES ('Lentils (Masoor Dal)', 79.99);
INSERT INTO products (name, price) VALUES ('Chickpeas (Chana)', 69.99);
INSERT INTO products (name, price) VALUES ('Milk (Cow)', 59.99);
INSERT INTO products (name, price) VALUES ('Ghee (Clarified Butter)', 199.99);
INSERT INTO products (name, price) VALUES ('Yogurt (Dahi)', 39.99);
INSERT INTO products (name, price) VALUES ('Sugar (Sakkar)', 29.99);
INSERT INTO products (name, price) VALUES ('Tea Leaves (Chai Patti)', 89.99);
INSERT INTO products (name, price) VALUES ('Spices (Masala)', 119.99);
INSERT INTO products (name, price) VALUES ('Onion (Pyaz)', 19.99);
INSERT INTO products (name, price) VALUES ('Potato (Aloo)', 29.99);
INSERT INTO products (name, price) VALUES ('Tomato (Tamatar)', 39.99);
INSERT INTO products (name, price) VALUES ('Garlic (Lehsun)', 49.99);
INSERT INTO products (name, price) VALUES ('Ginger (Adrak)', 59.99);
INSERT INTO products (name, price) VALUES ('Green Chili (Hari Mirch)', 29.99);
INSERT INTO products (name, price) VALUES ('Coriander Leaves (Dhaniya)', 19.99);
INSERT INTO products (name, price) VALUES ('Curry Leaves (Kadi Patta)', 29.99);
INSERT INTO products (name, price) VALUES ('Mustard Oil (Sarson Ka Tel)', 99.99);
INSERT INTO products (name, price) VALUES ('Coconut (Nariyal)', 49.99);

select * from products;

INSERT INTO categories (name) VALUES ('Rice');
INSERT INTO categories (name) VALUES ('Flour');
INSERT INTO categories (name) VALUES ('Pulses');
INSERT INTO categories (name) VALUES ('Spices');
INSERT INTO categories (name) VALUES ('Dairy');
INSERT INTO categories (name) VALUES ('Cooking Oil');
INSERT INTO categories (name) VALUES ('Vegetables');
INSERT INTO categories (name) VALUES ('Fruits');
INSERT INTO categories (name) VALUES ('Herbs');
INSERT INTO categories (name) VALUES ('Other');

select * from categories;

-- For Rice (Basmati)
INSERT INTO product_categories (product_id, category_id)
VALUES (1, 1);

-- For Wheat Flour (Atta)
INSERT INTO product_categories (product_id, category_id)
VALUES (2, 2);

-- For Lentils (Masoor Dal)
INSERT INTO product_categories (product_id, category_id)
VALUES (3, 3);

-- For Chickpeas (Chana)
INSERT INTO product_categories (product_id, category_id)
VALUES (4, 3);

-- For Milk (Cow)
INSERT INTO product_categories (product_id, category_id)
VALUES (5, 5);

-- For Ghee (Clarified Butter)
INSERT INTO product_categories (product_id, category_id)
VALUES (6, 5);

-- For Yogurt (Dahi)
INSERT INTO product_categories (product_id, category_id)
VALUES (7, 5);

-- For Sugar (Sakkar)
INSERT INTO product_categories (product_id, category_id)
VALUES (8, 10);

-- For Tea Leaves (Chai Patti)
INSERT INTO product_categories (product_id, category_id)
VALUES (9, 10);

-- For Spices (Masala)
INSERT INTO product_categories (product_id, category_id)
VALUES (10, 4);

-- For Onion (Pyaz)
INSERT INTO product_categories (product_id, category_id)
VALUES (11, 7);

-- For Potato (Aloo)
INSERT INTO product_categories (product_id, category_id)
VALUES (12, 7);

-- For Tomato (Tamatar)
INSERT INTO product_categories (product_id, category_id)
VALUES (13, 7);

-- For Garlic (Lehsun)
INSERT INTO product_categories (product_id, category_id)
VALUES (14, 9);

-- For Ginger (Adrak)
INSERT INTO product_categories (product_id, category_id)
VALUES (15, 9);

-- For Green Chili (Hari Mirch)
INSERT INTO product_categories (product_id, category_id)
VALUES (16, 9);

-- For Coriander Leaves (Dhaniya)
INSERT INTO product_categories (product_id, category_id)
VALUES (17, 9);

-- For Curry Leaves (Kadi Patta)
INSERT INTO product_categories (product_id, category_id)
VALUES (18, 9);

-- For Mustard Oil (Sarson Ka Tel)
INSERT INTO product_categories (product_id, category_id)
VALUES (19, 6);

-- For Coconut (Nariyal)
INSERT INTO product_categories (product_id, category_id)
VALUES (20, 8);

select * from product_categories;

-- For Java
INSERT INTO product_categories (product_id, category_id) 
VALUES (
    (SELECT id FROM products WHERE name = '?'), 
    (SELECT id FROM categories WHERE name = '?')
);

SELECT p.name AS product_name, c.name AS category_name
FROM products p
JOIN product_categories pc ON p.id = pc.product_id
JOIN categories c ON pc.category_id = c.id;

INSERT INTO suppliers (name, contact) VALUES ('Rice Supplier', '+91-9876543210');
INSERT INTO suppliers (name, contact) VALUES ('Flour Supplier', '+91-9876543211');
INSERT INTO suppliers (name, contact) VALUES ('Pulses Supplier', '+91-9876543212');
INSERT INTO suppliers (name, contact) VALUES ('Spices Supplier', '+91-9876543213');
INSERT INTO suppliers (name, contact) VALUES ('Dairy Supplier', '+91-9876543214');
INSERT INTO suppliers (name, contact) VALUES ('Cooking Oil Supplier', '+91-9876543215');
INSERT INTO suppliers (name, contact) VALUES ('Vegetable Supplier', '+91-9876543216');
INSERT INTO suppliers (name, contact) VALUES ('Fruit Supplier', '+91-9876543217');
INSERT INTO suppliers (name, contact) VALUES ('Herbs Supplier', '+91-9876543218');
INSERT INTO suppliers (name, contact) VALUES ('Other Supplier', '+91-9876543219');

select * from suppliers;

INSERT INTO orders (supplier_id, order_date) VALUES (1, '2023-10-15');
INSERT INTO orders (supplier_id, order_date) VALUES (2, '2023-09-22');
INSERT INTO orders (supplier_id, order_date) VALUES (3, '2023-08-12');
INSERT INTO orders (supplier_id, order_date) VALUES (4, '2023-07-25');
INSERT INTO orders (supplier_id, order_date) VALUES (5, '2023-06-19');
INSERT INTO orders (supplier_id, order_date) VALUES (6, '2023-05-28');
INSERT INTO orders (supplier_id, order_date) VALUES (7, '2023-04-17');
INSERT INTO orders (supplier_id, order_date) VALUES (8, '2023-03-10');
INSERT INTO orders (supplier_id, order_date) VALUES (9, '2023-02-05');
INSERT INTO orders (supplier_id, order_date) VALUES (10, '2023-01-21');

select * from orders;

-- For order 1
INSERT INTO order_items (order_id, product_id, quantity) VALUES (1, 1, 10); -- Rice (Basmati)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (1, 5, 20); -- Milk (Cow)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (1, 10, 5); -- Spices (Masala)

-- For order 2
INSERT INTO order_items (order_id, product_id, quantity) VALUES (2, 2, 15); -- Wheat Flour (Atta)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (2, 11, 10); -- Onion (Pyaz)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (2, 12, 12); -- Potato (Aloo)

-- For order 3
INSERT INTO order_items (order_id, product_id, quantity) VALUES (3, 3, 8); -- Lentils (Masoor Dal)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (3, 4, 10); -- Chickpeas (Chana)

-- For order 4
INSERT INTO order_items (order_id, product_id, quantity) VALUES (4, 6, 5); -- Ghee (Clarified Butter)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (4, 7, 8); -- Yogurt (Dahi)

-- For order 5
INSERT INTO order_items (order_id, product_id, quantity) VALUES (5, 8, 15); -- Sugar (Sakkar)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (5, 9, 25); -- Tea Leaves (Chai Patti)

-- For order 6
INSERT INTO order_items (order_id, product_id, quantity) VALUES (6, 13, 20); -- Tomato (Tamatar)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (6, 14, 8); -- Garlic (Lehsun)

-- For order 7
INSERT INTO order_items (order_id, product_id, quantity) VALUES (7, 15, 12); -- Ginger (Adrak)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (7, 16, 15); -- Green Chili (Hari Mirch)

-- For order 8
INSERT INTO order_items (order_id, product_id, quantity) VALUES (8, 17, 10); -- Coriander Leaves (Dhaniya)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (8, 18, 5); -- Curry Leaves (Kadi Patta)

-- For order 9
INSERT INTO order_items (order_id, product_id, quantity) VALUES (9, 19, 5); -- Mustard Oil (Sarson Ka Tel)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (9, 20, 3); -- Coconut (Nariyal)

-- For order 10
INSERT INTO order_items (order_id, product_id, quantity) VALUES (10, 1, 8); -- Rice (Basmati)
INSERT INTO order_items (order_id, product_id, quantity) VALUES (10, 2, 10); -- Wheat Flour (Atta)

select * from order_items;
