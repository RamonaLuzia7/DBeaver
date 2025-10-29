create database clinica;

create table paciente (
    id serial primary key,
    nome varchar(255),
    cpf char(14)
);

create table medico (
    id serial primary key,
    nome varchar(255),
    especialidade varchar(100)
);

create table consulta(
    id serial primary key,
    data_inicio timestamp,
    data_fim timestamp
);

alter table consulta add column id_paciente int;
alter table consulta add column id_medico int;

alter table consulta add foreign key (id_paciente) 
references paciente(id);

alter table consulta add foreign key (id_medico)
references medico(id);

insert into paciente (nome, cpf)
values 
('joão silva', '123 456 789 01'),
('maria oliveira', '234 567 890 12'),
('carlos santos', '345 678 901 23'),
('ana paula', '456 789 012 34'),
('pedro lima', '567 890 123 45');

insert into medico (nome, especialidade)
values 
('dr. ricardo', 'cardiologia'),
('dra. fernanda', 'dermatologia'),
('dr. marcos', 'ortopedia'),
('dra. elisa', 'pediatria'),
('dr. joão', 'neurologia');

insert into consulta (data_inicio, data_fim)
values 
('2025-10-25 09:00:00', '2025-10-25 09:30:00'),
('2025-10-26 10:00:00', '2025-10-26 10:45:00'),
('2025-10-27 11:00:00', '2025-10-27 11:30:00'),
('2025-10-28 14:00:00', '2025-10-28 14:20:00'),
('2025-10-29 15:00:00', '2025-10-29 15:40:00');

select * from paciente;
select * from medico;
select * from consulta;
select nome from paciente;
select nome, especialidade from medico;

-- 5 CONSULTAS COM WHERE
select * from paciente where nome = 'joão silva';
select * from medico where especialidade = 'cardiologia';
select * from consulta where id_medico = 1;
select * from consulta where id_paciente = 2;
select * from consulta where date(data_inicio) = '2025-10-25';

-- 3 CONSULTAS COM ORDER BY
select * from paciente order by nome asc;
select * from medico order by especialidade desc;
select * from consulta order by data_inicio;

-- 3 CONSULTAS COM AND E OR
select * from medico where especialidade = 'cardiologia' and nome like 'dr%';
select * from paciente where nome like 'j%' or nome like 'm%';
select * from consulta where id_medico = 1 and id_paciente = 1;

-- 3 CONSULTAS COM COUNT
select count(*) as total_pacientes from paciente;
select count(*) as total_consultas from consulta;
select id_medico, count(*) as total_por_medico from consulta group by id_medico;

-- 5 CONSULTAS   COM LIKE
select * from paciente where nome like 'j%';
select * from paciente where nome like '%a';
select * from medico where especialidade like '%logia';
select * from medico where nome like 'dr. %';
select * from paciente where nome like '__a%';

-- 5 consultas INNER JOIN
select c.id, p.nome as paciente, m.nome as medico 
from consulta c
inner join paciente p on c.id_paciente = p.id
inner join medico m on c.id_medico = m.id;

select p.nome, c.data_inicio 
from consulta c
inner join paciente p on c.id_paciente = p.id;

select m.nome, c.data_inicio 
from consulta c
inner join medico m on c.id_medico = m.id;

select p.nome as paciente, m.especialidade 
from consulta c
inner join paciente p on c.id_paciente = p.id
inner join medico m on c.id_medico = m.id;

select c.id, c.data_inicio, p.nome, m.nome 
from consulta c
inner join paciente p on c.id_paciente = p.id
inner join medico m on c.id_medico = m.id;

-- 5 VIEWS
create view view_consultas_completas as
select c.id, c.data_inicio, c.data_fim, p.nome as paciente, m.nome as medico, m.especialidade
from consulta c
inner join paciente p on c.id_paciente = p.id
inner join medico m on c.id_medico = m.id;

create view view_pacientes_cardiologia as
select p.nome as paciente
from consulta c
inner join paciente p on c.id_paciente = p.id
inner join medico m on c.id_medico = m.id
where m.especialidade = 'cardiologia';

create view view_medicos_neurologia as
select nome
from medico
where especialidade = 'neurologia';

create view view_consultas_ordenadas as
select *
from consulta
order by data_inicio desc;

create view view_pacientes_letra_j as
select *
from paciente
where nome like 'j%';
