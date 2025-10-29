create database rotina;

create table tarefa(
    id serial primary key,
    nome varchar(100),
    descricao text
);

create table agenda(
	id serial primary key, 
	data_inicio date , 
	data_fim date
);

create table pessoa(
	id serial primary key, 
	nome varchar(100), 
	cpf char (14), 
	data_nascimento timestamp
);

alter table agenda add column id_tarefa int;

alter table agenda add column id_pessoa int;

alter table agenda add foreign key (id_tarefa) 
references tarefa(id);

alter table agenda add foreign key (id_pessoa) 
references pessoa(id);

insert into tarefa(nome, descricao) 
values
('cafe', 'tomar cafe'),
('compras', 'fazer compras'),
('almoco', 'fazer almoco'),
('escola', 'estudar para a prova'),
('atividade', 'fazer a prova');

insert into agenda (data_inicio,data_fim,id_pessoa,id_tarefa) 
values
('2025-10-01 07:00:00', '2025-10-01 07:30:00',1, 2),
('2025-10-03 08:00:00', '2025-10-03 10:00:00',2, 1),
('2025-10-0 12:00:00',  '2025-10-05 12:30:00',3, 4),
('2025-10-0 13:00:00',  '2025-10-09 10:00:00',4, 3),
('2025-10-0 13:30:00',  '2025-10-09 16:30:00',5, 5);

insert into pessoa (nome,cpf,data_nascimento) 
values
('cesar',, '1998-06-18 00:00:00'),
('maria', '123.321.333-02', '1999-10-22 00:00:00'),
('vitoria','123.321.333-03','1998-07-11 00:00:00'),
('paulo', '123.321.333-04', '2000-02-25 00:00:00'),
('simao', '123.321.333-05', '2000-02-13 00:00:00');

-- Utilizando o select
select * from agenda;
select cpf from pessoa;
select nome from tarefa;

-- Utilizando o where
select *
from agenda
where data_inicio > '2025-10-01';

select *
from pessoa
where nome like 'Vit%';

select *
from tarefa
where descricao like 'Faz%';

--utilizando o AND,or
select 
from pessoa 
where nome = 'cesar' and cpf = '123-321-333-01' or cpf = '123-321-333-02'

select 
from pessoa 
where nome = 'maria' and cpf = '123-321-333-02' or cpf = '123-321-333-03'

select 
from pessoa 
where nome = 'vitoria' and cpf = '123-321-333-03' or cpf = '123-321-333-04'

-- Utilizando o ORDER BY
SELECT * FROM pessoa
ORDER BY nome asc;

select * from agenda
order by data_inicio asc;

select * from pessoa
order by data_nascimento
where data_nascimento < '2000-01-01';

--utilizando o like:
select * from tarefa where nome like 'c%';
select * from pessoa where nome like 'ia%';
select * from tarefa where descricao like 'prova%';

--utilizando o inner join:

select 
	p.nome as "nome de pessoa"
	a.data_inicio as "data de inicio"
	from agenda a 
	inner join pessoa p on a id_pessoa = p.id;

select 
	p.nome as "nome de pessoa"
	t.data_inicio as "tarefa"
	from agenda a 
	inner join pessoa p on a id_pessoa = p.id;

select 
	p.nome as "nome de pessoa"
	a.data_inicio as "data de inicio"
	from agenda a 
	inner join pessoa p on a id_pessoa = p.id;

-- utilizando o count:
select count (*)
from tarefa;

select count(*)
from agenda;

select count(*)
from pessoa;

-- utilizando o views:
create view pessoa_view as 
select nome,cpf
from pessoa 
where cpf = '123.321.333-01';

create view agenda_view as 
select data_inicio, data_fim
from agenda 
where data_inicio = '2025-10-01 07:30:00';

create view tarefa_view as 
select nome,cpf
from tarefa;

--utilize group by
select nome id_pessoa,pessoa
from pessoa 
group by nome, pessoa
order by id_pessoa asc;

select nome id_tarefa,tarefa
from tarefa
group by id_tarefa, tarefa
order by id_tarefa asc;

select data_inicio,agenda
from agenda
group by id, agenda
order by id asc;