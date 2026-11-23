-- 5. INSERÇÃO DE DADOS (DML) - POVOAMENTO DO BANCO DE DADOS (CLÍNICA INANNA)


-- Cenário 1 — Configuração Inicial das Unidades e Contatos (Dados Base):
-- Antes de abrir as portas, a rede Inanna cadastrou suas 5 unidades físicas em Natal/RN e seus respectivos e-mails de atendimento.

-- Inserindo Estabelecimentos (Clínicas/Unidades)
INSERT INTO estabelecimento (id_estabelecimento, cnpj, razao_social, nome_fantasia, telefone, logradouro, numero, bairro, cidade, uf, cep) VALUES
(10, '12345678000199', 'Inanna Estetica Corporea Ltda', 'Inanna - Unidade Ponta Negra', '8432194001', 'Avenida Engenheiro Roberto Freire', '2920', 'Ponta Negra', 'Natal', 'RN', '59090000'),
(20, '98765432000188', 'Inanna Estetica Facial Ltda', 'Inanna - Unidade Tirol', '8432194002', 'Avenida Hermes da Fonseca', '1150', 'Tirol', 'Natal', 'RN', '59020000'),
(30, '11222333000144', 'Inanna Estetica Petropolis Ltda', 'Inanna - Unidade Petrópolis', '8432194003', 'Avenida Afonso Pena', '640', 'Petrópolis', 'Natal', 'RN', '59020100'),
(40, '22333444000155', 'Inanna Estetica Lagoa Nova Ltda', 'Inanna - Unidade Lagoa Nova', '8432194004', 'Avenida Senador Salgado Filho', '1800', 'Lagoa Nova', 'Natal', 'RN', '59056000'),
(50, '33444555000166', 'Inanna Estetica Capim Macio Ltda', 'Inanna - Unidade Capim Macio', '8432194005', 'Avenida Ayrton Senna', '950', 'Capim Macio', 'Natal', 'RN', '59080100');

-- Inserindo E-mails dos Estabelecimentos
INSERT INTO EstabelecimentoEmail (id_estabelecimento, email, setor, ativo) VALUES
(10, 'pontanegra@inannaestetica.com', 'Recepção', TRUE),
(20, 'tirol@inannaestetica.com', 'Recepção', TRUE),
(30, 'petropolis@inannaestetica.com', 'Agendamentos', TRUE),
(40, 'lagoanova@inannaestetica.com', 'Recepção', TRUE),
(50, 'capimmacio@inannaestetica.com', 'Financeiro', TRUE);


-- Cenário 2 — Contratação da Equipe de Especialistas:
-- Para iniciar os atendimentos, a clínica contratou 5 profissionais especializados e criou seus e-mails corporativos.

-- Inserindo Profissionais (Especialistas da Clínica)
INSERT INTO profissional (id_profissional, nome, cpf, telefone, cargo, status) VALUES
(100, 'Dra. Beatriz Pinheiro', '44455566677', '84995554444', 'Biomédica Esteta', 'Ativo'),
(200, 'Dr. Thiago Medeiros', '55566677788', '84994443333', 'Dermatologista', 'Ativo'),
(300, 'Carla Vieira', '66677788899', '84993332222', 'Esteticista', 'Ativo'),
(400, 'Fernanda Lima', '77788899900', '84992221111', 'Fisioterapeuta Dermatofuncional', 'Ativo'),
(500, 'Dr. Rafael Costa', '88899900011', '84991110000', 'Tricologista', 'Ativo');

-- Inserindo E-mails dos Profissionais
INSERT INTO ProfissionalEmail (id_profissional, email, tipo, ativo) VALUES
(100, 'dra.beatriz@inanna.com', 'Corporativo', TRUE),
(200, 'dr.thiago@inanna.com', 'Corporativo', TRUE),
(300, 'carla.estetica@inanna.com', 'Corporativo', TRUE),
(400, 'fernanda.fisio@inanna.com', 'Corporativo', TRUE),
(500, 'dr.rafael@inanna.com', 'Corporativo', TRUE);


-- Cenário 3 — Montagem do Catálogo de Categorias e Serviços:
-- A diretoria definiu as 5 grandes categorias de tratamento da clínica e cadastrou os 5 procedimentos iniciais com seus valores e responsáveis técnicos.

-- Inserindo Categorias de Serviços
INSERT INTO categoria (id_categoria, nome, descricao, ativa) VALUES
(1, 'Facial', 'Procedimentos voltados para o cuidado e rejuvenescimento do rosto', TRUE),
(2, 'Corporal', 'Procedimentos voltados para redução de medidas e contorno corporal', TRUE),
(3, 'Injetáveis', 'Aplicação de toxinas e preenchedores estéticos', TRUE),
(4, 'Capilar', 'Tratamentos para fortalecimento e saúde do couro cabeludo', TRUE),
(5, 'Laser e Depilação', 'Procedimentos com tecnologia a laser de alta precisão', TRUE);

