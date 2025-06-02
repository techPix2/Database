USE TechPix;

INSERT INTO City (city) VALUES
('São Paulo');

INSERT INTO Address (street, number, postalCode, district, fkCity) VALUES
('Rua Haddock Lobo', '605', '03212321', 'Bela Vista', 1);

INSERT INTO Company (socialReason, cnpj, fkAddress) VALUES
("TechPix", "12345678998745", 1);

INSERT INTO Employer (name, cpf, email, role, fkCompany, password) VALUES
('Marilu', '12345697812', 'marilu@techpix.com', 'admin', 1, 'testeMarilu');

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