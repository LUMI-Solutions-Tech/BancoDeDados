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
    qtdEstufas INT,
    fkEndereco INT,
    CONSTRAINT fk_empresa_endereco FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco)
);

INSERT INTO Empresa (cnpj, razaoSocial, qtdEstufas, fkEndereco) VALUES
('67890123000106', 'BioEstufa Ltda', 1, 6),
('12345678000101', 'Verde Vida Ltda', 3, 1),
('23456789000102', 'AgroLuz SA', 5, 2),
('90123456000109', 'PlantaLux ME', 4, 9),
('34567890000103', 'Cultiva Tech Ltda', 2, 3),
('89012345000108', 'HidroGrow Ltda', 2, 8),
('56789012000105', 'LumiFarm Ltda', 6, 5),
('78901234000107', 'NutriVerde SA', 3, 7),
('45678901000104', 'FotoFarm ME', 4, 4),
('01234567000110', 'CresceLuz Ltda', 5, 10);

CREATE TABLE Usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    fkUsuarioEmpresa INT,
    CONSTRAINT fk_usuario_empresa FOREIGN KEY (fkUsuarioEmpresa) REFERENCES Empresa(idEmpresa)
);

INSERT INTO Usuario (nome, telefone, email, senha, cargo, fkUsuarioEmpresa) VALUES
('Ana Souza', '11958470101', 'ana@email.com', 'Ana123', 'Admin', 1),
('Pedro Silva', '11988887777', 'pedro@email.com', 'roca123', 'Operador de Estufa', 1),
('Bruno Lima', '11959887141', 'bruno@email.com', 'Bruno123', 'Admin', 2),
('Lucas Ferreira', '11991234567', 'lucas@email.com', 'campo456', 'Operador de Estufa', 2),
('Carla Mendes', '11966230121', 'carla@email.com', 'Carla123', 'Admin', 3),
('Marcos Oliveira', '11992345678', 'marcos@email.com', 'estufa789', 'Operador de Estufa', 3),
('Felipe Santos', '11993456789', 'felipe.santos@email.com', 'tec123', 'Tecnico', 3),
('Diego Ramos', null, 'diego@email.com', 'Diego123', 'Admin', 4),
('Rafael Costa', '11994567890', 'rafael@email.com', 'plantacao321', 'Operador de Estufa', 4),
('Elaine Ferreira', '11995571461', 'elaine@email.com', 'Elaine123', 'Admin', 5),
('Felipe Costa', '11954546132', 'felipe@email.com', 'Felipe123', 'Tecnico', 6),
('Gabriela Nunes', '11917729301', 'gabi@email.com', 'Gabi@2024', 'Operador de Estufa', 7),
('Henrique Alves', '11973317054', 'henrique@email.com', 'Henrique123', 'Operador de Estufa', 8),
('Isabela Rocha', null, 'isa@email.com', 'Isa123', 'Admin', 9),
('Joao Martins', '11993021014', 'joao@email.com', 'Joao123', 'Tecnico', 10);

CREATE TABLE tipoAlface (
    idTipoAlface INT PRIMARY KEY AUTO_INCREMENT,
    unMedIdeal INT,
    dliIdeal INT,
    tipoAlface CHAR(9),
    CONSTRAINT chkTipoAlface CHECK(tipoAlface IN('Crespa', 'Americana'))
);

INSERT INTO tipoAlface (tipoAlface, unMedIdeal, dliIdeal) VALUES
('Americana', 275, 16),
('Crespa', 250, 15);

CREATE TABLE Estufa (
	idEstufa INT,
	fkEmpresa INT,
	CONSTRAINT fk_estufa_empresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
	nomeEstufa VARCHAR(150) NOT NULL,
	infraestrutura VARCHAR(100),
	statusEstufa VARCHAR(30) NOT NULL,
    CONSTRAINT chkStatus CHECK(statusEstufa IN('Ativo', 'Inativo', 'Manutenção')),
	CONSTRAINT pkCompostaEstufa PRIMARY KEY(idEstufa, fkEmpresa),
    fkTipoAlface INT,
    CONSTRAINT fk_estufa_alface FOREIGN KEY (fkTipoAlface) REFERENCES tipoAlface(idTipoAlface)
);

