DROP DATABASE IF EXISTS TechPix;
CREATE DATABASE IF NOT EXISTS TechPix;
USE TechPix;

-- Company --

CREATE TABLE City(
	idCity INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45)
);

CREATE TABLE Adress(
	idAdress INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(100),
    number VARCHAR(5),
    cep CHAR(8),
	district VARCHAR(45),
	fkCity INT,
    CONSTRAINT fkCity_Adress FOREIGN KEY (fkCity) 
		REFERENCES City(idCity)
);

CREATE TABLE Company(
	idCompany INT PRIMARY KEY AUTO_INCREMENT,
    socialReason VARCHAR(100),
    cnpj CHAR(14),
    fkAdress INT,
	CONSTRAINT fkAdress_Company FOREIGN KEY (fkAdress)
		REFERENCES Adress(idAdress)
);

-- Employer --

CREATE TABLE Employer(
	idEmployer INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    cpf CHAR(11),
    email VARCHAR(100),
    photoPath VARCHAR(100),
    role VARCHAR(45),
    password VARCHAR(45),
    fkAdmin INT,
    fkCompany INT,
	CONSTRAINT fkAdmin_Employer FOREIGN KEY (fkAdmin)
		REFERENCES Employer(idEmployer),
	CONSTRAINT fkCompany_Employer FOREIGN KEY (fkCompany)
		REFERENCES Company(idCompany)
);

CREATE TABLE AcessLog(
	idAcessLog INT PRIMARY KEY AUTO_INCREMENT,
	dateTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    type VARCHAR(10),
    fkEmployer INT,
    CONSTRAINT fkEmployer_AcessLog FOREIGN KEY (fkEmployer)
		REFERENCES Employer(idEmployer)
);

-- Machine --

CREATE TABLE Server(
	idServer INT PRIMARY KEY AUTO_INCREMENT,
    hostName VARCHAR(45),
    macAdress CHAR(17),
    status VARCHAR(45),
    position VARCHAR(45),
    mobuId VARCHAR(100) UNIQUE KEY,
    operationalSystem VARCHAR(45),
    fkCompany INT,
    CONSTRAINT fkCompany_Server FOREIGN KEY (fkCompany)
		REFERENCES Company(idCompany)
);

CREATE TABLE Component(
	idComponent INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(45),
    description VARCHAR(100),
    serial VARCHAR(45) UNIQUE KEY,
    fkServer INT,
    CONSTRAINT fkServer_Component FOREIGN KEY (fkServer)
		REFERENCES Server(idServer)
);

CREATE TABLE Measure(
	idMeasure INT PRIMARY KEY AUTO_INCREMENT,
    measure VARCHAR(45),
    limiter INT,
    fkComponent INT,
    CONSTRAINT fkComponent_Measure FOREIGN KEY (fkComponent)
		REFERENCES Component(idComponent)
);

CREATE TABLE Alert(
	idAlert INT PRIMARY KEY AUTO_INCREMENT,
    current DOUBLE,
	type VARCHAR(20),
    fkMeasure INT,
	datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fkMeasure_Alert FOREIGN KEY (fkMeasure)
		REFERENCES Measure(idMeasure)
);


-- Tabelas estatisticas (Exemplo) Todas as tabelas são exemplos e terão os campos de acordo com as métricas dos componentes--

CREATE TABLE process_CompanyName_Machine(
	idProcess INT PRIMARY KEY AUTO_INCREMENT,
    processCode VARCHAR(45),
    name VARCHAR(100),
    cpuPercent DOUBLE,
    ramPercent DOUBLE,
    ramUsed BIGINT
);

CREATE TABLE data_CompanyName_Machine(
	idData INT PRIMARY KEY AUTO_INCREMENT,
    cpuPercent DOUBLE,
    cpuUsed BIGINT,
    ramPercent DOUBLE,
    ramUsed BIGINT,
    diskPercent DOUBLE,
    diskUsed BIGINT,
    datetime DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alert_CompanyName_Machine(
	idAlert INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(45),
    cpuPercent DOUBLE,
    cpuUsed BIGINT,
    ramPercent DOUBLE,
    ramUsed BIGINT,
    diskPercent DOUBLE,
    diskUsed BIGINT,
    datetime DATETIME DEFAULT CURRENT_TIMESTAMP
);