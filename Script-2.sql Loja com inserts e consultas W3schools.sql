--Loja de roupas

create database loja;

create table produto(
	id serial primary key,
	nome varchar(30),
	preco numeric(5,2),
	quantidade int,
	cor varchar(20),
	tamanho varchar(3)
);

--Crie a coluna id_categoria como foreign key na tabela produto
alter table produto add column id_categoria int;

alter table produto
add foreign key(id_categoria)
references categoria(id);

create table categoria(
	id serial primary key,
	nome varchar(30)
);

create table cliente(
	id serial primary key,
	nome varchar(100),
	email varchar(50),
	telefone varchar(14)
);

create table atendente(
	id serial primary key,
	nome varchar(100),
	cpf char(11)
);

create table venda(
	id serial primary key,
	data_hora timestamp,
	forma_pagamento varchar(10));

alter table venda add column id_produto int;

alter table venda add column id_cliente int;

alter table venda add column id_atendente int;

--Crie a coluna id_produto como foreign key na tabela venda
alter table venda
add foreign key(id_produto)
references produto(id);

--Crie a coluna id_atendente como foreign key na tabela venda
alter table venda
add foreign key(id_atendente)
references atendente(id);

--Crie a coluna id_cliente como foreign key na tabela venda
alter table venda
add foreign key(id_cliente)
references cliente(id);

insert
insert into produto (nome, preco, quantidade, cor, tamanho) 
values ('Camiseta Branca', 29.90, 50, 'Branco', 'M'),
('Calça Jeans', 89.90, 30, 'Azul', 'G'),
('Tênis Esportivo', 149.99, 20, 'Preto', '42'),
('Jaqueta de Couro', 199.90, 10, 'Preto', 'GG'),
('Vestido Floral', 79.50, 25, 'Rosa', 'P');

insert into  categoria (nome) 
values ('Roupas'),
('Calçados'),
('Acessórios'),
('Esportes'),
('Casual');

insert into cliente (nome, email, telefone) 
values ('Ana Souza', 'ana.@gmail.com', '(11)98765-4321'),
  ('Bruno Lima', 'bruno.@hotmail.com', '(21)99876-1234'),
  ('Carla Mendes', 'carla.@yahoo.com', '(31)91234-5678'),
  ('Daniel Rocha', 'daniel.@gmail.com', '(41)99888-7766'),
  ('Eduarda Silva', 'eduarda.@outlook.com', '(51)99999-1111');

insert into atendente (nome, cpf) 
values ('Lucas ', '12345678901'),
  ('Mariana ', '23456789012'),
  ('Rafael ', '34567890123'),
  ('Juliana ', '45678901234'),
  ('Thiago ', '56789012345');

insert into  venda (data_hora, forma_pagamento)
values ('2025-10-20 14:30:00', 'Cartão'),
  ('2025-10-20 15:45:00', 'Dinheiro'),
  ('2025-10-21 09:10:00', 'Pix'),
  ('2025-10-21 11:00:00', 'Cartão'),
  ('2025-10-21 13:25:00', 'Boleto');
 
--uso do select:
--1 
select select * from venda a where a.data_hora > '2025-10-21';

--2
select * from venda p where p.forma_pagamento like "pix";

--3
select * from atendente a where a.nome like "%a";

--4
select * from venda d where p.cor like "azul";

--5
select * from cliente d where p.email like "%a";

--uso do where:
select * from venda a where a.data_hora = 14:30 ;

select * from produto p where p.cor = "azul";

select * from produto a where a.cor = "branco";

select * from cliente p where p. email= "%a%";

select * from cliente p where p.email= "bruno%";

--uso do ORDER BY:

SELECT * FROM venda
ORDER BY forma_pagamento ;

SELECT * FROM cliente
ORDER BY nome ASC;

SELECT * FROM venda
ORDER BY data_hora DESC;

--uso do AND e OR:
SELECT * FROM produto
WHERE cor = 'Preto' AND preco < 200;

SELECT * FROM cliente
WHERE nome = 'Ana Souza' OR telefone = '(21)99876-1234';

SELECT * FROM venda
WHERE forma_pagamento = 'Pix' OR (data_hora > '2025-10-20 15:00:00' AND forma_pagamento = 'Cartão');

--uso do COUNT:
SELECT COUNT(*) AS total_produtos FROM produto;

SELECT COUNT(*) AS produtos_caros FROM produto
WHERE preco > 50;

SELECT COUNT(*) AS total_atendentes FROM atendente;

--uso do LIKE:
SELECT * FROM produto
WHERE nome LIKE 'Ca%';

SELECT * FROM atendente
WHERE cpf LIKE '123%';

SELECT * FROM cliente
WHERE nome LIKE '%Silva';

SELECT * FROM produto
WHERE nome LIKE '%e%';

SELECT * FROM venda
WHERE forma_pagamento LIKE '%Cart%'

--uso do INNER JOIN;
SELECT produto.nome AS produto, categoria.nome AS categoria
FROM produto
INNER JOIN categoria ON produto.id_categoria = categoria.id;

SELECT venda.id, cliente.nome AS cliente, venda.forma_pagamento
FROM venda
INNER JOIN cliente ON venda.id_cliente = cliente.id;

SELECT venda.id, venda.data_hora, atendente.nome AS atendente
FROM venda
INNER JOIN atendente ON venda.id_atendente = atendente.id;

SELECT cliente.nome AS cliente, produto.nome AS produto
FROM venda
INNER JOIN cliente ON venda.id_cliente = cliente.id
INNER JOIN venda_produto ON venda.id = venda_produto.id_venda
INNER JOIN produto ON venda_produto.id_produto = produto.id;

SELECT produto.nome, categoria.nome AS categoria
FROM produto
INNER JOIN categoria ON produto.id_categoria = categoria.id;

--uso do view:
CREATE VIEW produtos_disponiveis AS
SELECT id, nome, preco, quantidade, cor, tamanho
FROM produto
WHERE quantidade > 0;
--Lista todos os produtos que têm quantidade maior que zero (em estoque).

CREATE VIEW vendas_com_clientes AS
SELECT v.id AS id_venda, v.data_hora, v.forma_pagamento, c.nome AS nome_cliente
FROM venda v
INNER JOIN cliente c ON v.id_cliente = c.id;
--assume que existe uma coluna id_cliente na tabela venda
--Mostra as vendas junto com os nomes dos clientes.

CREATE VIEW relatorio_atendentes AS
SELECT a.nome AS atendente, v.id AS id_venda, v.data_hora, v.forma_pagamento
FROM venda v
INNER JOIN atendente a ON v.id_atendente = a.id;
--Mostra o nome do atendente e as vendas feitas por ele. 
--e Também assume que existe id_atendente na tabela venda.

CREATE VIEW clientes_com_contato AS
SELECT nome, email, telefone
FROM cliente;
--Mostra os clientes e apenas suas informações de contato (email e telefone)

CREATE VIEW produtos_por_categoria AS
SELECT p.nome AS produto, c.nome AS categoria, p.preco
FROM produto p
INNER JOIN categoria c ON p.id_categoria = c.id;
--Assumindo que a tabela produto tenha uma coluna id_categoria.
--Mostra os produtos com os nomes das categorias a que pertencem 

