CREATE DATABASE pizzaria;
USE pizzaria;

-- TABELA DE CLIENTES
CREATE TABLE clientes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABELA DE FUNCIONARIOS
CREATE TABLE funcionarios (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    data_admissao DATE NOT NULL
);

-- TABELA DE ATRIBUIÇÕES (areas de trabalhos)
CREATE TABLE atribuicoes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL UNIQUE
);

-- TABELA DE STATUS DE PEDIDO
CREATE TABLE status_pedido (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(30) NOT NULL UNIQUE
);

-- TABELA DE TAMANHOS DE PIZZA
CREATE TABLE tamanhos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(20) NOT NULL UNIQUE,
    multiplicador DECIMAL(3, 2) NOT NULL
);

-- TABELA DE INGREDIENTES
CREATE TABLE ingredientes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    estoque DECIMAL(10, 2) NOT NULL,
    unidade_medida VARCHAR(10) NOT NULL
);

-- TABELA DE PIZZAS
CREATE TABLE pizzas (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao TEXT,
    preco_base DECIMAL(10,2) NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE
);

-- TABELA DE RELACIONAMENTO ENTRE PIZZAS E INGREDIENTES
CREATE TABLE pizza_ingredientes (
    pizza_id BIGINT UNSIGNED NOT NULL,
    ingrediente_id BIGINT UNSIGNED NOT NULL,
    quantidade DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (pizza_id, ingrediente_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(id) ON DELETE CASCADE,
    FOREIGN KEY (ingrediente_id) REFERENCES ingredientes(id) ON DELETE RESTRICT
);

-- TABELA DE PROMOÇÕES
CREATE TABLE promocoes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    pizza_id BIGINT UNSIGNED NOT NULL,
    descricao TEXT NOT NULL,
    desconto DECIMAL(5,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    FOREIGN KEY (pizza_id) REFERENCES pizzas(id) ON DELETE CASCADE
);

-- TABELA DE PEDIDOS
CREATE TABLE pedidos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cliente_id BIGINT UNSIGNED NOT NULL,
    funcionario_id BIGINT UNSIGNED NOT NULL,
    status_id BIGINT UNSIGNED NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id) ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES status_pedido(id) ON DELETE CASCADE
);

-- TABELA DE ITENS DO PEDIDO
CREATE TABLE itens_pedido (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    pedido_id BIGINT UNSIGNED NOT NULL,
    pizza_id BIGINT UNSIGNED NOT NULL,
    tamanho_id BIGINT UNSIGNED NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    valor_unitario DECIMAL(10,2) NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (pizza_id) REFERENCES pizzas(id) ON DELETE CASCADE,
    FOREIGN KEY (tamanho_id) REFERENCES tamanhos(id) ON DELETE CASCADE
);

-- TABELA DE ENTREGAS
CREATE TABLE entregas (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    pedido_id BIGINT UNSIGNED UNIQUE NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    taxa_entrega DECIMAL(10,2) NOT NULL,
    previsao_entrega TIMESTAMP,
    data_entrega TIMESTAMP,
    entregador_id BIGINT UNSIGNED,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (entregador_id) REFERENCES funcionarios(id) ON DELETE SET NULL
);

-- INDEXES PARA MELHORAR A PERFORMANCE
CREATE INDEX idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX idx_pedidos_funcionario ON pedidos(funcionario_id);
CREATE INDEX idx_pedidos_status ON pedidos(status_id);
CREATE INDEX idx_itens_pedido_pedido ON itens_pedido(pedido_id);
CREATE INDEX idx_itens_pedido_pizza ON itens_pedido(pizza_id);
CREATE INDEX idx_entregas_pedido ON entregas(pedido_id);


-- INSERTS

-- CLIENTE
INSERT INTO clientes (nome, telefone, email, endereco) VALUES
('João Silva', '(11) 9999-8888', 'joao@email.com', 'Rua A, 123 - Centro'),
('Maria Santos', '(11) 9777-6666', 'maria@email.com', 'Av. B, 456 - Jardins'),
('Carlos Oliveira', '(11) 9555-4444', 'carlos@email.com', 'Rua C, 789 - Vila Nova'),
('Ana Pereira', '(11) 9333-2222', 'ana@email.com', 'Av. D, 101 - Centro'),
('Pedro Costa', '(11) 9111-0000', 'pedro@email.com', 'Rua E, 202 - Jardins');

