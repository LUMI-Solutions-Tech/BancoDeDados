CREATE DATABASE lumi_sprint_3;
USE lumi_sprint_3;

CREATE TABLE Endereco (
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
rua VARCHAR(200),
numero VARCHAR(5),
cep CHAR(8),
complemento VARCHAR(50)
);

INSERT INTO Endereco (rua, numero, cep, complemento) VALUES
('Estrada do Sítio Verde', '100', '13150000', 'Próximo ao celeiro'),
('Rodovia Rural Km 12', '200', '14150000', 'Entrada da fazenda'),
('Estrada da Colheita', '45', '16870410', 'Galpão principal'),
('Sítio Boa Esperança', '320', '18502201', 'Área das estufas'),
('Estrada do Sol Nascente', '780', '13190000', 'Setor de irrigação'),
('Fazenda Santa Luz', '12', '09815210', 'Fundos do terreno'),
('Estrada das Hortaliças', '90', '06900135', 'Próximo ao reservatório'),
('Sítio Nova Vida', '55', '13220000', 'Casa administrativa'),
('Rodovia Verde Km 8', '400', '17595000', 'Área experimental'),
('Estrada do Cultivo', '22', '18240000', 'Setor técnico');


CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14),
razaoSocial VARCHAR(250),
codEmpresa CHAR(6)
);

-- INSERIR CODIGO EMPRESA
INSERT INTO Empresa (cnpj, razaoSocial, codEmpresa) VALUES
('67890123000106', 'BioEstufa Ltda', 'BE0001'),
('12345678000101', 'Verde Vida Ltda', 'VV0002'),
('23456789000102', 'AgroLuz SA', 'AL0003'),
('90123456000109', 'PlantaLux ME', 'PL0004'),
('34567890000103', 'Cultiva Tech Ltda', 'CT0005'),
('89012345000108', 'HidroGrow Ltda', 'HG0006'),
('56789012000105', 'LumiFarm Ltda', 'LF0007'),
('78901234000107', 'NutriVerde SA', 'NV0008'),
('45678901000104', 'FotoFarm ME', 'FF0009'),
('01234567000110', 'CresceLuz Ltda', 'CL0010');


CREATE TABLE Usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL,
telefone VARCHAR(15),
email VARCHAR(100) NOT NULL UNIQUE,
senha VARCHAR(50) NOT NULL,
fkEmpresa INT,
CONSTRAINT fk_usuario_empresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

INSERT INTO Usuario (nome, telefone, email, senha, fkEmpresa) VALUES
('Ana Souza', '11958470101', 'ana@email.com', 'Ana123', 1),
('Pedro Silva', '11988887777', 'pedro@email.com', 'roca123', 1),
('Bruno Lima', '11959887141', 'bruno@email.com', 'Bruno123', 2),
('Lucas Ferreira', '11991234567', 'lucas@email.com', 'campo456', 2),
('Carla Mendes', '11966230121', 'carla@email.com', 'Carla123', 3),
('Marcos Oliveira', '11992345678', 'marcos@email.com', 'estufa789', 3),
('Felipe Santos', '11993456789', 'felipe.santos@email.com', 'tec123', 3),
('Diego Ramos', null, 'diego@email.com', 'Diego123', 4),
('Rafael Costa', '11994567890', 'rafael@email.com', 'plantacao321', 4),
('Elaine Ferreira', '11995571461', 'elaine@email.com', 'Elaine123', 5),
('Felipe Costa', '11954546132', 'felipe@email.com', 'Felipe123', 6),
('Gabriela Nunes', '11917729301', 'gabi@email.com', 'Gabi@2024', 7),
('Henrique Alves', '11973317054', 'henrique@email.com', 'Henrique123', 8),
('Isabela Rocha', null, 'isa@email.com', 'Isa123', 9),
('Joao Martins', '11993021014', 'joao@email.com', 'Joao123', 10);


CREATE TABLE tipoAlface (
idTipoAlface INT PRIMARY KEY AUTO_INCREMENT,
ppfdMin INT,
ppfdMax INT,
ppfdIdeal INT,
dliIdeal INT,
tipoAlface CHAR(9),
CONSTRAINT chkTipoAlface CHECK(tipoAlface IN('Crespa', 'Americana'))
);