-- Inserindo Serviços (Associados aos seus respectivos Profissionais executores)
INSERT INTO servico (id_servico, id_profissional, id_categoria, nome, descricao, preco) VALUES
(501, 300, 1, 'Limpeza de Pele Profunda', 'Extração de impurezas, hidratação e peeling de diamante', 180.00),
(502, 100, 3, 'Aplicação de Toxina Botulínica', 'Aplicação de botox na região da testa e olhos (por região)', 850.00),
(503, 200, 3, 'Preenchimento Labial', 'Escultura e volume labial com ácido hialurônico (1ml)', 1200.00),
(504, 400, 2, 'Drenagem Linfática Método Renata', 'Massagem corporal para redução de retenção de líquidos', 220.00),
(505, 500, 4, 'Intradermoterapia Capilar', 'Aplicação de vitaminas diretamente no couro cabeludo', 450.00);


-- Cenário 4 — Inauguração e Cadastro dos Primeiros Clientes:
-- Na primeira semana de funcionamento, cinco clientes realizaram o cadastro no sistema e informaram seus endereços de e-mail para receber confirmações.

-- Inserindo Clientes (1FN: Endereço Atômico)
INSERT INTO Cliente (id_cliente, nome, CPF, data_nascimento, telefone) VALUES
(1, 'Juliana Mendes Rocha', '11122233344', '1995-05-12', '84998887777'),
(2, 'Mariana Costa Souza', '22233344455', '1988-10-22', '84997776666'),
(3, 'Lucas Almeida Santos', '33344455566', '2000-02-15', '84996665555'),
(4, 'Camila Ferreira Dias', '44411122233', '1992-08-30', '84995551234'),
(5, 'Pedro Henrique Alves', '55522233344', '1985-12-05', '84994445678');

-- Inserindo E-mails dos Clientes (1FN: Atributo Multivalorado resolvido)
INSERT INTO ClienteEmail (id_cliente, email, tipo, principal) VALUES
(1, 'juliana.mendes@email.com', 'Pessoal', TRUE),
(1, 'juliana.pessoal@email.com', 'Secundário', FALSE), -- Juliana com 2 e-mails cadastrados
(2, 'mariana.costa@email.com', 'Pessoal', TRUE),
(4, 'camila.dias@email.com', 'Trabalho', TRUE),
(5, 'pedro.alves@email.com', 'Pessoal', TRUE);
-- Lucas Almeida (id_cliente 3) escolheu não cadastrar e-mail.


-- Cenário 5 — Primeiros Agendamentos e Movimentação Financeira:
-- Com o sistema em operação, os clientes agendaram seus procedimentos nas unidades de Natal e efetuaram os pagamentos via Pix e Cartão.

-- Inserindo Agendamentos (Conectando Cliente, Unidade, Profissional e Serviço)
INSERT INTO agendamento (id_agendamento, data_agendamento, horario, observcao, id_cliente, id_estabelecimento, id_profissional, id_servico) VALUES
(1001, '2026-11-10', '14:00:00', 'Cliente informou ter pele muito sensível.', 1, 10, 300, 501),
(1002, '2026-11-10', '15:30:00', NULL, 1, 10, 100, 502), -- Juliana fará dois procedimentos no mesmo dia!
(1003, '2026-11-11', '10:00:00', 'Retorno de procedimento anterior.', 2, 20, 200, 503),
(1004, '2026-11-12', '09:00:00', 'Primeira sessão do pacote corporal.', 4, 30, 400, 504),
(1005, '2026-11-12', '16:00:00', 'Avaliação de queda capilar.', 5, 40, 500, 505);

-- Inserindo Pagamentos (Financeiro atrelado rigorosamente aos centavos do DECIMAL)
INSERT INTO pagamento (id_pagamento, valor, data_pagamento, forma_pagamento, status, id_agendamento) VALUES
(9001, 180.00, '2026-11-10', 'Pix', 'Pago', 1001),
(9002, 850.00, '2026-11-10', 'Cartão de Crédito', 'Pago', 1002),
(9003, 1200.00, '2026-11-11', 'Pix', 'Pendente', 1003),
(9004, 220.00, '2026-11-12', 'Cartão de Débito', 'Pago', 1004),
(9005, 450.00, '2026-11-12', 'Dinheiro', 'Pago', 1005);


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

```