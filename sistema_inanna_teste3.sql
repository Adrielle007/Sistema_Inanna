-- vou remover o banco de dados caso ele ja exista 
DROP DATABASE IF EXISTS Inanna;

-- agora vou criar e seleconar meu banco de dados

 CREATE DATABASE Inanna;
 USE inanna;
 
 CREATE TABLE Cliente (
 -- vou colocar  id_cliente como chave primaria, porque é o que vai identificar meu cliente.
 
 id_cliente INT UNSIGNED NOT NULL PRIMARY KEY,
 
 -- Vou colocar nome como meu atributo simples
 
 nome VARCHAR(125) NOT NULL,
 
 -- o CPF vai ser outro atributo simples ja que eu atribui o id_cliente como chave primaria. Descobri que o REGEX funciona como uma máscra ou um filtro de segurança, garante que o texto seja formado apenas por 111 números.
 
CPF CHAR(11) NOT NULL UNIQUE CHECK (CPF REGEXP '^[0-9]{11}$'),
 
 -- Fiz uma pesquisa porque fiquei em dúvida qual tipo de dado eu deveria colocar para quardar a informação da data de nascimento, fiquei entre o INT e o VARCHAR, descobri que é melhor usar o DATE  porqu ele vai me dar um validação automatica, função de data pronta e economia de espaço.
 -- Descobri que o CURRENT_DATE bloqueia datas maiores que o dia de hoje.

data_nascimento DATE NOT NULL,

telefone VARCHAR(20)
 );
 
 
 -- Faremos uma outra tabela de email para que a primeira forma, mantendo a sua atomicidade.alter
 
CREATE TABLE ClienteEmail(
id_cliente INT UNSIGNED NOT NULL,
email VARCHAR(100) NOT NULL,
-- Colocaremos uma chave primaria composta

PRIMARY KEY (id_cliente, email),
-- Agora vamos colocarc a nossa chave estrangeira e referenciar para que ela possa procurar na tabela certa.


CONSTRAINT FK_cliente_email
FOREIGN KEY (id_cliente)
REFERENCES cliente(id_cliente)
ON DELETE CASCADE
);

CREATE TABLE estabelecimento(
id_estabelecimento INT UNSIGNED NOT NULL PRIMARY KEY,
cnpj VARCHAR(14) NOT NULL UNIQUE,
razao_social VARCHAR(150) NOT NULL,
nome_fantasia VARCHAR (100),
telefone VARCHAR(20),
-- vou colocar agora um atributo composto que ue consigo desmembrar ele que é o endereço.
logradouro VARCHAR(150) NOT NULL,
numero VARCHAR(10) NOT NULL,
bairro VARCHAR(60) NOT NULL,
cidade VARCHAR(60) NOT NULL,
uf VARCHAR(2) NOT NULL,
cep VARCHAR(8) NOT NULL
);

CREATE TABLE EstabelecimentoEmail(
id_estabelecimento INT UNSIGNED NOT NULL,
email VARCHAR (100) NOT NULL,

PRIMARY KEY(id_estabelecimento, email),

CONSTRAINT FK_estabelecimento_email
FOREIGN KEY (id_estabelecimento)
REFERENCES estabelecimento(id_estabelecimento)
ON DELETE CASCADE
);

CREATE TABLE profissional(
id_profissional INT UNSIGNED NOT NULL PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE CHECK (CPF REGEXP '^[0-9]{11}$'),
telefone VARCHAR(20),
cargo VARCHAR(50) NOT NULL,
status VARCHAR(20) NOT NULL
);

CREATE TABLE ProfissionalEmail(
id_profissional INT UNSIGNED NOT NULL,
email VARCHAR(100) NOT NULL,

PRIMARY KEY(id_profissional, email),

CONSTRAINT FK_profissional_email
FOREIGN KEY (id_profissional)
REFERENCES profissional (id_profissional)
ON DELETE CASCADE
);

CREATE TABLE categoria(
id_categoria INT UNSIGNED NOT NULL PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
descricao VARCHAR(150) NOT NULL
);

CREATE TABLE servico(
id_servico INT UNSIGNED NOT NULL PRIMARY KEY,
id_profissional INT UNSIGNED NOT NULL,
nome VARCHAR(100) NOT NULL,
descricao VARCHAR(150) NOT NULL,
-- eu procurei porque eu nao sabia como colocar so o preço qual tipo seria o melhor e coloquei DECIMAL 
preco DECIMAL(10, 2) NOT NULL,
-- vou colocar uma referencial ao profissional, até porque não existiria serviço sem profisional.
CONSTRAINT FK_servico_profissional
FOREIGN KEY (id_profissional)
REFERENCES profissional(id_profissional)
ON DELETE CASCADE
);

