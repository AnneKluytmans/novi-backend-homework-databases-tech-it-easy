-- DROP tables if they already exist
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Products CASCADE;
DROP TABLE IF EXISTS ProductSaleDates CASCADE;
DROP TABLE IF EXISTS Remotes CASCADE;
DROP TABLE IF EXISTS CiModules CASCADE;
DROP TABLE IF EXISTS WallBrackets CASCADE;
DROP TABLE IF EXISTS Televisions CASCADE;
DROP TABLE IF EXISTS TelevisionsWallBrackets CASCADE;

--CREATE tables
CREATE TABLE Users (
    username VARCHAR(58) PRIMARY KEY,
    password VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    authorizationRole VARCHAR(24) NOT NULL
);


CREATE TABLE Products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(58) NOT NULL,
    brand VARCHAR(58),
    type VARCHAR(36),
    price DOUBLE PRECISION NOT NULL CHECK (price >= 0),
    amountInStock INT DEFAULT 0,
    amountSold INT DEFAULT 0
);

CREATE TABLE ProductSaleDates (
    saleDate DATE NOT NULL,
    product_id BIGINT,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);


CREATE TABLE Remotes (
    id BIGINT PRIMARY KEY REFERENCES Products(id) ON DELETE CASCADE,
    batteryType VARCHAR(24),
    isSmart BOOLEAN
);


CREATE TABLE CiModules (
    id BIGINT PRIMARY KEY REFERENCES Products(id) ON DELETE CASCADE,
    provider VARCHAR(58),
    encodingType VARCHAR(36)
);


CREATE TABLE WallBrackets (
    id BIGINT PRIMARY KEY REFERENCES Products(id) ON DELETE CASCADE,
    constructionType VARCHAR(58),
    height FLOAT CHECK (height > 0),
    width FLOAT CHECK (width > 0)
);


CREATE TABLE Televisions (
    id BIGINT PRIMARY KEY REFERENCES Products(id) ON DELETE CASCADE,
    screenType VARCHAR(36),
    height FLOAT CHECK (height > 0),
    width FLOAT CHECK (width > 0),
    screenQuality VARCHAR(58),
    hasWifi BOOLEAN,
    isSmart BOOLEAN,
    hasVoiceControl BOOLEAN,
    isHdrCompatible BOOLEAN,
    remote_id BIGINT,
    ciModule_id BIGINT,
    CONSTRAINT fk_remote FOREIGN KEY (remote_id) REFERENCES Remotes(id) ON DELETE CASCADE,
    CONSTRAINT fk_ciModue FOREIGN KEY (ciModule_id) REFERENCES CiModules(id) ON DELETE CASCADE
);

CREATE TABLE TelevisionsWallBrackets (
    television_id BIGINT,
    wallBracket_id BIGINT,
    CONSTRAINT fk_television FOREIGN KEY (television_id) REFERENCES Televisions(id) ON DELETE CASCADE,
    CONSTRAINT fk_wallBracket FOREIGN KEY (wallBracket_id) REFERENCES WallBrackets(id) ON DELETE CASCADE
);

--INSERT data into tables
INSERT INTO Users (username, password, email, authorizationRole)
VALUES ('user1', 'password1', 'user1@example.com', 'ADMIN'),
       ('user2', 'password2', 'user2@example.com', 'STAFF'),
       ('user3', 'password3', 'user3@example.com', 'STAFF');

SELECT * FROM Users;


INSERT INTO Products (name, brand, type, price, amountInStock, amountSold)
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


INSERT INTO ProductSaleDates (saleDate, product_id)
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


INSERT INTO Remotes (id, batteryType, isSmart)
VALUES (5, 'AAA', false),
       (6, 'Rechargeable', true),
       (7, 'AA', true);

SELECT * FROM Remotes;


INSERT INTO CiModules (id, provider, encodingType)
VALUES (8, 'Sony Provider', 'Type A'),
       (9, 'Samsung Provider', 'Type B');

SELECT * FROM CiModules;


INSERT INTO WallBrackets (id, constructionType, height, width)
VALUES (10, 'Adjustable', 20.0, 30.0),
       (11, 'Fixed', 15.0, 25.0);

SELECT * FROM WallBrackets;


INSERT INTO Televisions (id, screenType, height, width, screenQuality, hasWifi, isSmart, hasVoiceControl, isHdrCompatible, remote_id, ciModule_id)
VALUES (1, 'LED', 55.0, 30.0, '4K', true, true, true, true, 5, 8),
       (2, 'OLED', 65.0, 35.0, '8K', true, true, true, true, 6, 9),
       (3, 'QLED', 50.0, 28.0, 'HD', true, false, false, true, 7, 8),
       (4, 'LCD', 40.0, 25.0, 'Full HD', false, false, false, false, 5, 9);

SELECT * FROM Televisions;


INSERT INTO TelevisionsWallBrackets (television_id, wallBracket_id)
VALUES (1, 10),
       (1, 11),
       (2, 10),
       (3, 10),
       (3, 11),
       (4, 11);

SELECT * FROM TelevisionsWallBrackets;