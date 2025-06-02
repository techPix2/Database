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
                         email varchar(256),
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
                           CONSTRAINT fkServer_Component FOREIGN KEY (fkServer) REFERENCES Server(idServer)
                           
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
                             fkComponent INT,
							CONSTRAINT fkAlertMachine_Component FOREIGN KEY (fkComponent)
								REFERENCES Component(idComponent)
);
CREATE TABLE AccessLog(
                          idAccessLog INT PRIMARY KEY AUTO_INCREMENT,
                          datetime DATETIME,
                          type VARCHAR(45),
                          fkEmployer INT,
                          CONSTRAINT fkEmployer_AccessLog FOREIGN KEY (fkEmployer)
                              REFERENCES Employer(idEmployer)
);


-- Insert City
INSERT INTO City (city) VALUES 
('São Paulo');

-- Insert Address
INSERT INTO Address (street, number, postalCode, district, fkCity) VALUES
('Rua Haddock Lobo', '595', '01414-001', 'Cerqueira César', 1);

-- Insert Company
INSERT INTO Company (socialReason, cnpj, active, fkAddress) VALUES
('TechPix Solutions LTDA', '12345678901234', 1, 1);

-- Insert Admin Employee
INSERT INTO Employer (name, cpf, role, fkCompany, email, password, active) VALUES
('Admin Silva', '12345678901', 'Administrador', 1, 'admin@techpix.com', 'senha123', 1);

-- Insert Servers
INSERT INTO Server (hostName, macAddress, status, position, mobuId, operationalSystem, active, fkCompany) VALUES
('SRV-001', '00:1A:2B:3C:4D:5E', 'ONLINE', 1, 'MOBU001', 'Windows Server 2019', 1, 1),
('SRV-002', '00:1A:2B:3C:4D:5F', 'ONLINE', 2, 'MOBU002', 'Linux Ubuntu 20.04', 1, 1),
('SRV-003', '00:1A:2B:3C:4D:60', 'ONLINE', 3, 'MOBU003', 'Windows Server 2022', 1, 1);

-- Insert Components (CPU and RAM for each server)
INSERT INTO Component (name, type, description, fkServer, serial) VALUES
-- Server 1 Components
('Intel Xeon E5', 'CPU', 'Processador Principal', 1, 'CPU123456'),
('Kingston RAM', 'RAM', 'Memória Principal', 1, 'RAM123456'),
-- Server 2 Components
('AMD EPYC', 'CPU', 'Processador Principal', 2, 'CPU789012'),
('Crucial RAM', 'RAM', 'Memória Principal', 2, 'RAM789012'),
-- Server 3 Components
('Intel Xeon Gold', 'CPU', 'Processador Principal', 3, 'CPU345678'),
('Samsung RAM', 'RAM', 'Memória Principal', 3, 'RAM345678');

-- Insert Alerts (multiple alerts for each server's components)
INSERT INTO AlertMachine (type, cpuPercent, cpuFreq, ramPercent, ramUsed, diskPercent, diskUsed, dateTime, fkComponent) VALUES
-- Alerts for Server 1
('WARNING', 85.5, 3600, 75.5, 12884901888, 65, 524288000, '2025-05-23 10:00:00', 1),
('CRITICAL', 95.2, 3600, 88.7, 14884901888, 70, 624288000, '2025-05-23 10:15:00', 1),
('WARNING', 78.4, 3600, 92.1, 15884901888, 75, 724288000, '2025-05-23 10:30:00', 2),

-- Alerts for Server 2
('WARNING', 87.3, 4000, 82.5, 13884901888, 60, 424288000, '2025-05-23 11:00:00', 3),
('CRITICAL', 96.8, 4000, 94.3, 15884901888, 85, 824288000, '2025-05-23 11:15:00', 3),
('CRITICAL', 82.1, 4000, 91.8, 14884901888, 78, 724288000, '2025-05-23 11:30:00', 4),

-- Alerts for Server 3
('WARNING', 88.9, 3800, 85.5, 13884901888, 72, 624288000, '2025-05-23 12:00:00', 5),
('CRITICAL', 97.5, 3800, 96.2, 15884901888, 88, 924288000, '2025-05-23 12:15:00', 5),
('WARNING', 84.7, 3800, 89.9, 14884901888, 76, 724288000, '2025-05-23 12:30:00', 6);

-- Insert some process records
INSERT INTO ProcessMachine (processCode, name, cpuPercent, ramPercent, ramUsed, fkServer) VALUES
('PROC001', 'sqlservr.exe', 45.5, 35.8, 4294967296, 1),
('PROC002', 'apache2', 38.7, 42.3, 3294967296, 2),
('PROC003', 'nginx', 41.2, 38.9, 2294967296, 3);

SELECT
    s.hostName AS ServerHostName,
    c.name AS ComponentName,
    c.type AS ComponentType,
    am.idAlertMachine,
    am.type AS AlertType,
    am.cpuPercent,
    am.cpuFreq,
    am.ramPercent,
    am.ramUsed,
    am.diskPercent,
    am.diskUsed,
    am.dateTime AS AlertDateTime
FROM
    AlertMachine am
JOIN
    Component c ON am.fkComponent = c.idComponent
JOIN
    Server s ON c.fkServer = s.idServer
WHERE
    s.hostName = 'SRV-001' -- Specify the server's hostName here
ORDER BY
    am.dateTime DESC
LIMIT 1;