INSERT INTO Estufa (idEstufa, fkEmpresa, nomeEstufa, infraestrutura, statusEstufa, fkTipoAlface) VALUES
(1, 1, 'Viveiro Verde Vida', 'LED Full Spectrum', 'Ativo', 2),
(2, 1, 'Estufa do Sítio', 'HPS 600W', 'Ativo', 1),
(3, 1, 'Cultivo Primavera', 'CMH 315W', 'Ativo', 2),
(4, 2, 'B1', 'LED Full Spectrum', 'Ativo', 1),
(5, 2, 'B2', 'CMH 315W', 'Inativo', 2),
(6, 2, 'B3', 'HPS 600W', 'Ativo', 1),
(7, 2, 'B4', 'Fluorescente T5', 'Manutenção', 2),
(8, 3, 'Estufa Tecnológica', 'LED Full Spectrum', 'Ativo', 1),
(9, 3, 'Produção Inteligente', 'Fluorescente T5', 'Ativo', 2),
(10, 4, 'D1', 'LED Full Spectrum', 'Ativo', 1),
(11, 4, 'D2', 'HPS 1000W', 'Inativo', 2),
(12, 4, 'D3', 'CMH 630W', 'Ativo', 1),
(13, 5, 'Estufa da Fazenda', 'LED Full Spectrum', 'Ativo', 2),
(14, 5, 'Área de Cultivo 1', 'CMH 630W', 'Ativo', 1),
(15, 5, 'Área de Cultivo 2', 'HPS 600W', 'Ativo', 2),
(16, 5, 'Produção Hidropônica', 'Fluorescente T5', 'Ativo', 1),
(17, 5, 'Estufa Sol Nascente', 'LED Full Spectrum', 'Ativo', 2),
(18, 6, 'Estufa Principal', 'LED Full Spectrum', 'Ativo', 1),
(19, 7, 'Setor Sul', 'LED Full Spectrum', 'Ativo', 2),
(20, 7, 'Setor Leste', 'Fluorescente T5', 'Ativo', 1),
(21, 8, 'Cultivo Crespa', 'LED Full Spectrum', 'Ativo', 2),
(22, 8, 'Cultivo Americana', 'CMH 315W', 'Ativo', 1),
(23, 9, 'Estufa Experimental', 'LED Full Spectrum', 'Ativo', 2),
(24, 9, 'Produção Avançada', 'HPS 600W', 'Inativo', 1),
(25, 9, 'Cultivo Premium', 'CMH 315W', 'Ativo', 2),
(26, 10, 'J1', 'LED Full Spectrum', 'Ativo', 1),
(27, 10, 'J2', 'CMH 630W', 'Ativo', 2),
(28, 10, 'J3', 'HPS 600W', 'Manutenção', 1),
(29, 10, 'J4', 'Fluorescente T5', 'Ativo', 2);

CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nomeSensor VARCHAR(100) NOT NULL,
    statusSensor CHAR(10) NOT NULL,
	CONSTRAINT chkStsSensor CHECK(statusSensor IN('Ativo', 'Inativo', 'Manutenção')),
    fkEstufa INT,
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
    idLeituras INT PRIMARY KEY AUTO_INCREMENT,
    lux INT,
    unMed INT,
    dataHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
    CONSTRAINT fk_leituras_sensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);

INSERT INTO Leituras (lux, unMed, dataHora, fkSensor) VALUES
(750, 275, '2026-04-18 06:00:00', 1),
(720, 260, '2026-04-18 07:00:00', 2),
(780, 290, '2026-04-18 08:00:00', 3),
(700, 255, '2026-04-18 09:00:00', 4),
(740, 270, '2026-04-18 10:00:00', 6),
(710, 258, '2026-04-18 11:00:00', 8),
(600, 220, '2026-04-18 12:00:00', 9),
(580, 210, '2026-04-18 13:00:00', 10),
(770, 285, '2026-04-18 14:00:00', 11),
(730, 265, '2026-04-18 15:00:00', 12),
(760, 275, '2026-04-18 16:00:00', 13),
(745, 268, '2026-04-18 17:00:00', 14),
(900, 320, '2026-04-18 18:00:00', 16),
(765, 282, '2026-04-18 19:00:00', 17),
(735, 266, '2026-04-18 20:00:00', 18),
(748, 272, '2026-04-18 21:00:00', 19),
(610, 230, '2026-04-18 22:00:00', 20),
(780, 290, '2026-04-18 23:00:00', 21),
(770, 285, '2026-04-19 00:00:00', 22),
(760, 275, '2026-04-19 01:00:00', 23),
(920, 340, '2026-04-19 02:00:00', 25),
(740, 268, '2026-04-19 03:00:00', 26),
(760, 280, '2026-04-19 04:00:00', 27),
(770, 288, '2026-04-19 05:00:00', 29),
(745, 270, '2026-04-19 06:00:00', 30),
(760, 275, '2026-04-19 07:00:00', 31),
(770, 285, '2026-04-19 08:00:00', 32),
(780, 290, '2026-04-19 09:00:00', 33);

INSERT INTO Leituras (lux, unMed, dataHora, fkSensor) VALUES
(750, 275, '2026-04-18 06:00:00', 1),
(720, 260, '2026-04-18 07:00:00', 2),
(780, 290, '2026-04-18 08:00:00', 3),
(700, 255, '2026-04-18 09:00:00', 4),
(740, 270, '2026-04-18 10:00:00', 6),
(710, 258, '2026-04-18 11:00:00', 8),
(600, 220, '2026-04-18 12:00:00', 9),
(770, 285, '2026-04-18 13:00:00', 10),
(730, 265, '2026-04-18 14:00:00', 11),
(760, 275, '2026-04-18 15:00:00', 12),
(745, 268, '2026-04-18 16:00:00', 13),
(910, 315, '2026-04-18 17:00:00', 14),
(765, 282, '2026-04-18 18:00:00', 16),
(735, 266, '2026-04-18 19:00:00', 17),
(610, 230, '2026-04-18 20:00:00', 18),
(780, 290, '2026-04-18 21:00:00', 19),
(770, 285, '2026-04-18 22:00:00', 20),
(920, 330, '2026-04-19 08:00:00', 16),
(940, 340, '2026-04-19 09:00:00', 18),
(910, 320, '2026-04-19 10:00:00', 19),
(750, 275, '2026-04-19 11:00:00', 20),
(760, 280, '2026-04-19 12:00:00', 21),
(760, 275, '2026-04-19 13:00:00', 22),
(740, 268, '2026-04-19 14:00:00', 23),
(770, 288, '2026-04-19 15:00:00', 26),
(745, 270, '2026-04-19 16:00:00', 27),
(760, 275, '2026-04-19 17:00:00', 29),
(770, 285, '2026-04-19 18:00:00', 30),
(780, 290, '2026-04-19 19:00:00', 31);