CREATE TABLE agendamento(
id_agendamento INT UNSIGNED NOT NULL PRIMARY KEY,
-- vou colocar datas e horarios separados para facilitar as bauscas na agenda
data_agendamento DATE NOT NULL,
horario TIME NOT NULL,
-- Descobri que se usa TEXT caso o cliente queria escrever um texo longo
observcao TEXT NULL,
-- Agora tenho que colocar as minhas chaves estrangeiras

id_cliente INT UNSIGNED NOT NULL,
id_estabelecimento INT UNSIGNED NOT NULL,
id_profissional INT UNSIGNED NOT NULL,
id_servico INT UNSIGNED NOT NULL,
-- agora preciso criar as restrições 
CONSTRAINT FK_agendamento_cliente
         FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente),
    
CONSTRAINT FK_agendamento_estabelecimento
		  FOREIGN KEY (id_estabelecimento) REFERENCES estabelecimento(id_estabelecimento),
        
CONSTRAINT FK_agendamento_profissional
			FOREIGN KEY (id_profissional) REFERENCES profissional(id_profissional),
            
	CONSTRAINT FK_agendamento_servico
            FOREIGN KEY (id_servico) REFERENCES servico (id_servico)
            );
            
CREATE TABLE pagamento(
id_pagamento INT UNSIGNED NOT NULL PRIMARY KEY,
-- aqui preciso colocar um valor com precisão de centavos 
valor DECIMAL (10,2) NOT NULL,
data_pagamento DATE NOT NULL,
forma_pagamento VARCHAR(30) NOT NULL,
CONSTRAINT chk_forma_pagamento CHECK (forma_pagamento IN ('Cartão de Crédito', 'Cartão de Débito', 'Pix', 'Dinheiro')),
status VARCHAR(20) NOT NULL DEFAULT 'Pendente',
CONSTRAINT chk_status_pagamento CHECK (status IN ('Pendente', 'Pago', 'Reembolsado', 'Cancelado')),

-- agora eu vou colocar o relacionamento com o a gendamento, porque cada pagamento pertence a um agendamento
id_agendamento INT UNSIGNED NOT NULL,

CONSTRAINT FK_pagamento_agendamento
FOREIGN KEY (id_agendamento) REFERENCES agendamento (id_agendamento)
ON DELETE CASCADE
);




-- 5. INSERÇÃO DE DADOS (DML) - POVOAMENTO DO BANCO DE DADOS (CLÍNICA INANNA)


-- Inserindo Clientes (1FN: Endereço Atômico)
INSERT INTO Cliente (id_cliente, nome, CPF, data_nascimento, telefone) VALUES
(1, 'Juliana Mendes Rocha', '11122233344', '1995-05-12', '11988887777'),
(2, 'Mariana Costa Souza', '22233344455', '1988-10-22', '11977776666'),
(3, 'Lucas Almeida Santos', '33344455566', '2000-02-15', '11966665555');

-- Inserindo E-mails dos Clientes (1FN: Atributo Multivalorado resolvido)
INSERT INTO ClienteEmail (id_cliente, email) VALUES
(1, 'juliana.mendes@email.com'),
(1, 'juliana.pessoal@email.com'), -- Juliana com 2 e-mails cadastrados
(2, 'mariana.costa@email.com');
-- Lucas Almeida (id_cliente 3) escolheu não cadastrar e-mail.

-- Inserindo Estabelecimentos (Clínicas/Unidades)
INSERT INTO estabelecimento (id_estabelecimento, cnpj, razao_social, nome_fantasia, telefone, logradouro, numero, bairro, cidade, uf, cep) VALUES
(10, '12345678000199', 'Inanna Estetica Corporea Ltda', 'Inanna - Unidade Jardins', '1130034001', 'Alameda das Lorena', '450', 'Jardins', 'São Paulo', 'SP', '01424000'),
(20, '98765432000188', 'Inanna Estetica Facial Ltda', 'Inanna - Unidade Paulista', '1130034002', 'Avenida Paulista', '1000', 'Bela Vista', 'São Paulo', 'SP', '01310100');

-- Inserindo E-mails dos Estabelecimentos
INSERT INTO EstabelecimentoEmail (id_estabelecimento, email) VALUES
(10, 'jardins@inannaestetica.com'),
(20, 'paulista@inannaestetica.com');

-- Inserindo Profissionais (Especialistas da Clínica)
INSERT INTO profissional (id_profissional, nome, cpf, telefone, cargo, status) VALUES
(100, 'Dra. Beatriz Pinheiro', '44455566677', '11955554444', 'Biomédica Esteta', 'Ativo'),
(200, 'Dr. Thiago Medeiros', '55566677788', '11944443333', 'Dermatologista', 'Ativo'),
(300, 'Carla Vieira', '66677788899', '11933332222', 'Esteticista', 'Ativo');

