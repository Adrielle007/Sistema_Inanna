-- ATIVIDADE SOLICITADA - INANNA SISTEMA DE GESTÃO PARA BELEZA E ESTETICA




CREATE DATABASE IF NOT EXISTS inanna;
USE inanna;

-- 1. Criação da Tabela A (Lado "1" - Pai)
CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

-- 2. Criação da Tabela B (Lado "N" - Filho)
CREATE TABLE Servico (
    id_servico INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    duracao TIME,
    preco DECIMAL(10,2),
    id_categoria INT,
    id_estabelecimento INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- ==========================================
-- PARTE 1.1: INSERÇÃO NA TABELA A (CATEGORIA)
-- ==========================================
INSERT INTO Categoria (id_categoria, nome, descricao) VALUES (1, 'Cabelo', 'Serviços de corte, pintura e tratamento capilar.');
INSERT INTO Categoria (id_categoria, nome, descricao) VALUES (2, 'Barba', 'Serviços de barbearia tradicional e moderna.');
INSERT INTO Categoria (id_categoria, nome, descricao) VALUES (3, 'Unhas', 'Serviços de manicure e pedicure.');
INSERT INTO Categoria (id_categoria, nome, descricao) VALUES (4, 'Estética Facial', 'Tratamentos e limpeza de pele para o rosto.');
INSERT INTO Categoria (id_categoria, nome, descricao) VALUES (5, 'Estética Corporal', 'Massagens e procedimentos corporais.');
INSERT INTO Categoria (id_categoria, nome, descricao) VALUES (6, 'Sobrancelhas', 'Design e micropigmentação de sobrancelhas.');
INSERT INTO Categoria (id_categoria, nome, descricao) VALUES (7, 'Depilação', 'Serviços de depilação com cera e laser.');
INSERT INTO Categoria (id_categoria, nome, descricao) VALUES (8, 'Maquiagem', 'Serviços de maquiagem profissional para eventos.');

-- ==========================================
-- PARTE 1.2: INSERÇÃO NA TABELA B (SERVICO)
-- ==========================================

-- Categoria 1 (Cabelo) - 2 serviços
INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (1, 'Corte Masculino', 'Corte moderno com acabamento.', '00:30:00', 50.00, 1, 1);

INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (2, 'Hidratação Capilar', 'Hidratação profunda.', '01:00:00', 90.00, 1, 1);

-- Categoria 2 (Barba) - 2 serviços
INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (3, 'Barba Completa', 'Barba com toalha quente.', '00:30:00', 40.00, 2, 1);

INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (4, 'Design de Barba', 'Alinhamento rápido.', '00:20:00', 25.00, 2, 1);

-- Categoria 3 (Unhas) - 2 serviços
INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (5, 'Manicure', 'Cutilagem e esmaltação.', '00:40:00', 35.00, 3, 1);

INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (6, 'Pedicure', 'Cutilagem e esmaltação dos pés.', '00:45:00', 40.00, 3, 1);

-- Categoria 4 (Estética Facial) - 2 serviços
INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (7, 'Limpeza de Pele', 'Remoção de impurezas.', '01:30:00', 120.00, 4, 1);

INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (8, 'Peeling Facial', 'Renovação celular.', '01:00:00', 150.00, 4, 1);

-- Categoria 5 (Estética Corporal) - 2 serviços
INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (9, 'Massagem Relaxante', 'Alívio de tensões.', '01:00:00', 100.00, 5, 1);

INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (10, 'Drenagem Linfática', 'Redução de líquidos.', '01:00:00', 110.00, 5, 1);

-- Categoria 6 (Sobrancelhas) - 2 serviços
INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (11, 'Design de Sobrancelha', 'Modelagem.', '00:30:00', 40.00, 6, 1);

INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (12, 'Depilação com Linha', 'Coloração e alinhamento.', '00:40:00', 60.00, 6, 1);

-- Categoria 7 (Depilação) - 4 serviços (Mínimo exigido para testes de agrupamento)
INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (13, 'Depilação Perna Inteira', 'Com cera.', '00:50:00', 80.00, 7, 1);

INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (14, 'Depilação Axilas', 'Remoção de pelos.', '00:20:00', 30.00, 7, 1);

INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (15, 'Depilação Buço', 'Pelos faciais.', '00:15:00', 20.00, 7, 1);

INSERT INTO Servico (id_servico, nome, descricao, duracao, preco, id_categoria, id_estabelecimento) 
VALUES (16, 'Depilação Meia Perna', 'Parte inferior.', '00:30:00', 50.00, 7, 1);

-- Categoria 8 (Maquiagem) - 0 registros inseridos (Exatamente como pedido: cadastrada na Tabela A, mas sem filhos na Tabela B)


SELECT nome, preco 
FROM Servico 
ORDER BY preco DESC;

SELECT s.nome AS servico, c.nome AS categoria, s.preco
FROM Servico s
INNER JOIN Categoria c ON s.id_categoria = c.id_categoria;

SELECT c.id_categoria, c.nome AS categoria, s.nome AS servico
FROM Categoria c
LEFT JOIN Servico s ON c.id_categoria = s.id_categoria;

SELECT c.nome AS categoria, COUNT(s.id_servico) AS total_servicos
FROM Categoria c
LEFT JOIN Servico s ON c.id_categoria = s.id_categoria
GROUP BY c.id_categoria, c.nome
ORDER BY total_servicos DESC;

SELECT c.nome AS categoria, COUNT(s.id_servico) AS total_servicos
FROM Categoria c
INNER JOIN Servico s ON c.id_categoria = s.id_categoria
GROUP BY c.id_categoria, c.nome
HAVING COUNT(s.id_servico) >= 2;