-- Status_Assinatura depende de Clientes
-- Essa tabela não foi criada, ficará para a próxima SPRINT
CREATE TABLE Status_Assinatura (
    idStatus INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT,
    status VARCHAR(10),
    planoContrato VARCHAR(20),
    dataVencimento DATE,
    fkClientesAssinatura INT,
    CONSTRAINT fk_status_cliente FOREIGN KEY (fkClientesAssinatura) REFERENCES Clientes(idClientes)
);


/*
---------------------------------------------------------
						SELECTS
---------------------------------------------------------
*/


-- SELECT QUE MOSTRA OS DADOS DA EMPRESA, ESTUFAS, TIPOS DE ALFACES PLANTADOS E SEUS RESPECTIVOS DADOS SOBRE A LUMINOSIDADE (IDEAL, BAIXO E ALERTA)
SELECT e.razaoSocial AS Empresa, CONCAT(en.rua, ', Nº ', en.numero) AS Endereço, est.nomeEstufa AS Estufa, est.statusEstufa AS 'Status', ta.tipoAlface AS 'Tipo de alface', l.lux AS Lux, l.unMed AS PPFD, l.dataHora AS 'Data e hora',
CASE 
WHEN l.unMed < 250 THEN 'Baixo'
WHEN l.unMed BETWEEN 250 AND 300 THEN 'Ideal'
ELSE 'Alerta!'
END AS 'Status Luminosidade' FROM Empresa AS e
	JOIN Endereco AS en ON e.fkEndereco = en.idEndereco
		JOIN Estufa AS est ON est.fkEmpresa = e.idEmpresa
			JOIN tipoAlface AS ta ON est.fkTipoAlface = ta.idTipoAlface
				JOIN Sensor AS s ON s.fkEstufa = est.idEstufa
					JOIN Leituras AS l ON l.fkSensor = s.idSensor;
                    
-- SELECT QUE MOSTRA EMPRESA, ESTUFA, STATUS DA ESTUFA, E SENSOR DAS EMPRESAS QUE ESTÃO SEM LEITURA
-- Identifica estufas que não possuem leitura, indicando possível falha no sensor ou inatividade
SELECT e.razaoSocial AS Empresa, CONCAT(en.rua, ', Nº ', en.numero) AS Endereco, est.nomeEstufa AS Estufa, est.statusEstufa AS Status, IFNULL(s.nomeSensor, 'Sem sensor') AS Sensor, IFNULL(l.unMed, 'Sem leitura') AS PPFD FROM Empresa AS e
	JOIN Endereco AS en ON e.fkEndereco = en.idEndereco
		LEFT JOIN Estufa AS est ON est.fkEmpresa = e.idEmpresa
			LEFT JOIN Sensor AS s ON s.fkEstufa = est.idEstufa
				LEFT JOIN Leituras AS l ON l.fkSensor = s.idSensor
					WHERE l.idLeituras IS NULL;


-- SELECT QUE MOSTRA A SITUAÇÃO COMPLETA DAS ESTUFAS, INCLUINDO EMPRESA, TIPO DE ALFACE, SENSOR E STATUS DA LUMINOSIDADE
-- Classifica automaticamente os dados em "Sem leitura", "Baixo", "Ideal" e "Alerta"
SELECT e.razaoSocial AS Empresa, CONCAT(en.rua, ', Nº ', en.numero) AS Endereco, est.nomeEstufa AS Estufa, est.statusEstufa AS StatusEstufa, ta.tipoAlface AS TipoAlface, s.nomeSensor AS Sensor, l.unMed AS PPFD,
CASE 
WHEN l.unMed IS NULL THEN 'Sem leitura'
WHEN l.unMed < 250 THEN 'Baixo'
WHEN l.unMed BETWEEN 250 AND 300 THEN 'Ideal'
ELSE 'Alerta'
END AS 'Status Luminosidade' FROM Empresa AS e
	JOIN Endereco AS en ON e.fkEndereco = en.idEndereco
		JOIN Estufa AS est ON est.fkEmpresa = e.idEmpresa
			LEFT JOIN tipoAlface AS ta ON est.fkTipoAlface = ta.idTipoAlface
				LEFT JOIN Sensor AS s ON s.fkEstufa = est.idEstufa
					LEFT JOIN Leituras AS l ON l.fkSensor = s.idSensor;