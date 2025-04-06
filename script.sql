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