-- Inserindo E-mails dos Profissionais
INSERT INTO ProfissionalEmail (id_profissional, email) VALUES
(100, 'dra.beatriz@inanna.com'),
(200, 'dr.thiago@inanna.com'),
(300, 'carla.estetica@inanna.com');

-- Inserindo Categorias de Serviços
INSERT INTO categoria (id_categoria, nome, descricao) VALUES
(1, 'Facial', 'Procedimentos voltados para o cuidado e rejuvenescimento do rosto'),
(2, 'Corporal', 'Procedimentos voltados para redução de medidas e contorno corporal');

-- Inserindo Serviços (Associados aos seus respectivos Profissionais executores)
INSERT INTO servico (id_servico, id_profissional, nome, descricao, preco) VALUES
(501, 300, 'Limpeza de Pele Profunda', 'Extração de impurezas, hidratação e peeling de diamante', 180.00),
(502, 100, 'Aplicação de Toxina Botulínica', 'Aplicação de botox na região da testa e olhos (por região)', 850.00),
(503, 200, 'Preenchimento Labial', 'Escultura e volume labial com ácido hialurônico (1ml)', 1200.00);

-- Inserindo Agendamentos (Conectando Cliente, Unidade, Profissional e Serviço)
INSERT INTO agendamento (id_agendamento, data_agendamento, horario, observcao, id_cliente, id_estabelecimento, id_profissional, id_servico) VALUES
(1001, '2026-11-10', '14:00:00', 'Cliente informou ter pele muito sensível.', 1, 10, 300, 501),
(1002, '2026-11-10', '15:30:00', NULL, 1, 10, 100, 502), -- Juliana fará dois procedimentos no mesmo dia!
(1003, '2026-11-11', '10:00:00', 'Retorno de procedimento anterior.', 2, 20, 200, 503);

-- Inserindo Pagamentos (Financeiro atrelado rigorosamente aos centavos do DECIMAL)
INSERT INTO pagamento (id_pagamento, valor, data_pagamento, forma_pagamento, status, id_agendamento) VALUES
(9001, 180.00, '2026-11-10', 'Pix', 'Pago', 1001),
(9002, 850.00, '2026-11-10', 'Cartão de Crédito', 'Pago', 1002),
(9003, 1200.00, '2026-11-11', 'Pix', 'Pendente', 1003);


-- CONSULTAS DEMONSTRATIVAS DAS FORMAS NORMAIS E RELACIONAMENTOS (DQL)



-- DEMONSTRAÇÃO DA 1FN (Consulta de Atributos Multivalorados)
-- Exibe todos os e-mails associados à cliente Juliana Mendes.

SELECT 
    c.nome AS 'Cliente',
    e.email AS 'E-mail Cadastrado'
FROM Cliente c
INNER JOIN ClienteEmail e ON c.id_cliente = e.id_cliente
WHERE c.id_cliente = 1;



-- DEMONSTRAÇÃO DE RELACIONAMENTO MULTIPLO (Visão Geral da Agenda da Clínica)
-- Reconstrói o fluxo: junta quem é o cliente, onde ele vai, quem vai atender 
-- e qual o procedimento com preço fixo acordado, ordenado por data.

SELECT 
    a.id_agendamento AS 'Nº Agendamento',
    DATE_FORMAT(a.data_agendamento, '%d/%m/%Y') AS 'Data',
    TIME_FORMAT(a.horario, '%H:%i') AS 'Horário',
    c.nome AS 'Cliente',
    est.nome_fantasia AS 'Unidade',
    p.nome AS 'Profissional (Especialista)',
    s.nome AS 'Procedimento Estético',
    s.preco AS 'Preço do Serviço'
FROM agendamento a
INNER JOIN Cliente c ON a.id_cliente = c.id_cliente
INNER JOIN estabelecimento est ON a.id_estabelecimento = est.id_estabelecimento
INNER JOIN profissional p ON a.id_profissional = p.id_profissional
INNER JOIN servico s ON a.id_servico = s.id_servico
ORDER BY a.data_agendamento, a.horario;



-- DEMONSTRAÇÃO FINANCEIRA (Análise de Faturamento com Agregação)
-- Exibe o total faturado (valores já pagos) agrupado por Unidade da Clínica.

SELECT 
    est.nome_fantasia AS 'Unidade Inanna',
    COUNT(pag.id_pagamento) AS 'Qtd de Pagamentos Recebidos',
    SUM(pag.valor) AS 'Total Faturado (R$)'
FROM pagamento pag
INNER JOIN agendamento a ON pag.id_agendamento = a.id_agendamento
INNER JOIN estabelecimento est ON a.id_estabelecimento = est.id_estabelecimento
WHERE pag.status = 'Pago'
GROUP BY est.id_estabelecimento, est.nome_fantasia;



 
 
 
 
 