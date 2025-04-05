USE TechPix;

INSERT INTO City (name) VALUES
('São Paulo');

INSERT INTO Adress (street, number, cep, district, fkCity) VALUES
('Rua Haddock Lobo', '605', '03212321', 'Bela Vista', 1);

INSERT INTO Company (socialReason, cnpj, fkAdress) VALUES
("TechPix", "12345678998745", 1);

INSERT INTO Employer (name, cpf, email, role, fkCompany, password) VALUES
('Marilu', '12345697812', 'marilu@techpix.com', 'admin', 1, 'testeMarilu');