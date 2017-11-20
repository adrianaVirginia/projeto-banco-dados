--Comandos DDL(Data Definition Language)
-- Database: "DBRepresentacao"

-- DROP DATABASE "DBRepresentacao";

CREATE DATABASE "DBRepresentacao"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       CONNECTION LIMIT = -1;

--Criando as tabelas

--Criando tabela Endereço
create table Endereco(
	idEndereco serial,
	rua varchar(50) not null,
	numero integer null,
	complemento varchar(15) null,	
	bairro varchar(20) null,
	cidade varchar(15) not null,
	uf char(2) not null,
	cep varchar(8) null check (cep similar to '(\d)+'),
	primary key (idEndereco)
);

--drop table endereco;

--Alterando o tipo de dados da coluna numero da tabela endereco
alter table endereco alter numero type varchar(12);

--Criando tabela telefone
create table Telefone(
	idTelefone serial,
	codigo varchar(2) null check (codigo similar to '(\d)+'),
	numero varchar(9) not null check (numero similar to '(\d)+'),
	tipo varchar(10) not null,
	primary key (idTelefone)
);

--drop table telefone;

--Apagando a coluna tipo da tabela telefone
alter table telefone drop tipo;

--Criando uma constraint do tipo Check para o atributo tipo da tabela telefone
alter table telefone add tipo varchar(10) check (tipo = 'fixo' or tipo = 'cel');

--Criando tabela Fornecedor
create table Fornecedor(
	idFornecedor serial,
	cnpj varchar(14) not null check (cnpj similar to '(\d)+'),
	nome varchar(50) null,
	nomeFantasia varchar(30) null,
	idEndereco integer not null references Endereco,
	idTelefone integer not null references Telefone,
	Primary key(idFornecedor)
);

--Caso seja necessário apagar um atributo referenciado 
alter table Fornecedor drop idtelefone cascade;

--Criando tabela Cliente
create table Cliente(
	idCliente serial,
	cnpj varchar(14) not null check (cnpj similar to '(\d)+'),
	nome varchar(50) null,
	nomeFantasia varchar(30) null,
	codigo integer,
	rede varchar(20),
	pagamentoDescarga boolean,
	idEndereco integer not null references Endereco,
	idTelefone integer not null references Telefone,
	Primary key(idCliente)
);

--Acrescentando a tabela Fornecedor o atributo nomeFantasia
alter table Cliente add prazo varchar (12);

--Criando tabela Usuário
create table Usuario(
	idUsuario serial,
	cpf varchar not null check(cnpj similar to '(\d)+'),
	nome varchar(50) not null,
	cargo varchar (15) null,
	idEndereco integer not null references Endereco,
	idTelefone integer not null references Telefone,
	Primary key(idUsuario)
);

--Criando tabela Unidade
create table Unidade(
	idUnidade serial,
	idFornecedor integer not null references Fornecedor,
	idEndereco integer not null references Endereco,
	idTelefone integer not null references Telefone,
	Primary key(idUnidade)
);

--
create table TipoProduto(
	idTipoProduto serial,
	nome varchar(15),
	categoria varchar(15),
	idFornecedor integer not null references Fornecedor,
	primary key (idTipoProduto)
);

--Apagando tabela TipoProduto que não vai ser implantado nesse projeto
drop table TipoProduto;

--Criando tabela Produto
create table Produto(
	idProduto serial,
	descricao varchar(20),
	codigo integer,
	preco float,
	categoria varchar(12),

	tipo varchar(12),
	primary key(idProduto)
);

--Criando tabela Pedido
create table Pedido(
	idPedido serial,
	idProduto integer not null references Produto (idProduto) on delete cascade,
	idCliente integer not null references Cliente (idCliente) on delete cascade,
	idFornecedor integer not null references Fornecedor (idFornecedor) on delete cascade,
	precoPedido float not null,
	quantidade float not null,
	prazo varchar(12) not null,
	requerReserva boolean,
	data date,
	primary key(idPedido)
);