INSERT INTO tipoAlface (tipoAlface, ppfdMin, ppfdMax, ppfdIdeal, dliIdeal) VALUES
('Americana', 250, 300, 275, 16),
('Crespa', 220, 280, 250, 15);


CREATE TABLE Estufa (
idEstufa INT,
fkEmpresa INT,
fkEndereco INT,
nomeEstufa VARCHAR(150) NOT NULL,
infraestrutura VARCHAR(100),
statusEstufa CHAR(10) NOT NULL,
CONSTRAINT pkCompostaEstufa PRIMARY KEY(idEstufa, fkEmpresa),
CONSTRAINT fk_estufa_empresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
CONSTRAINT fk_empresa_endereco FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco),
CONSTRAINT chkStatus CHECK(statusEstufa IN('Ativo', 'Inativo', 'Manutenção'))
);

INSERT INTO Estufa (idEstufa, fkEmpresa, fkEndereco, nomeEstufa, infraestrutura, statusEstufa) VALUES
(1, 1, 1, 'Viveiro Verde Vida', 'LED Full Spectrum', 'Ativo'),
(2, 1, 2, 'Estufa do Sítio', 'HPS 600W', 'Ativo'),
(3, 1, 3, 'Cultivo Primavera', 'CMH 315W', 'Ativo'),
(4, 2, 4, 'B1', 'LED Full Spectrum', 'Ativo'),
(5, 2, 5, 'B2', 'CMH 315W', 'Inativo'),
(6, 2, 6, 'B3', 'HPS 600W', 'Ativo'),
(7, 2, 7, 'B4', 'Fluorescente T5', 'Manutenção'),
(8, 3, 8, 'Estufa Tecnológica', 'LED Full Spectrum', 'Ativo'),
(9, 3, 9, 'Produção Inteligente', 'Fluorescente T5', 'Ativo'),
(10, 4, 10, 'D1', 'LED Full Spectrum', 'Ativo'),
(11, 4, 1, 'D2', 'HPS 1000W', 'Inativo'),
(12, 4, 2, 'D3', 'CMH 630W', 'Ativo'),
(13, 5, 3, 'Estufa da Fazenda', 'LED Full Spectrum', 'Ativo'),
(14, 5, 4, 'Área de Cultivo 1', 'CMH 630W', 'Ativo'),
(15, 5, 5, 'Área de Cultivo 2', 'HPS 600W', 'Ativo'),
(16, 5, 6, 'Produção Hidropônica', 'Fluorescente T5', 'Ativo'),
(17, 5, 7, 'Estufa Sol Nascente', 'LED Full Spectrum', 'Ativo'),
(18, 6, 8, 'Estufa Principal', 'LED Full Spectrum', 'Ativo'),
(19, 7, 9, 'Setor Sul', 'LED Full Spectrum', 'Ativo'),
(20, 7, 10, 'Setor Leste', 'Fluorescente T5', 'Ativo'),
(21, 8, 1, 'Cultivo Crespa', 'LED Full Spectrum', 'Ativo'),
(22, 8, 2, 'Cultivo Americana', 'CMH 315W', 'Ativo'),
(23, 9, 3, 'Estufa Experimental', 'LED Full Spectrum', 'Ativo'),
(24, 9, 4, 'Produção Avançada', 'HPS 600W', 'Inativo'),
(25, 9, 5, 'Cultivo Premium', 'CMH 315W', 'Ativo'),
(26, 10, 6, 'J1', 'LED Full Spectrum', 'Ativo'),
(27, 10, 7, 'J2', 'CMH 630W', 'Ativo'),
(28, 10, 8, 'J3', 'HPS 600W', 'Manutenção'),
(29, 10, 9, 'J4', 'Fluorescente T5', 'Ativo');


