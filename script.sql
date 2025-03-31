DROP DATABASE IF EXISTS TechPix;
CREATE DATABASE IF NOT EXISTS TechPix;
USE TechPix;

-- Company --

CREATE TABLE City(
	idCity INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(45)
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

CREATE TABLE Contact(
	idContact INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100),
    phone CHAR(11)
);

CREATE TABLE Photo(
	idPhoto INT PRIMARY KEY AUTO_INCREMENT,
    path VARCHAR(156)
);

CREATE TABLE Company(
	idCompany INT PRIMARY KEY AUTO_INCREMENT,
    socialReason VARCHAR(100),
    cnpj CHAR(14),
    fkContact INT,
    fkAdress INT,
    fkPhoto INT,
    CONSTRAINT fkContact_Company FOREIGN KEY (fkContact)
		REFERENCES Contact(idContact),
	CONSTRAINT fkAdress_Company FOREIGN KEY (fkAdress)
		REFERENCES Adress(idAdress),
	CONSTRAINT fkPhoto_Company FOREIGN KEY (fkPhoto)
		REFERENCES Photo(idPhoto)
);

-- Employer --

CREATE TABLE Employer(
	idEmployer INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    cpf CHAR(11),
    role VARCHAR(45),
    fkContact INT,
    fkAdmin INT,
    fkPhoto INT,
    fkCompany INT,
    CONSTRAINT fkContact_Employer FOREIGN KEY (fkContact)
		REFERENCES Contact(idContact),
	CONSTRAINT fkAdmin_Employer FOREIGN KEY (fkAdmin)
		REFERENCES Employer(idEmployer),
	CONSTRAINT fkPhoto_Employer FOREIGN KEY (fkPhoto)
		REFERENCES Photo(idPhoto),
	CONSTRAINT fkCompany_Employer FOREIGN KEY (fkCompany)
		REFERENCES Company(idCompany)
);

CREATE TABLE Login(
	idLogin INT PRIMARY KEY AUTO_INCREMENT,
    password VARCHAR(45),
    fkEmployer INT,
    CONSTRAINT fkEmployer_Login FOREIGN KEY (fkEmployer)
		REFERENCES Employer(idEmployer)
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
    situation VARCHAR(45),
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

