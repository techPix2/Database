DROP DATABASE IF EXISTS TechPix;
CREATE DATABASE IF NOT EXISTS TechPix;
USE TechPix;

CREATE USER IF NOT EXISTS 'techpixUser'@'%' IDENTIFIED BY 'techpix#2024';
GRANT ALL PRIVILEGES ON *.* TO 'techpixUser'@'%';

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
    email varchar(256),
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

INSERT INTO City (city) VALUES ('São Paulo');

INSERT INTO Address (street, number, postalCode, district, fkCity)
VALUES ('Av. Paulista', '1000', '01310-100', 'Bela Vista', 1);

INSERT INTO Company (socialReason, active, fkAddress)
VALUES ('TechPix Ltda', 1, 1);

INSERT INTO Employer (name, role, fkCompany, fkAdmin, email, password, active) VALUES
('Marilu Ramos', 'Administrador', 1, NULL, 'marilu.ramos@techpix.com', 'Senha@123', 1),
('Olivia Swift', 'Cientista', 1, 1, 'olivia.swift@techpix.com', 'Senha@321', 1),
('Yuri Depay', 'Analista', 1, 1, 'yuri.depay@techpix.com', 'Senha@213', 1);

INSERT INTO AccessLog (datetime, type, fkEmployer) VALUES
('2024-06-06 08:01:12', 'login', 1),
('2024-06-06 12:10:34', 'logout', 1),

('2024-06-06 08:15:00', 'login', 2),
('2024-06-06 12:00:00', 'logout', 2),

('2024-06-06 08:30:00', 'login', 3),
('2024-06-06 11:45:00', 'logout', 3),

('2024-06-06 13:10:00', 'login', 2),
('2024-06-06 17:00:00', 'logout', 2),

('2024-06-06 13:15:00', 'login', 3),
('2024-06-06 16:50:00', 'logout', 3),

('2024-06-06 13:20:00', 'login', 1),
('2024-06-06 17:05:00', 'logout', 1);