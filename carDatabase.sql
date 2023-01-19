-- Creating tables

CREATE TABLE car(
    car_id SERIAL PRIMARY KEY,
    car_make VARCHAR(75),
    car_model VARCHAR(75),
    car_year INTEGER
);

CREATE TABLE customer(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    car_id INTEGER,
    FOREIGN KEY(car_id) REFERENCES car(car_id)
);

CREATE TABLE salesperson(
    salesperson_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    customer_id INTEGER,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

-- Dropping the Foreign Key from Salesperson

ALTER TABLE salesperson
DROP customer_id;

CREATE TABLE invoice(
    invoice_id SERIAL PRIMARY KEY,
    salesperson_id INTEGER,
    FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
    car_id INTEGER,
    FOREIGN KEY(car_id) REFERENCES car(car_id),
    customer_id INTEGER,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

-- Adding a price total for invoices

ALTER TABLE invoice
ADD amount FLOAT;

CREATE TABLE service(
    service_ticket SERIAL PRIMARY KEY,
    car_id INTEGER,
    FOREIGN KEY(car_id) REFERENCES car(car_id),
    service_desc VARCHAR(200)
);

CREATE TABLE service_history(
    service_history_id SERIAL PRIMARY KEY,
    car_id INTEGER,
    FOREIGN KEY(car_id) REFERENCES car(car_id),
    service_ticket INTEGER,
    FOREIGN KEY(service_ticket) REFERENCES service(service_ticket)
);


CREATE TABLE mechanic(
    mechanic_id SERIAL PRIMARY KEY,
    first_name VARCHAR(45),
    last_name VARCHAR(45)
);

CREATE TABLE service_mechanic(
    service_mechanic_id SERIAL PRIMARY KEY,
    mechanic_id INTEGER,
    FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
    service_ticket INTEGER,
    FOREIGN KEY(service_ticket) REFERENCES service(service_ticket)
);



--------------------------- Insertion section

INSERT INTO customer(
    first_name,
    last_name
)VALUES('Test', 'One');

SELECT * FROM customer;

-- Testing a customer without a car

-- Inserting multiple cars

INSERT INTO car(
    car_make,
    car_model,
    car_year
)VALUES(
    'Honda',
    'Civic Si Turbo WHAM',
    2024
),('Honda', 'Accord', 2024), ('Honda', 'Civic', 2023), ('Honda', 'Civic', 2023), ('Honda', 'Civic', 2023), ('Honda', 'Civic', 2023), ('Honda', 'Civic', 2023), ('Honda', 'Civic', 2023), ('Honda', 'Civic', 2023);

SELECT * from car;

-- Inserting customers with a car

INSERT INTO customer(
    first_name,
    last_name,
    car_id
)VALUES('Jimmy', 'John',1),('Thomas', 'Williams',1),('Jennifer', 'Moore', 2),('Jennifer', 'Moore', 3);

SELECT * FROM customer;

-- Inserting the salespersons

INSERT INTO salesperson(
    first_name,
    last_name
)VALUES(
    'Top',
    'Seller'
), ('Mid', 'Mania'), ('Timmy', 'Longlegs'), ('William', 'Bell'), ('Mickey', 'Sticky');

SELECT * FROM salesperson;

-- Inserting mechanic for service_mechanic

INSERT INTO mechanic(
    first_name,
    last_name
)VALUES(
    'Mister',
    'Mechanic'
), ('Junior', 'Juniorson'), ('Handy', 'Mann'), ('First', 'Wrench'), ('Second', 'Screwdriver');

SELECT * FROM mechanic;

-- Insert into service to for proper links for service_mechanic

INSERT INTO service(
    car_id,
    service_desc
)VALUES(
    1,
    'Oil Change'
), (1, 'Tire Rotation'), (2, 'Oil Change'), (3, 'Engine Replacement'), (4, 'Tire Rotation'), (2, 'Tire Installation');

SELECT * FROM service;

-- Inserting into service_mechanic after

INSERT INTO service_mechanic(
    mechanic_id,
    service_ticket
)VALUES(
    1,
    1
), (2, 1), (2, 2), (3, 2), (3, 3), (1, 3), (2, 3);

SELECT * FROM service_mechanic;

-- Inserting into service_history

INSERT INTO service_history(
    car_id,
    service_ticket
)VALUES(
    1,
    1
), (1, 2), (1,1), (2,1), (3,3), (3,1);

SELECT * FROM service_history;

-- Inserting into invoice

INSERT INTO invoice(
    salesperson_id,
    car_id,
    customer_id,
    amount
)VALUES(
    1,
    1,
    2,
    29.99
), (2,1,2,10.99), (3,2,2,29.99), (4,3,4,1276.87);

SELECT * FROM invoice;