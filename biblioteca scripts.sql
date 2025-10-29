create database biblioteca;

--Biblioteca escolar

create table livro(
codigo_identificador serial primary key,
titulo varchar(100),
autor varchar(50),
editora varchar(20),
genero varchar(15),
estado_conservacao varchar(50),
quantidade_copias int
);



create table pessoal(
id serial primary key,
nome_completo varchar(100),
matricula varchar(10),
email varchar(50),
telefone varchar(14) --(24) 3333-47124
);



create table emprestimo(
id serial primary key,
data_retirada timestamp,
data_devolucao timestamp,
estado_conservacao varchar(50)
);

alter table emprestimo add column id_pessoal int;
alter table emprestimo add foreign key (id_pessoal) references pessoal(id);
alter table emprestimo add column id_livro int;
alter table emprestimo add foreign key (id_livro) references livro(codigo_identificador);