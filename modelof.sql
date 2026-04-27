CREATE DATABASE viva_segura;
USE viva_segura;

-- =========================
-- USUARIO
-- =========================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(25),
    cpf CHAR(11) UNIQUE,
    email VARCHAR(25) UNIQUE,
    senha VARCHAR(10),
    data_nascimento DATE
);

-- =========================
-- ENDERECO
-- =========================
CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(30),
    numero VARCHAR(25),
    bairro VARCHAR(50),
    cep CHAR(8),
    complemento VARCHAR(50),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================
-- TELEFONE
-- =========================
CREATE TABLE telefone (
    id_telefone INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(15),
    ddd VARCHAR(5),
    operadora VARCHAR(15),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================
-- MEDIDA PROTETIVA
-- =========================
CREATE TABLE medida_protetiva (
    id_medida INT AUTO_INCREMENT PRIMARY KEY,
    numero_processo VARCHAR(20),
    data_inicio DATE,
    data_fim DATE,
    descricao TEXT,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================
-- DENUNCIA
-- =========================
CREATE TABLE denuncia (
    id_denuncia INT AUTO_INCREMENT PRIMARY KEY,
    descricao TEXT,
    data_denuncia DATE,
    horario TIME,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================
-- EMERGENCIA
-- =========================
CREATE TABLE emergencia (
    id_emergencia INT AUTO_INCREMENT PRIMARY KEY,
    localizacao VARCHAR(25),
    data DATE,
    horario TIME,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================
-- CHECK-IN VIRTUAL
-- =========================
CREATE TABLE checkin_virtual (
    id_checkin INT AUTO_INCREMENT PRIMARY KEY,
    localizacao VARCHAR(25),
    data_hora DATETIME,
    status_seguranca VARCHAR(10),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================
-- PROFISSIONAL
-- =========================
CREATE TABLE profissional (
    id_profissional INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(25),
    data_nascimento DATE,
    sexo VARCHAR(10),
    setor VARCHAR(50)
);

-- =========================
-- ATENDIMENTO
-- =========================
CREATE TABLE atendimento (
    id_atendimento INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    protocolo VARCHAR(20),
    descricao TEXT,
    id_usuario INT,
    id_profissional INT,
    id_emergencia INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_profissional) REFERENCES profissional(id_profissional),
    FOREIGN KEY (id_emergencia) REFERENCES emergencia(id_emergencia)
);

-- =========================
-- SERVICOS
-- =========================
CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(25),
    descricao TEXT
);

-- =========================
-- ATENDIMENTO_SERVICO (N:N)
-- =========================
CREATE TABLE atendimento_servico (
    id_atendimento INT,
    id_servico INT,
    PRIMARY KEY (id_atendimento, id_servico),
    FOREIGN KEY (id_atendimento) REFERENCES atendimento(id_atendimento),
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
);

-- =========================
-- CURSOS
-- =========================
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(25),
    carga_horaria INT
);

-- =========================
-- TIPO CURSO
-- =========================
CREATE TABLE tipo_curso (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nome_tipo VARCHAR(25)
);

-- RELAÇÃO CURSO -> TIPO
ALTER TABLE cursos
ADD id_tipo INT,
ADD FOREIGN KEY (id_tipo) REFERENCES tipo_curso(id_tipo);

-- =========================
-- EMPREGOS
-- =========================
CREATE TABLE empregos (
    id_emprego INT AUTO_INCREMENT PRIMARY KEY,
    cargo VARCHAR(50),
    setor VARCHAR(50)
);

-- =========================
-- TIPO EMPREGO
-- =========================
CREATE TABLE tipo_emprego (
    id_tipo_emprego INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(50)
);

-- RELAÇÃO EMPREGO -> TIPO
ALTER TABLE empregos
ADD id_tipo_emprego INT,
ADD FOREIGN KEY (id_tipo_emprego) REFERENCES tipo_emprego(id_tipo_emprego);

-- =========================
-- SERVICO_CURSO (N:N)
-- =========================
CREATE TABLE servico_curso (
    id_servico INT,
    id_curso INT,
    PRIMARY KEY (id_servico, id_curso),
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

-- =========================
-- SERVICO_EMPREGOS (N:N)
-- =========================
CREATE TABLE servico_emprego (
    id_servico INT,
    id_emprego INT,
    PRIMARY KEY (id_servico, id_emprego),
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico),
    FOREIGN KEY (id_emprego) REFERENCES empregos(id_emprego)
);