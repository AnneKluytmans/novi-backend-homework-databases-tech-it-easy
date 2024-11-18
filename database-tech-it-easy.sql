-- DROP tables if they already exist
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Products CASCADE;
DROP TABLE IF EXISTS ProductSaleDates CASCADE;
DROP TABLE IF EXISTS Remotes CASCADE;
DROP TABLE IF EXISTS CiModules CASCADE;
DROP TABLE IF EXISTS WallBrackets CASCADE;
DROP TABLE IF EXISTS Televisions CASCADE;
DROP TABLE IF EXISTS TelevisionsWallBrackets CASCADE;

-- CREATE ENUM types for role and product type
CREATE TYPE role_enum AS ENUM ('ADMIN', 'STAFF');
CREATE TYPE product_type_enum AS ENUM ('Smart TV', 'Remote', 'CI Module', 'Wall Bracket');

--CREATE tables
CREATE TABLE Users (
    username VARCHAR(58) PRIMARY KEY,
    password VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    authorization_role role_enum NOT NULL
);


CREATE TABLE Products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(58) NOT NULL,
    brand VARCHAR(58),
    type product_type_enum NOT NULL,
    price DOUBLE PRECISION NOT NULL CHECK (price >= 0),
    amount_in_stock INT DEFAULT 0,
    amount_sold INT DEFAULT 0 CHECK (amount_sold <= amount_in_stock)
);

CREATE TABLE ProductSaleDates (
    sale_date DATE NOT NULL,
    product_id BIGINT,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);


CREATE TABLE Remotes (
    id BIGINT PRIMARY KEY REFERENCES Products(id) ON DELETE CASCADE,
    battery_type VARCHAR(24),
    is_smart BOOLEAN
);


CREATE TABLE CiModules (
    id BIGINT PRIMARY KEY REFERENCES Products(id) ON DELETE CASCADE,
    provider VARCHAR(58),
    encoding_type VARCHAR(36)
);


CREATE TABLE WallBrackets (
    id BIGINT PRIMARY KEY REFERENCES Products(id) ON DELETE CASCADE,
    construction_type VARCHAR(58),
    height FLOAT CHECK (height > 0),
    width FLOAT CHECK (width > 0)
);


CREATE TABLE Televisions (
    id BIGINT PRIMARY KEY REFERENCES Products(id) ON DELETE CASCADE,
    screen_type VARCHAR(36),
    height FLOAT CHECK (height > 0),
    width FLOAT CHECK (width > 0),
    screen_quality VARCHAR(58),
    has_wifi BOOLEAN,
    is_smart BOOLEAN,
    has_voice_control BOOLEAN,
    is_hdr_compatible BOOLEAN,
    remote_id BIGINT,
    ci_module_id BIGINT,
    CONSTRAINT fk_remote FOREIGN KEY (remote_id) REFERENCES Remotes(id) ON DELETE CASCADE,
    CONSTRAINT fk_ci_module FOREIGN KEY (ci_module_id) REFERENCES CiModules(id) ON DELETE CASCADE
);

CREATE TABLE TelevisionsWallBrackets (
    television_id BIGINT,
    wall_bracket_id BIGINT,
    CONSTRAINT fk_television FOREIGN KEY (television_id) REFERENCES Televisions(id) ON DELETE CASCADE,
    CONSTRAINT fk_wall_bracket FOREIGN KEY (wall_bracket_id) REFERENCES WallBrackets(id) ON DELETE CASCADE
);

--INSERT data into tables
INSERT INTO Users (username, password, email, authorization_role)
VALUES ('user1', 'password1', 'user1@example.com', 'ADMIN'),
       ('user2', 'password2', 'user2@example.com', 'STAFF'),
       ('user3', 'password3', 'user3@example.com', 'STAFF');

SELECT * FROM Users;

INSERT INTO Products (name, brand, type, price, amount_in_stock, amount_sold)
VALUES ('Samsung Smart TV 55"', 'Samsung', 'Smart TV', 499.99, 10, 3),
       ('LG OLED TV 65"', 'LG', 'Smart TV', 899.99, 5, 2),
       ('Sony 4K Ultra HD TV 50"', 'Sony', 'Smart TV', 750.00, 8, 4),
       ('Panasonic LED TV 40"', 'Panasonic', 'Smart TV', 300.00, 15, 6),
       ('LG Basic Remote', 'LG', 'Remote', 29.99, 25, 5),
       ('Samsung Smart Remote', 'Samsung', 'Remote', 49.99, 20, 8),
       ('Sony Universal Remote', 'Sony', 'Remote', 39.99, 30, 10),
       ('Sony CI Module Type A', 'Sony', 'CI Module', 99.99, 15, 8),
       ('Samsung CI Module Type B', 'Samsung', 'CI Module', 120.00, 10, 4),
       ('Sony Wall Bracket Adjustable', 'Sony', 'Wall Bracket', 49.99, 20, 6),
       ('Samsung Wall Bracket Fixed', 'Samsung', 'Wall Bracket', 45.99, 18, 5);

