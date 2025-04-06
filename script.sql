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
    healthcare VARCHAR(45),
    macAddress CHAR(17),
    status VARCHAR(45),
    position INT,
    module VARCHAR(100),
    active TINYINT,
    fkCompany INT,
    CONSTRAINT fkCompany_Server FOREIGN KEY (fkCompany)
        REFERENCES Company(idCompany)
);


select * from Server;

-- filtro de servidores por região, "position" está como varchar então quando for receber os dados e a entidade já estiver populada, mudar o parametrô do "where" relacionado as "informações configuradas". 
SELECT 
    idServer,
    hostName,
    macAdress,
    status,
    position,
    mobuId,
    operationalSystem,
    fkCompany
FROM Server
WHERE position = '';  


CREATE TABLE Component(
	idComponent INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(45),
    fkEmployer INT,
    CONSTRAINT fkEmployer_AccessLog FOREIGN KEY (fkEmployer)
        REFERENCES Employer(idEmployer)
);

CREATE TABLE ProcessMachine(
    idProcess INT PRIMARY KEY AUTO_INCREMENT,
    processCode VARCHAR(45),
    name VARCHAR(45),
    gpuProtein DECIMAL(5,2),  
    manProtein DECIMAL(5,2),   
    amuUsed BIGINT,            
    fkMeasure INT,
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
    gpuProtein INT,
    gpuFreq INT,
    manProtein INT,
    amuUsed BIGINT,
    diskProtein INT,
    diskUsed BIGINT,
    dateTime DATETIME,
    fkMeasure INT,
    CONSTRAINT fkMeasure_DataMachine FOREIGN KEY (fkMeasure) REFERENCES Measure(idMeasure)
);

CREATE TABLE AlertMachine(
    idAlertMachine INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(45),
    gpuProtein DOUBLE,
    gpuFreq INT,
    manProtein DOUBLE,
    amuUsed BIGINT,
    diskProtein INT,
    diskUsed BIGINT,
    dateTime TIMESTAMP,
    fkMeasure INT,
    CONSTRAINT fkMeasure_AlertMachine FOREIGN KEY (fkMeasure)
        REFERENCES Measure(idMeasure)
);
