-- vou remover o banco de dados caso ele ja exista 
DROP DATABASE IF EXISTS Inanna;

-- agora vou criar e selecionar meu banco de dados

 CREATE DATABASE Inanna;
 USE inanna;
 
 CREATE TABLE Cliente (
 -- vou colocar  id_cliente como chave primaria, porque é o que vai identificar meu cliente.
 
 id_cliente INT UNSIGNED NOT NULL PRIMARY KEY,
 
 -- Vou colocar nome como meu atributo simples
 
 nome VARCHAR(125) NOT NULL,
 
 -- o CPF vai ser outro atributo simples ja que eu atribui o id_cliente como chave primaria. Descobri que o REGEX funciona como uma máscra ou um filtro de segurança, garante que o texto seja formado apenas por 11 números.
 
CPF CHAR(11) NOT NULL UNIQUE CHECK (CPF REGEXP '^[0-9]{11}$'),
 
 -- Fiz uma pesquisa porque fiquei em dúvida qual tipo de dado eu deveria colocar para quardar a informação da data de nascimento, fiquei entre o INT e o VARCHAR, descobri que é melhor usar o DATE  porqu ele vai me dar um validação automatica, função de data pronta e economia de espaço.
 -- Descobri que o CURRENT_DATE bloqueia datas maiores que o dia de hoje.

data_nascimento DATE NOT NULL,

telefone VARCHAR(20)
 );
 
 
 -- Faremos uma outra tabela de email por causa da primeira norma, mantendo a sua atomicidade
 
CREATE TABLE ClienteEmail(
id_cliente INT UNSIGNED NOT NULL,
email VARCHAR(100) NOT NULL,
tipo VARCHAR(20) NOT NULL DEFAULT 'Pessoal',
principal BOOLEAN NOT NULL DEFAULT TRUE,
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
-- vou colocar agora um atributo composto que eu                                                                                                                                            consigo desmembrar ele que é o endereço.
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
setor VARCHAR(30) NOT NULL DEFAULT 'Atendimento',
ativo BOOLEAN NOT NULL DEFAULT TRUE,

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
telefone VARCHAR(20) NOT NULL,
cargo VARCHAR(50) NOT NULL,
status VARCHAR(20) NOT NULL DEFAULT 'Ativo'
);

CREATE TABLE ProfissionalEmail(
id_profissional INT UNSIGNED NOT NULL,
email VARCHAR(100) NOT NULL,
tipo VARCHAR(20) NOT NULL DEFAULT 'Corporativo',
ativo BOOLEAN NOT NULL DEFAULT TRUE,

PRIMARY KEY(id_profissional, email),

CONSTRAINT FK_profissional_email
FOREIGN KEY (id_profissional)
REFERENCES profissional (id_profissional)
ON DELETE CASCADE
);

CREATE TABLE categoria(
id_categoria INT UNSIGNED NOT NULL PRIMARY KEY,
nome VARCHAR(150) NOT NULL UNIQUE,
descricao VARCHAR(150) NOT NULL,
ativa BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE servico(
id_servico INT UNSIGNED NOT NULL PRIMARY KEY,
id_profissional INT UNSIGNED NOT NULL,
id_categoria INT UNSIGNED NOT NULL,
nome VARCHAR(100) NOT NULL,
descricao VARCHAR(150) NOT NULL,
-- eu procurei porque eu nao sabia como colocar so o preço qual tipo seria o melhor e coloquei DECIMAL 
preco DECIMAL(10, 2) NOT NULL CHECK (preco > 0),
-- vou colocar uma referencia ao profissional, até porque não existiria serviço sem profisional.
CONSTRAINT FK_servico_profissional
FOREIGN KEY (id_profissional)
REFERENCES profissional(id_profissional)
ON DELETE CASCADE,

CONSTRAINT FK_servico_categoria
FOREIGN KEY (id_categoria)
REFERENCES categoria(id_categoria)
);

CREATE TABLE agendamento(
id_agendamento INT UNSIGNED NOT NULL PRIMARY KEY,
-- vou colocar datas e horarios separados para facilitar as buscas na agenda
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
valor DECIMAL (10,2) NOT NULL CHECK (valor > 0),
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