-- FUNCIONARIOS
INSERT INTO funcionarios (nome, cpf, telefone, cargo, data_admissao) VALUES
('Fernando Gomes', '123.456.789-01', '(11) 9888-7777', 'Gerente', '2020-01-15'),
('Juliana Alves', '987.654.321-09', '(11) 9666-5555', 'Atendente', '2021-03-20'),
('Roberto Nunes', '456.789.123-45', '(11) 9444-3333', 'Pizzaiolo', '2019-05-10'),
('Amanda Lima', '789.123.456-78', '(11) 9222-1111', 'Entregador', '2022-02-05'),
('Lucas Mendes', '321.654.987-32', '(11) 9000-9999', 'Auxiliar', '2022-07-15');

-- ATRIBUIÇÕES
INSERT INTO atribuicoes (descricao) VALUES
('Atendimento'),
('Preparo'),
('Entrega'),
('Limpeza'),
('Administração');

-- STATUS DE PEDIDO
INSERT INTO status_pedido (descricao) VALUES
('Recebido'),
('Em preparo'),
('Pronto para entrega'),
('Em rota de entrega'),
('Entregue'),
('Cancelado');

-- TAMANHOS
INSERT INTO tamanhos (descricao, multiplicador) VALUES
('Pequena', 0.8),
('Média', 1.0),
('Grande', 1.2),
('Família', 1.5);

-- INGREDIENTES
INSERT INTO ingredientes (nome, estoque, unidade_medida) VALUES
('Molho de tomate', 50.0, 'litros'),
('Mussarela', 30.0, 'kg'),
('Calabresa', 25.0, 'kg'),
('Presunto', 20.0, 'kg'),
('Ovo', 200.0, 'unidades'),
('Cebola', 15.0, 'kg'),
('Azeitona', 10.0, 'kg'),
('Tomate', 30.0, 'kg'),
('Orégano', 5.0, 'kg'),
('Catupiry', 15.0, 'kg');

-- PIZZAS
INSERT INTO pizzas (nome, descricao, preco_base, disponivel) VALUES
('Mussarela', 'Pizza de mussarela com molho de tomate e orégano', 35.00, TRUE),
('Calabresa', 'Pizza de calabresa com cebola', 40.00, TRUE),
('Portuguesa', 'Pizza com presunto, mussarela, ovo, cebola e azeitona', 45.00, TRUE),
('Quatro Queijos', 'Pizza com mussarela, provolone, parmesão e catupiry', 50.00, TRUE),
('Marguerita', 'Pizza com mussarela, tomate e manjericão', 42.00, TRUE);

-- PIZZAS-INGREDIENTES
INSERT INTO pizza_ingredientes (pizza_id, ingrediente_id, quantidade) VALUES
(1, 1, 0.1), (1, 2, 0.2), (1, 9, 0.02),  -- Mussarela
(2, 1, 0.1), (2, 2, 0.2), (2, 3, 0.15), (2, 6, 0.05),  -- Calabresa
(3, 1, 0.1), (3, 2, 0.2), (3, 4, 0.1), (3, 5, 0.1), (3, 6, 0.05), (3, 7, 0.03),  -- Portuguesa
(4, 1, 0.1), (4, 2, 0.15), (4, 10, 0.15),  -- Quatro Queijos (simplificado)
(5, 1, 0.1), (5, 2, 0.2), (5, 8, 0.1);  -- Marguerita

-- PROMOÇÕES
INSERT INTO promocoes (pizza_id, descricao, desconto, data_inicio, data_fim) VALUES
(1, 'Promoção Mussarela', 5.00, '2023-06-01', '2023-06-30'),
(3, 'Especial Portuguesa', 7.00, '2023-06-15', '2023-06-30');

-- PEDIDO
INSERT INTO pedidos (cliente_id, funcionario_id, status_id, valor_total, observacoes, data_pedido) VALUES
    (1, 2, 1,  85.00, 'Sem cebola na calabresa', '2023-06-01 18:00:00'),
    (2, 2, 3, 120.00, 'Entregar após as 19h',    '2023-06-02 19:00:00'),
    (3, 3, 2,  95.00, NULL,                     '2023-06-03 12:15:00'),
    (4, 2, 5,  75.00, 'Pagamento em dinheiro',  '2023-06-04 20:00:00'),
    (5, 3, 4, 110.00, 'Troco para 200 reais',   '2023-06-05 19:00:00');


-- ITENS DO PEDIDO
INSERT INTO itens_pedido (pedido_id, pizza_id, tamanho_id, quantidade, valor_unitario, observacoes) VALUES
(1, 2, 2, 1, 40.00, 'Sem cebola'),
(1, 1, 1, 1, 28.00, NULL),
(2, 3, 3, 1, 54.00, NULL),
(2, 4, 2, 1, 50.00, 'Bem passada'),
(3, 5, 2, 1, 42.00, NULL),
(3, 1, 3, 1, 42.00, NULL),
(4, 2, 1, 1, 32.00, NULL),
(4, 1, 2, 1, 35.00, NULL),
(5, 4, 3, 1, 60.00, NULL),
(5, 3, 2, 1, 45.00, NULL);