CREATE TABLE estufa_tipoAlface (
fkEstufa INT,
fkEmpresa INT,
fkTipoAlface INT,
data DATE,
CONSTRAINT PRIMARY KEY (fkEstufa, fkEmpresa),
CONSTRAINT fkEmpresaEstufa FOREIGN KEY (fkEstufa) REFERENCES estufa(idEstufa),
CONSTRAINT fkAlfaceEstufa FOREIGN KEY (fkTipoAlface) REFERENCES tipoAlface(idTipoAlface)
);

INSERT INTO estufa_tipoAlface (fkEstufa, fkEmpresa, fkTipoAlface, data) VALUES
(1, 1, 1, '2026-04-01'),
(2, 1, 2, '2026-04-01'),
(3, 1, 1, '2026-04-02'),
(4, 2, 2, '2026-04-02'),
(5, 2, 1, '2026-04-03'),
(6, 2, 2, '2026-04-03'),
(7, 2, 1, '2026-04-04'),
(8, 3, 2, '2026-04-04'),
(9, 3, 1, '2026-04-05'),
(10, 4, 2, '2026-04-05'),
(11, 4, 1, '2026-04-06'),
(12, 4, 2, '2026-04-06'),
(13, 5, 1, '2026-04-07'),
(14, 5, 2, '2026-04-07'),
(15, 5, 1, '2026-04-08'),
(16, 5, 2, '2026-04-08'),
(17, 5, 1, '2026-04-09'),
(18, 6, 2, '2026-04-09'),
(19, 7, 1, '2026-04-10'),
(20, 7, 2, '2026-04-10'),
(21, 8, 2, '2026-04-11'),
(22, 8, 1, '2026-04-11'),
(23, 9, 2, '2026-04-12'),
(24, 9, 1, '2026-04-12'),
(25, 9, 2, '2026-04-13'),
(26, 10, 1, '2026-04-13'),
(27, 10, 2, '2026-04-14'),
(28, 10, 1, '2026-04-14'),
(29, 10, 2, '2026-04-15');


CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nomeSensor VARCHAR(100) NOT NULL,
statusSensor CHAR(10) NOT NULL,
fkEstufa INT,
CONSTRAINT chkStsSensor CHECK(statusSensor IN('Ativo', 'Inativo', 'Manutenção')),
CONSTRAINT fk_sensor_estufa FOREIGN KEY (fkEstufa) REFERENCES Estufa(idEstufa)
);

INSERT INTO Sensor (nomeSensor, statusSensor, fkEstufa) VALUES
('LDR-E1-1-1', 'Ativo', 1),
('LDR-E1-1-2', 'Ativo', 1),
('LDR-E1-2-1', 'Ativo', 2),
('LDR-E1-3-1', 'Ativo', 3),
('LDR-E2-4-1', 'Ativo', 4),
('LDR-E2-4-2', 'Inativo', 4),
('LDR-E2-5-1', 'Ativo', 5),
('LDR-E2-6-1', 'Ativo', 6),
('LDR-E2-7-1', 'Manutenção', 7),
('LDR-E3-8-1', 'Ativo', 8),
('LDR-E3-8-2', 'Ativo', 8),
('LDR-E3-9-1', 'Ativo', 9),
('LDR-E4-10-1', 'Ativo', 10),
('LDR-E4-11-1', 'Inativo', 11),
('LDR-E4-12-1', 'Ativo', 12),
('LDR-E5-13-1', 'Ativo', 13),
('LDR-E5-13-2', 'Ativo', 13),
('LDR-E5-14-1', 'Ativo', 14),
('LDR-E5-15-1', 'Ativo', 15),
('LDR-E5-16-1', 'Ativo', 16),
('LDR-E5-17-1', 'Ativo', 17),
('LDR-E6-18-1', 'Ativo', 18),
('LDR-E7-19-1', 'Ativo', 19),
('LDR-E7-20-1', 'Ativo', 20),
('LDR-E8-21-1', 'Ativo', 21),
('LDR-E8-22-1', 'Ativo', 22),
('LDR-E9-23-1', 'Ativo', 23),
('LDR-E9-24-1', 'Inativo', 24),
('LDR-E9-25-1', 'Ativo', 25),
('LDR-E10-26-1', 'Ativo', 26),
('LDR-E10-27-1', 'Ativo', 27),
('LDR-E10-28-1', 'Manutenção', 28),
('LDR-E10-29-1', 'Ativo', 29);

