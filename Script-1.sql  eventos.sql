--Planilha/Tabela:evento
create database evento;

create TABLE dados_evento(
id serial primary key,
nome varchar(50),
descriçao varchar(100)
);
	
create table agenda(
id serial primary key,
data_inicio date,
data_fim date
);

create table pessoa( 
id serial primary key,
nome varchar(100),
cpf char (50)
);

alter table agenda
add column id_pessoa int;

alter table agenda
add foreign key(id_pessoa)
references pessoa(id);

alter table agenda add column id_evento int;

alter table agenda 
add foreign key(id_evento)
references evento(id);

insert into data_eventos(nome, descrição)
values ('casamento'),
('exposicao de livros'),
('exposicao de carros'),
('show sertanejo'),
('formatura');

insert into agenda(data_inicio, data_fim, id_evento, id_pessoa)
values('2025-11-01', '2025-11-02', 1, 50),
('2025-11-03', '2025-11-04', 2, 30),
('2025-11-05', '2025-11-06', 3, 4),
('2025-11-07', '2025-11-08', 4, 8),
('2025-11-09', '2025-11-10', 5, 90); 

insert into pessoa (nome, cpf) 
values('Ana Silva', '123.456.789-00'),
('Carlos Pereira', '987.654.321-00'),
('Mariana Souza', '111.222.333-44'),
('João Oliveira', '555.666.777-88'),
('Fernanda Lima', '999.888.777-66');
