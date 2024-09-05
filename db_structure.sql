
CREATE TABLE suppliers(
    supplier_id int AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number bigint,
    password VARCHAR(255)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age int,
    phone_number bigint,
    password VARCHAR(255)
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    stock INT,
    image_url VARCHAR(255)
);

CREATE TABLE supplies(
    supplier_id int,
    product_id int,
    PRIMARY KEY(supplier_id,product_id),
    FOREIGN KEY(supplier_id)REFERENCES suppliers(supplier_id),
    FOREIGN KEY(product_id)REFERENCES products(product_id)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2),
    order_status VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

create table ordered_products(
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

CREATE TABLE cart (
    customer_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    PRIMARY KEY (customer_id,product_id),
    FOREIGN KEY (customer_id) REFERENCES customer_id(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Stripe', 'Cash on Delivery'),
    order_id int,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE shipping_addresses (
    shipping_address_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    phone_number bigint
);

CREATE TABLE ships_to (
    customer_id INT ,
    shipping_address_id int,
    PRIMARY KEY(customer_id,shipping_address_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (shipping_address_id) REFERENCES shipping_addresses(shipping_address_id)
 );
