-- Create Tables for E-commerce Schema with Inventory Links

-- 1. Suppliers Table
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number BIGINT,
    password VARCHAR(255)
);

-- 2. Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    phone_number BIGINT,
    password VARCHAR(255),
    loyalty_level VARCHAR(50)
);

-- 3. Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    stock INT,
    image_url VARCHAR(255),
    description TEXT,
    specifications TEXT,
    manufacturer VARCHAR(255)
);

-- 4. Inventory Table (Product stock and details)
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock INT,
    location VARCHAR(255),
    restock_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 5. Supplies Table (Link suppliers and inventory)
CREATE TABLE supplies (
    supplier_id INT,
    product_id INT,
    PRIMARY KEY(supplier_id, product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (product_id) REFERENCES inventory(product_id) -- Linking supplies to inventory
);

-- 6. Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2),
    order_status ENUM('Pending', 'Fulfilled', 'Anomaly', 'Returned', 'Cancelled'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 7. Ordered Products Table (Link orders and inventory)
CREATE TABLE ordered_products (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES inventory(product_id) -- Linking orders to inventory
);

-- 8. Cart Table (Link cart to inventory)
CREATE TABLE cart (
    customer_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (customer_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES inventory(product_id) -- Linking cart to inventory
);

-- 9. Payment Table
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Stripe', 'Cash on Delivery'),
    order_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 10. Shipping Addresses Table
CREATE TABLE shipping_addresses (
    shipping_address_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    phone_number BIGINT
);

-- 11. Ships To Table (Link customers to shipping addresses)
CREATE TABLE ships_to (
    customer_id INT,
    shipping_address_id INT,
    PRIMARY KEY(customer_id, shipping_address_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (shipping_address_id) REFERENCES shipping_addresses(shipping_address_id)
);

-- 12. Customer Reports Table
CREATE TABLE customer_reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    behavior TEXT,
    report_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 13. Order Logs Table (Historical order information)
CREATE TABLE order_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    order_date TIMESTAMP,
    total_amount DECIMAL(10, 2),
    order_status VARCHAR(10),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 14. Discounts Table (For marketing and product discounts)
CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    discount_percentage DECIMAL(5, 2),
    start_date DATE,
    end_date DATE,
    customer_id INT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 15. Customer Loyalty Table (Track loyalty points and membership tiers)
CREATE TABLE customer_loyalty (
    customer_id INT PRIMARY KEY,
    loyalty_points INT DEFAULT 0,
    membership_tier VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 16. Returns Table (Track returned items and their reasons)
CREATE TABLE returns (
    return_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    return_reason TEXT,
    return_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES inventory(product_id) -- Linking returns to inventory
);

-- 17. Anomalies Table (Track issues or anomalies with orders)
CREATE TABLE anomalies (
    anomaly_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    issue_description TEXT,
    reported_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
