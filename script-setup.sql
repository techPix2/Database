DROP DATABASE IF EXISTS TechPix;
CREATE DATABASE IF NOT EXISTS TechPix;
USE TechPix;

CREATE USER IF NOT EXISTS 'techpix_insert'@'%' IDENTIFIED BY 'techpix#2024';
GRANT ALL PRIVILEGES ON *.* TO 'techpix_insert'@'%';

CREATE USER IF NOT EXISTS 'techpix_select'@'%' IDENTIFIED BY 'techpix#2024';
GRANT ALL PRIVILEGES ON *.* TO 'techpix_select'@'%';

FLUSH PRIVILEGES;

CREATE TABLE City(
    idCity INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(45)
);

CREATE TABLE Address(
    idAddress INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(100),
    number VARCHAR(48),
    postalCode VARCHAR(10),
    district VARCHAR(45),
    fkCity INT,
    CONSTRAINT fkCity_Address FOREIGN KEY (fkCity)
                            REFERENCES City(idCity)
);

CREATE TABLE Company(
    idCompany INT PRIMARY KEY AUTO_INCREMENT,
    socialReason VARCHAR(100),
    active TINYINT,
    fkAddress INT,
    CONSTRAINT fkAddress_Company FOREIGN KEY (fkAddress)
        REFERENCES Address(idAddress)
);

CREATE TABLE Server(
    idServer INT PRIMARY KEY AUTO_INCREMENT,
    hostName VARCHAR(45),
    macAddress CHAR(17),
    status VARCHAR(45),
    position INT,
    mobuId VARCHAR(100),
    operationalSystem VARCHAR(45),
    active TINYINT,
    fkCompany INT,
    CONSTRAINT fkCompany_Server FOREIGN KEY (fkCompany)
        REFERENCES Company(idCompany)
);

CREATE TABLE Employer(
    idEmployer INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    role VARCHAR(45),
    fkCompany INT,
    fkAdmin INT,
    email VARCHAR(256),
    password VARCHAR(45),
    active TINYINT,
    CONSTRAINT fkCompany_Employer FOREIGN KEY (fkCompany)
        REFERENCES Company(idCompany),
    CONSTRAINT fkAdmin_Employer FOREIGN KEY (fkAdmin)
        REFERENCES Employer(idEmployer)
);

CREATE TABLE Component (
    idComponent INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    type VARCHAR(45),
    description VARCHAR(45),
    fkServer INT,
    serial VARCHAR(100),
    CONSTRAINT fkServer_Component FOREIGN KEY (fkServer) REFERENCES Server(idServer)
);

CREATE TABLE AccessLog(
    idAccessLog INT PRIMARY KEY AUTO_INCREMENT,
    datetime DATETIME,
    type VARCHAR(45),
    fkEmployer INT,
    CONSTRAINT fkEmployer_AccessLog FOREIGN KEY (fkEmployer)
        REFERENCES Employer(idEmployer)
);

CREATE TABLE ProcessLog(
    idProcess INT PRIMARY KEY AUTO_INCREMENT,
    nameProcess VARCHAR(45),
    dtTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    cpu_percent INT,
    fkMachine INT,
    CONSTRAINT fkmachine FOREIGN KEY (fkMachine)
        REFERENCES Server(idServer)
);

-- INSERTS para popular o banco com 1 Company e 1 Employer

-- Inserir cidade
INSERT INTO City (city) VALUES ('São Paulo');

-- Inserir endereço
INSERT INTO Address (street, number, postalCode, district, fkCity)
VALUES ('Av. Paulista', '1000', '01310-100', 'Bela Vista', 1);

-- Inserir empresa
INSERT INTO Company (socialReason, active, fkAddress)
VALUES ('TechPix Ltda', 1, 1);

-- Inserir employer (sem fkAdmin inicialmente, pode ser NULL)
INSERT INTO Employer (name, role, fkCompany, fkAdmin, email, password, active)
VALUES ('João Silva', 'Administrador', 1, NULL, 'joao.silva@techpix.com', 'senha123', 1);

-- Consultas exemplo
DESC ProcessLog;
SELECT * FROM Employer;
SELECT * FROM Server;
SHOW TABLES;
DELETE FROM Server WHERE idServer = 1;