SELECT * FROM Products;

INSERT INTO ProductSaleDates (sale_date, product_id)
VALUES ('2024-10-01', 1),
       ('2024-10-01', 6),
       ('2024-10-10', 2),
       ('2024-10-12', 8),
       ('2024-10-15', 2),
       ('2024-10-15', 5),
       ('2024-10-15', 4),
       ('2024-10-22', 11),
       ('2024-10-28', 1),
       ('2024-10-28', 6),
       ('2024-10-28', 11),
       ('2024-11-01', 6),
       ('2024-11-03', 7),
       ('2024-11-05', 7),
       ('2024-11-08', 11),
       ('2024-11-10', 10),
       ('2024-11-12', 2),
       ('2024-11-14', 9),
       ('2024-11-16', 6),
       ('2024-11-16', 11),
       ('2024-11-20', 2),
       ('2024-11-22', 3);

SELECT * FROM ProductSaleDates;

INSERT INTO Remotes (id, battery_type, is_smart)
VALUES (5, 'AAA', false),
       (6, 'Rechargeable', true),
       (7, 'AA', true);

SELECT * FROM Remotes;

INSERT INTO CiModules (id, provider, encoding_type)
VALUES (8, 'Sony Provider', 'Type A'),
       (9, 'Samsung Provider', 'Type B');

SELECT * FROM CiModules;

INSERT INTO WallBrackets (id, construction_type, height, width)
VALUES (10, 'Adjustable', 20.0, 30.0),
       (11, 'Fixed', 15.0, 25.0);

SELECT * FROM WallBrackets;

INSERT INTO Televisions (id, screen_type, height, width, screen_quality, has_wifi, is_smart, has_voice_control, is_hdr_compatible, remote_id, ci_module_id)
VALUES (1, 'LED', 55.0, 30.0, '4K', true, true, true, true, 5, 8),
       (2, 'OLED', 65.0, 35.0, '8K', true, true, true, true, 6, 9),
       (3, 'QLED', 50.0, 28.0, 'HD', true, false, false, true, 7, 8),
       (4, 'LCD', 40.0, 25.0, 'Full HD', false, false, false, false, 5, 9);

SELECT * FROM Televisions;

INSERT INTO TelevisionsWallBrackets (television_id, wall_bracket_id)
VALUES (1, 10),
       (1, 11),
       (2, 10),
       (3, 10),
       (3, 11),
       (4, 11);

SELECT * FROM TelevisionsWallBrackets;


-- UPDATE tables
UPDATE Products
SET amount_in_stock = amount_in_stock + 10
WHERE id = 1;

SELECT * FROM Products
ORDER BY id ASC;


UPDATE Products
SET price = price * 0.9
WHERE name = 'LG OLED TV 65"';

SELECT * FROM Products
ORDER BY price ASC;


UPDATE Remotes
SET battery_type = 'Rechargeable', is_smart = false
WHERE id = 7;

SELECT * FROM Remotes;


-- SELECT and JOIN data from tables
SELECT * FROM Products
WHERE price < 500;

SELECT t.screen_type, t.screen_quality, p.name AS television_name, r.battery_type AS remote_battery_type, c.provider
FROM Televisions t
JOIN Products p ON t.id = p.id
LEFT JOIN Remotes r ON t.remote_id = r.id
LEFT JOIN CiModules c ON t.ci_module_id = c.id;

SELECT psd.sale_date, p.name AS product_name
FROM ProductSaleDates psd
JOIN Products p ON psd.product_id = p.id
WHERE p.type = 'Smart TV'
ORDER BY psd.sale_date DESC;


SELECT type, SUM(amount_sold) AS total_sold
FROM Products
GROUP BY type;


SELECT p.name AS television_name, wb.constructionType AS wall_bracket_type
FROM TelevisionsWallBrackets twb
JOIN Televisions t ON twb.television_id = t.id
JOIN Products p ON t.id = p.id
JOIN WallBrackets wb ON twb.wallBracket_id = wb.id;


SELECT * FROM Products
WHERE amount_sold = (SELECT MAX(amount_sold) FROM Products);


SELECT brand, SUM(amount_in_stock) AS total_stock, SUM(amount_sold) AS total_sales
FROM Products
GROUP BY brand;