-- ENTREGA
INSERT INTO entregas (pedido_id, endereco, taxa_entrega, previsao_entrega, entregador_id) VALUES
(1, 'Rua A, 123 - Centro', 10.00, '2023-06-10 18:30:00', 4),
(2, 'Av. B, 456 - Jardins', 15.00, '2023-06-10 19:15:00', 4),
(4, 'Rua E, 202 - Jardins', 12.00, '2023-06-11 20:20:00', 5),
(5, 'Av. D, 101 - Centro', 10.00, '2023-06-11 19:30:00', 4);

-- ATIVIDADES 

-- 1

SELECT
	pedidos.id,
    pedidos.data_pedido,
    pedidos.valor_total,
    pedidos.observacoes,
    clientes.id,
    clientes.telefone,
    clientes.email,
    clientes.endereco,
    clientes.data_cadastro
FROM
	pedidos
INNER JOIN
	clientes ON pedidos.cliente_id = clientes.id;
    
-- 2

SELECT
	ip.id,
    ip.pedido_id,
    ip.quantidade,
    ip.valor_unitario,
    ip.observacoes,
    p.id,
    p.nome,
    p.descricao,
    p.preco_base,
    p.disponivel,
    t.descricao,
    t.multiplicador
FROM
	itens_pedido ip 
INNER JOIN
	pizzas p ON ip.pizza_id = p.id
INNER JOIN
	tamanhos t ON ip.tamanho_id = t.id;
    
-- 3
-- ADICIONAR A COLUNA POIS NÃO ADICIONEI ANTERIORMENTE
ALTER TABLE funcionarios ADD COLUMN atribuicao_id BIGINT UNSIGNED;

-- ADICIONAR A CHAVE ESTRANGEIRA
ALTER TABLE funcionarios
ADD CONSTRAINT fk_funcionarios_atribuicao
FOREIGN KEY (atribuicao_id) REFERENCES atribuicoes(id);

SELECT
	f.id,
    f.nome,
    f.cargo,
    a.descricao
FROM
	funcionarios f
INNER JOIN
	atribuicoes a ON f.atribuicao_id = a.id
ORDER BY
	f.nome;
    
-- 4

SELECT
	pedidos.id,
    pedidos.cliente_id,
    pedidos.funcionario_id,
    pedidos.status_id,
    pedidos.valor_total,
    pedidos.observacoes
FROM
	pedidos
INNER JOIN
	clientes c ON pedidos.cliente_id = c.id
INNER JOIN
	funcionarios f ON pedidos.funcionario_id = f.id
INNER JOIN
	status_pedido s ON pedidos.status_id = s.id;
    
-- 5

SELECT
	c.id,
    c.nome,
    p.id,
    p.funcionario_id,
    p.data_pedido,
    p.valor_total
FROM
	clientes c,
    pedidos p
INNER JOIN
	funcionarios f ON p.funcionario_id = f.id;
    
-- 6

SELECT
    p.id AS pizza_id,
    p.nome AS nome_pizza,
    i.id AS ingrediente_id,
    i.nome AS nome_ingrediente,
    pi.quantidade AS quantidade_usada,
    i.estoque AS estoque_ingrediente,
    i.unidade_medida AS unidade_medida_ingrediente
FROM
    pizza_ingredientes AS pi
INNER JOIN
    pizzas AS p ON pi.pizza_id = p.id
INNER JOIN
    ingredientes AS i ON pi.ingrediente_id = i.id;
    
-- 7

SELECT
	e.id,
    e.pedido_id,
    e.entregador_id,
    p.valor_total,
    p.data_pedido,
    sp.descricao,
    e.endereco,
    e.taxa_entrega,
    e.previsao_entrega,
    e.data_entrega
FROM
	entregas e
INNER JOIN 
	 pedidos p ON e.pedido_id = p.id
INNER JOIN
	 status_pedido sp ON p.status_id = sp.id;
     
-- 8
-- COMO ESTA ATIVIDADE PEDE POR UMA TABELA DE SUPERVISORES EU TIVE QUE CRIAR UMA NOVA TABELA E COLOCAR ALGUNS SELECTS PARA PODER FAZE-LA, EU FIZ A TABELA NA MÃO MAS OS SELECTS EU FIZ A IA FAZER

CREATE TABLE IF NOT EXISTS supervisores (
	id BIGINT UNSIGNED PRIMARY KEY,
    id_funcionario BIGINT UNSIGNED NOT NULL, 
    id_atribuicao_responsavel BIGINT UNSIGNED NOT NULL,
    data_inicio_supervisao DATE,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_atribuicao_responsavel) REFERENCES atribuicoes(id) ON DELETE RESTRICT
);

