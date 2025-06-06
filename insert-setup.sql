USE TechPix;

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

