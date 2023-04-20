CREATE TABLE Customer (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate DATE,
    email VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Order (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(id)
);

CREATE TABLE Item (
    id INT PRIMARY KEY,
    order_id INT,
	category_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2),
    status VARCHAR(20),
    timestamp DATETIME,
    FOREIGN KEY (order_id) REFERENCES Order(id),
	FOREIGN KEY (category_id) REFERENCES Category(id)
	FOREIGN KEY (id) REFERENCES Item_Status_Price(id)
);

CREATE TABLE Category (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Item_Status_Price (
    itemId INT PRIMARY KEY,
    price DECIMAL(10,2),
	status VARCHAR(50)
	FOREIGN KEY (id) REFERENCES Item(id)
);