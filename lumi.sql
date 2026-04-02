-- Tabelas independentes (sem FK)
CREATE TABLE Alface_Americana (
    idAlface_Americana INT PRIMARY KEY AUTO_INCREMENT,
    ppfd_ideal INT,
    dli_ideal INT,
    foto_periodo INT
);

CREATE TABLE Alface_Crespa (
    idAlface_Crespa INT PRIMARY KEY AUTO_INCREMENT,
    ppfd_ideal INT,
    dli_ideal INT,
    foto_periodo INT
);

CREATE TABLE Clientes (
    idClientes INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    telefone VARCHAR(15),
    email VARCHAR(100),
    senha VARCHAR(255),
    id_empresa INT
);

-- Empresa depende de Clientes
CREATE TABLE Empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    cnpj CHAR(14),
    razao_social VARCHAR(100),
    CEP CHAR(8),
    qtd_estufas INT,
    numero VARCHAR(20),
    complemento VARCHAR(80),
    origem VARCHAR(45),
    fkCliente_empresa INT,
    CONSTRAINT fk_empresa_cliente FOREIGN KEY (fkCliente_empresa) REFERENCES Clientes(idClientes)
);

-- Atualiza FK de Clientes -> Empresa
ALTER TABLE Clientes
    ADD CONSTRAINT fk_clientes_empresa FOREIGN KEY (id_empresa) REFERENCES Empresa(idEmpresa);

-- Status_Assinatura depende de Clientes
CREATE TABLE Status_Assinatura (
    idStatus INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    status VARCHAR(10),
    plano_contrato VARCHAR(20),
    data_vencimento DATE,
    fkClientes_assinatura INT,
    CONSTRAINT fk_status_cliente FOREIGN KEY (fkClientes_assinatura) REFERENCES Clientes(idClientes)
);

-- Sensor depende de Empresa
CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    id_empresa INT,
    nome_estufa VARCHAR(45),
    infraestrutura_estufa VARCHAR(45),
    status_sensor VARCHAR(20),
    fk_sensor_Empresa INT,
    CONSTRAINT fk_sensor_empresa FOREIGN KEY (fk_sensor_Empresa) REFERENCES Empresa(idEmpresa)
);

-- Leituras depende de Sensor
CREATE TABLE Leituras (
    idLeituras INT PRIMARY KEY AUTO_INCREMENT,
    id_Sensor INT,
    lux DECIMAL(10,2),
    ppfd DECIMAL(10,2),
    data_hora DATETIME,
    CONSTRAINT fk_leituras_sensor FOREIGN KEY (id_Sensor) REFERENCES Sensor(idSensor)
);

-- DLI_Diario depende de Sensor
CREATE TABLE DLI_Diario (
    idDLI INT PRIMARY KEY AUTO_INCREMENT,
    id_sensor INT,
    data DATE,
    dli_total DECIMAL(5,2),
    meta DECIMAL(5,2),
    status VARCHAR(20),
    CONSTRAINT fk_dli_diario_sensor FOREIGN KEY (id_sensor) REFERENCES Sensor(idSensor)
);

-- DLI_Mensal depende de Sensor
CREATE TABLE DLI_Mensal (
    idDLI_Mensal INT PRIMARY KEY AUTO_INCREMENT,
    id_sensor INT,
    mes DATE,
    dli_medio_mes DECIMAL(5,2),
    dias_ideais INT,
    dias_abaixo INT,
    dias_acima INT,
    CONSTRAINT fk_dli_mensal_sensor FOREIGN KEY (id_sensor) REFERENCES Sensor(idSensor)
);