-- INSERTS PARTA A TABELA
INSERT INTO supervisores (id, id_funcionario, id_atribuicao_responsavel, data_inicio_supervisao, nome, cpf, telefone) VALUES
(1, 1, 5, '2023-01-01', 'Marcos Ferreira', '123.456.789-01', '(11) 9888-7777'),
(2, 3, 2, '2023-03-10', 'Paulo Silva', '456.789.123-45', '(11) 9444-3333'),
(3, 4, 3, '2023-05-01', 'Carla Souza', '789.123.456-78', '(11) 9222-1111');

-- AGORA A ATIVIDADE EM SÍ

SELECT 
    f.id AS funcionario_id,
    f.nome AS nome_funcionario,
    f.cargo,
    s.nome AS nome_supervisor,
    s.id_atribuicao_responsavel AS area_supervisionada
FROM 
    funcionarios f
LEFT JOIN 
    supervisores s ON f.id = s.id_funcionario;

-- 9    
    
SELECT
	ip.id,
    ip.pedido_id,
    ip.pizza_id,
    p.nome,
    ip.quantidade,
    ip.tamanho_id,
    t.descricao
FROM
	itens_pedido ip
INNER JOIN
	pizzas p ON ip.pizza_id = p.id
INNER JOIN
	pedidos pe ON ip.pedido_id = pe.id
INNER JOIN
	tamanhos t ON ip.tamanho_id = t.id;
    
-- 10

SELECT
	pro.id,
    pro.pizza_id,
    p.nome,
    p.descricao,
    p.preco_base,
    pro.desconto,
    pro.descricao,
    pro.data_inicio,
    pro.data_fim,
    p.disponivel
FROM
	promocoes pro
INNER JOIN
	pizzas p ON pro.pizza_id = p.id;
    
-- 11

SELECT * FROM clientes;

-- 12

SELECT * FROM pedidos WHERE data_pedido > '2023-06-02' AND data_pedido < '2023-06-05';

-- 13

SELECT
	pizza_id,
    quantidade,
    valor_unitario
FROM
	itens_pedido
WHERE
	pizza_id = 1; -- COLOQUE QUALQUER ID

-- 14

SELECT SUM(ip.valor_unitario * quantidade) AS gasto_total
FROM itens_pedido ip
INNER JOIN pedidos p ON ip.pedido_id = p.id
WHERE p.cliente_id = 2; -- COLOQUE QUALQUER ID DO CLIENTE PARA FUNCIONAR

-- 15

SELECT
  ip.pizza_id,
  p.nome,
  SUM(ip.quantidade) AS pizzas_populares_total_vendas
FROM
  itens_pedido ip
INNER JOIN
  pizzas p ON ip.pizza_id = p.id
GROUP BY
  ip.pizza_id, p.nome
ORDER BY
  pizzas_populares_total_vendas DESC;
  
-- 16

SELECT p.nome, p.disponivel FROM pizzas p;

-- 17

SELECT * FROM funcionarios;

-- 18
-- AQUI FOI O MESMO CASO DA ATIVIDADE 8, NÃO EXISTIA TABELA PARA O QUE A ATIVIDADE ESTA PEDINDO, ENTÃO EU FIZ A TABELA A MÃO E EU PEGUEI OS INSERTS COM A IA
CREATE TABLE IF NOT EXISTS funcionamento_pizzaria(
id BIGINT UNSIGNED PRIMARY KEY,
dias_funcionamento VARCHAR(50),
horario_abertura TIME,
horario_fechamento TIME
);

-- INSERTS
INSERT INTO funcionamento_pizzaria (id, dias_funcionamento, horario_abertura, horario_fechamento) VALUES
(1, 'Segunda-feira', '10:00:00', '22:00:00'),
(2, 'Terça-feira', '10:00:00', '22:00:00'),
(3, 'Quarta-feira', '10:00:00', '22:00:00'),
(4, 'Quinta-feira', '10:00:00', '22:00:00'),
(5, 'Sexta-feira', '10:00:00', '22:00:00');

-- AGORA A ATIVIDADE EM SÍ

SELECT * FROM funcionamento_pizzaria;

-- 19

SELECT * FROM pedidos WHERE status_id NOT IN (5, 6);

-- 20

SELECT
    p.id AS pedido_id,
    p.data_pedido,
    e.previsao_entrega,
    TIMESTAMPDIFF(MINUTE, p.data_pedido, e.previsao_entrega) AS diferenca_minutos
FROM
    pedidos p
INNER JOIN
    entregas e ON p.id = e.pedido_id
WHERE
    e.previsao_entrega IS NOT NULL
LIMIT 10;


