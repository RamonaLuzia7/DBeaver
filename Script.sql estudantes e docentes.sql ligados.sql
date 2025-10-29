--Planilha/Tabela:estudantes
create database escola;

create TABLE estudante(
	id serial primary key,--coluna de identificação
	nome varchar(100),--tamanho da variável
	matricula char(10),--tamanho fixo
	curso varchar(50),
	login varchar(20),
	senha varchar(15),
	data_nascimento date--recebe datas no formato yyyy-MM-dd
	);


--Planilha/Tabelas:Docentes
create table docente(
id serial primary KEY,
nome varchar(100),
matricula char(7),
unidade_curricular varchar(20),
login varchar(20)
);

alter table estudante add column id_docente int;

alter table estudante
add foreign key(id_docente)
references  docente(id);