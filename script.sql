DROP DATABASE IF EXISTS TechPix;
CREATE DATABASE IF NOT EXISTS TechPix;
USE TechPix;


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
    cnpj CHAR(14), 
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
    cpf CHAR(11),  
    role VARCHAR(45),
    fkCompany INT,
    fkAdmin INT,
    password VARCHAR(45),
    photoPath VARCHAR(100),  
    active TINYINT,
    CONSTRAINT fkCompany_Employer FOREIGN KEY (fkCompany)
        REFERENCES Company(idCompany),
    CONSTRAINT fkAdmin_Employer FOREIGN KEY (fkAdmin)
        REFERENCES Employer(idEmployer)
);
CREATE TABLE ProcessMachine(
    idProcess INT PRIMARY KEY AUTO_INCREMENT,
    processCode VARCHAR(45),
    name VARCHAR(45),
    cpuPercent DECIMAL(5,2),  
    ramPercent DECIMAL(5,2),   
    ramUsed BIGINT,        
    fkServer INT,
    CONSTRAINT fkServer_ProcessMachine FOREIGN KEY (fkServer)
        REFERENCES Server(idServer)
);

CREATE TABLE Component (
    idComponent INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    type VARCHAR(45),
    description VARCHAR(45),
    fkServer INT,
    serial VARCHAR(100),
    CONSTRAINT fkServer_Component FOREIGN KEY (fkServer)
        REFERENCES Server(idServer)
);

CREATE TABLE Measure(
    idMeasure INT PRIMARY KEY AUTO_INCREMENT,
    measureType VARCHAR(45),
    limiterValue INT,
    fkComponent INT,
    CONSTRAINT fkComponent_Measure FOREIGN KEY (fkComponent) REFERENCES Component(idComponent)
);

CREATE TABLE DataMachine(
    idDataMachine INT PRIMARY KEY AUTO_INCREMENT,
    cpuPercent INT,
    cpuFreq INT,
    ramPercent INT,
    ramUsed BIGINT,
    diskPercent INT,
    diskUsed BIGINT,
    dateTime DATETIME,
    fkMeasure INT,
    CONSTRAINT fkMeasure_DataMachine FOREIGN KEY (fkMeasure) REFERENCES Measure(idMeasure)
);

CREATE TABLE AlertMachine(
    idAlertMachine INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(45),
    cpuPercent DOUBLE,
    cpuFreq INT,
    ramPercent DOUBLE,
    ramUsed BIGINT,
    diskPercent INT,
    diskUsed BIGINT,
    dateTime TIMESTAMP,
    fkMeasure INT,
    CONSTRAINT fkMeasure_AlertMachine FOREIGN KEY (fkMeasure)
        REFERENCES Measure(idMeasure)
);
CREATE TABLE AccessLog(
    idAccessLog INT PRIMARY KEY AUTO_INCREMENT,
    datetime DATETIME,
    type VARCHAR(45),
    fkEmployer INT,
    CONSTRAINT fkEmployer_AccessLog FOREIGN KEY (fkEmployer)
        REFERENCES Employer(idEmployer)
);
-- Inserindo dados na tabela City
INSERT INTO City (city) VALUES ('São Paulo');

-- Inserindo dados na tabela Address
INSERT INTO Address (street, number, postalCode, district, fkCity) 
VALUES ('Av. Paulista', '1000', '01310-100', 'Bela Vista', 1);

-- Inserindo dados na tabela Company
INSERT INTO Company (socialReason, cnpj, active, fkAddress) 
VALUES ('TechPix Ltda', '12345678000190', 1, 1);

-- Inserindo dados na tabela Server
INSERT INTO Server (hostName, macAddress, status, position, mobuId, operationalSystem, active, fkCompany) 
VALUES ('server01', '00:1A:2B:3C:4D:5E', 'Ativo', 1, 'M123456', 'Linux', 1, 1);

-- Inserindo dados na tabela Employer (primeiro admin)
INSERT INTO Employer (name, cpf, role, fkCompany, password, photoPath, active) 
VALUES ('Admin Master', '12345678901', 'Administrador', 1, 'senha123', '/photos/admin.jpg', 1);

-- Inserindo outro funcionário (não admin)
INSERT INTO Employer (name, cpf, role, fkCompany, fkAdmin, password, photoPath, active) 
VALUES ('João Silva', '98765432109', 'Analista', 1, 1, 'senha456', '/photos/joao.jpg', 1);

-- Inserindo dados na tabela Component
INSERT INTO Component (name, type, description, fkServer, serial) 
VALUES ('CPU', 'Processador', 'Intel i7', 1, 'CPU12345');

-- Inserindo dados na tabela Measure
INSERT INTO Measure (measureType, limiterValue, fkComponent) 
VALUES ('Uso de CPU', 90, 1);

-- Inserindo dados na tabela ProcessMachine
INSERT INTO ProcessMachine (processCode, name, cpuPercent, ramPercent, ramUsed, fkServer) 
VALUES ('P001', 'System', 5.25, 30.50, 2048000000, 1);

-- Inserindo dados na tabela DataMachine
INSERT INTO DataMachine (cpuPercent, cpuFreq, ramPercent, ramUsed, diskPercent, diskUsed, dateTime, fkMeasure) 
VALUES (25, 2400, 45, 3072000000, 30, 50000000000, NOW(), 1);

-- Inserindo dados na tabela AlertMachine
INSERT INTO AlertMachine (type, cpuPercent, cpuFreq, ramPercent, ramUsed, diskPercent, diskUsed, dateTime, fkMeasure) 
VALUES ('Alerta CPU', 95.5, 3500, 65.3, 4096000000, 45, 60000000000, NOW(), 1);

-- Inserindo dados na tabela AccessLog
INSERT INTO AccessLog (datetime, type, fkEmployer) 
VALUES (NOW(), 'Login', 1);
SELECT 
    idServer,
    hostName,
    macAddress,
    status,
    position,
    mobuId,
    operationalSystem,
    fkCompany
FROM Server
WHERE position = ''; 

SELECT * 
FROM AlertMachine 
JOIN Measure ON AlertMachine.fkMeasure = Measure.idMeasure 
JOIN Component ON Measure.fkComponent = Component.idComponent 
JOIN Server ON Component.fkServer = Server.idServer 
WHERE Server.fkCompany = 1
AND position = 1
AND AlertMachine.dateTime >= DATE_SUB(NOW(), INTERVAL 30 MONTH);

SELECT * 
FROM AlertMachine 
JOIN Measure ON AlertMachine.fkMeasure = Measure.idMeasure 
JOIN Component ON Measure.fkComponent = Component.idComponent 
JOIN Server ON Component.fkServer = Server.idServer 
WHERE Server.fkCompany = 1
AND idServer = 1
AND AlertMachine.dateTime >= DATE_SUB(NOW(), INTERVAL 30 MONTH);