CREATE TABLE Leituras (
idLeituras INT,
fkSensor INT,
lux INT,
ppfd INT,
dli DECIMAL(8,1),
dataHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT PRIMARY KEY (idLeituras, fkSensor),
CONSTRAINT fk_leituras_sensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);

-- INSERTS
INSERT INTO Leituras (idLeituras, fkSensor, lux, ppfd, dataHora) VALUES
(1, 1, 750, 275, '2026-04-18 06:00:00'),
(2, 2, 720, 260, '2026-04-18 07:00:00'),
(3, 3, 780, 290, '2026-04-18 08:00:00'),
(4, 4, 700, 255, '2026-04-18 09:00:00'),
(5, 6, 740, 270, '2026-04-18 10:00:00'),
(6, 8, 710, 258, '2026-04-18 11:00:00'),
(7, 9, 600, 220, '2026-04-18 12:00:00'),
(8, 10, 580, 210, '2026-04-18 13:00:00'),
(9, 11, 770, 285, '2026-04-18 14:00:00'),
(10, 12, 730, 265, '2026-04-18 15:00:00'),
(11, 13, 760, 275, '2026-04-18 16:00:00'),
(12, 14, 745, 268, '2026-04-18 17:00:00'),
(13, 16, 900, 320, '2026-04-18 18:00:00'),
(14, 17, 765, 282, '2026-04-18 19:00:00'),
(15, 18, 735, 266, '2026-04-18 20:00:00'),
(16, 19, 748, 272, '2026-04-18 21:00:00'),
(17, 20, 610, 230, '2026-04-18 22:00:00'),
(18, 21, 780, 290, '2026-04-18 23:00:00'),
(19, 22, 770, 285, '2026-04-19 00:00:00'),
(20, 23, 760, 275, '2026-04-19 01:00:00'),
(21, 25, 920, 340, '2026-04-19 02:00:00'),
(22, 26, 740, 268, '2026-04-19 03:00:00'),
(23, 27, 760, 280, '2026-04-19 04:00:00'),
(24, 29, 770, 288, '2026-04-19 05:00:00'),
(25, 30, 745, 270, '2026-04-19 06:00:00'),
(26, 31, 760, 275, '2026-04-19 07:00:00'),
(27, 32, 770, 285, '2026-04-19 08:00:00'),
(28, 33, 780, 290, '2026-04-19 09:00:00');

/*
---------------------------------------------------------
                     SELECTS
---------------------------------------------------------
*/


-- SELECT QUE MOSTRA OS DADOS DA EMPRESA, ESTUFAS, TIPOS DE ALFACES PLANTADOS E SEUS RESPECTIVOS DADOS SOBRE A LUMINOSIDADE (IDEAL, BAIXO E ALERTA)
SELECT e.razaoSocial AS Empresa, CONCAT(en.rua, ', Nº ', en.numero) AS Endereço, est.nomeEstufa AS Estufa, est.statusEstufa AS 'Status', ta.tipoAlface AS 'Tipo de alface', l.lux AS Lux, l.ppfd AS PPFD, l.dataHora AS 'Data e hora',
CASE
    WHEN l.ppfd < 250 THEN 'Baixo'
    WHEN l.ppfd BETWEEN 250 AND 300 THEN 'Ideal'
    ELSE 'Alerta!'
END AS 'Status Luminosidade' FROM Empresa AS e
    JOIN Estufa AS est ON est.fkEmpresa = e.idEmpresa
		JOIN Endereco AS en ON est.fkEndereco = en.idEndereco
			JOIN estufa_tipoAlface AS eta ON eta.fkEstufa = est.idEstufa AND eta.fkEmpresa = est.fkEmpresa
				JOIN tipoAlface AS ta ON ta.idTipoAlface = eta.fkTipoAlface
					JOIN Sensor AS s ON s.fkEstufa = est.idEstufa
						JOIN Leituras AS l ON l.fkSensor = s.idSensor;
                    
