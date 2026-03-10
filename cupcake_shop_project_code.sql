-- Create a new database for the cupcake shop
CREATE DATABASE annandale_cupcakes;
USE annandale_cupcakes;

-- Table: customer
-- Stores all customer information
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each customer
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(20),
    email VARCHAR(30),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(25),
    zip VARCHAR(10),
    notes VARCHAR(255), -- Optional notes about the customer
    created_at DATETIME,
    updated_at DATETIME
);

-- Table: customer_note
-- Stores notes for each customer. A customer can have multiple notes.
CREATE TABLE customer_note (
    note_id INT PRIMARY KEY AUTO_INCREMENT,
    subject VARCHAR(100),
    note TEXT,
    customer_id INT, -- Links note to a specific customer
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    -- Ensures each note belongs to a valid customer
);

-- Table: product
-- Stores products available in the shop
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    cupcake_type VARCHAR(50), -- Type of cupcake (e.g., Standard, Premium)
    cupcake_name VARCHAR(100),
    price DECIMAL(10,2), -- Selling price
    cost_per_unit DECIMAL(10,2), -- Cost to produce
    notes TEXT,
    unit_capacity_per_day INT, -- Maximum cupcakes that can be made per day
    created_at DATETIME,
    updated_at DATETIME
);

-- Table: sale
-- Stores information about each sale
CREATE TABLE sale (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT, -- Links sale to the customer who made it
    sale_date DATE,
    notes TEXT,
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    -- Ensures the sale belongs to a valid customer
);

-- Table: event
-- Stores catering or special event orders
CREATE TABLE event (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT, -- Which customer requested the event
    sale_id INT, -- Which sale the event is linked to
    event_datetime DATETIME, -- When the event takes place
    bake_order_datetime DATETIME, -- When baking is scheduled
    description TEXT,
    delivery_instructions TEXT,
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (sale_id) REFERENCES sale(sale_id)
    -- Ensures event is linked to a valid customer and sale
);

-- Table: payment
-- Tracks payments made for each sale
CREATE TABLE payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_method VARCHAR(50), -- e.g., Cash, Credit Card
    amount DECIMAL(10,2),
    notes TEXT,
    sale_id INT, -- Links payment to a sale
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (sale_id) REFERENCES sale(sale_id)
    -- Ensures each payment is associated with a valid sale
);

-- Table: sale_item
-- Tracks individual products in each sale
CREATE TABLE sale_item (
    sale_item_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_id INT, -- Links item to a sale
    product_id INT, -- Links item to a product
    quantity INT, -- Number of units sold
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (sale_id) REFERENCES sale(sale_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
    -- Ensures every item belongs to a valid sale and product
);
