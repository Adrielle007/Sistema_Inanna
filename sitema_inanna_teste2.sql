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

 
 
 
 
 