-- SELECT QUE MOSTRA EMPRESA, ESTUFA, STATUS DA ESTUFA, E SENSOR DAS EMPRESAS QUE ESTÃO SEM LEITURA
-- Identifica estufas que não possuem leitura, indicando possível falha no sensor ou inatividade
SELECT e.razaoSocial AS Empresa, CONCAT(en.rua, ', Nº ', en.numero) AS Endereco, est.nomeEstufa AS Estufa, est.statusEstufa AS Status, IFNULL(s.nomeSensor, 'Sem sensor') AS Sensor, IFNULL(l.ppfd, 'Sem leitura') AS PPFD FROM Empresa AS e
    LEFT JOIN Estufa AS est ON est.fkEmpresa = e.idEmpresa
		LEFT JOIN Endereco AS en ON est.fkEndereco = en.idEndereco
			LEFT JOIN Sensor AS s ON s.fkEstufa = est.idEstufa
				LEFT JOIN Leituras AS l ON l.fkSensor = s.idSensor
					WHERE l.idLeituras IS NULL;


-- SELECT QUE MOSTRA A SITUAÇÃO COMPLETA DAS ESTUFAS, INCLUINDO EMPRESA, TIPO DE ALFACE, SENSOR E STATUS DA LUMINOSIDADE
-- Classifica automaticamente os dados em "Sem leitura", "Baixo", "Ideal" e "Alerta"
SELECT e.razaoSocial AS Empresa, CONCAT(en.rua, ', Nº ', en.numero) AS Endereco, est.nomeEstufa AS Estufa, est.statusEstufa AS StatusEstufa, ta.tipoAlface AS TipoAlface, s.nomeSensor AS Sensor, l.ppfd AS PPFD,
CASE
    WHEN l.ppfd IS NULL THEN 'Sem leitura'
    WHEN l.ppfd < 250 THEN 'Baixo'
    WHEN l.ppfd BETWEEN 250 AND 300 THEN 'Ideal'
    ELSE 'Alerta'
END AS 'Status Luminosidade' FROM Empresa AS e
    JOIN Estufa AS est ON est.fkEmpresa = e.idEmpresa
		JOIN Endereco AS en ON est.fkEndereco = en.idEndereco
			LEFT JOIN estufa_tipoAlface AS eta ON eta.fkEstufa = est.idEstufa AND eta.fkEmpresa = est.fkEmpresa
				LEFT JOIN tipoAlface AS ta ON ta.idTipoAlface = eta.fkTipoAlface
					LEFT JOIN Sensor AS s ON s.fkEstufa = est.idEstufa
						LEFT JOIN Leituras AS l ON l.fkSensor = s.idSensor;
                        
                        
SELECT e.razaoSocial AS Empresa, est.nomeEstufa AS Estufa, ta.tipoAlface AS TipoAlface, l.ppfd AS 'PPFD Atual', ta.ppfdMin AS 'PPFD Minimo', ta.ppfdMax AS 'PPFD Maximo',
CASE
    WHEN l.ppfd BETWEEN ta.ppfdMin AND ta.ppfdMax THEN 'Na faixa ideal'
    ELSE 'Fora da faixa'
END AS 'Status PPFD' FROM Empresa AS e
    JOIN Estufa AS est ON est.fkEmpresa = e.idEmpresa
		JOIN estufa_tipoAlface AS eta ON eta.fkEstufa = est.idEstufa AND eta.fkEmpresa = est.fkEmpresa
			JOIN tipoAlface AS ta ON ta.idTipoAlface = eta.fkTipoAlface
				JOIN Sensor AS s ON s.fkEstufa = est.idEstufa
					JOIN Leituras AS l ON l.fkSensor = s.idSensor;


-- Criação da View que retorna os valores que estão sendo implementados na Dashboard
        

-- Criação da View que retorna os valores que estão sendo implementados na Dashboard
        
CREATE VIEW vwDashboard AS
SELECT 
fkSensor,
ppfd,
dli,
dataHora
FROM Leituras;

SELECT ppfd, dli 
FROM vwDashboard 
WHERE fkSensor = 1 
ORDER BY dataHora DESC 
LIMIT 12;
