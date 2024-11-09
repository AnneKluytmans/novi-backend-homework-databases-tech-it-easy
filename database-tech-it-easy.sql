-- DROP tables if they already exist
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Products CASCADE;
DROP TABLE IF EXISTS ProductSaleDates CASCADE;
DROP TABLE IF EXISTS Remotes CASCADE;
DROP TABLE IF EXISTS CiModules CASCADE;
DROP TABLE IF EXISTS WallBrackets CASCADE;
DROP TABLE IF EXISTS Televisions CASCADE;
DROP TABLE IF EXISTS TelevisionsWallBrackets CASCADE;


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


