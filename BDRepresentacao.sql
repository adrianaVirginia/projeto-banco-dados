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

--Comandos DQL(Data Query Languagem) junto com comandos DML(Data Manipulation Language)
--Procedure para inserir dados nas tabelas


--Procedure para cadastrar produtos
create or replace function cadastrar_produto(descricaoP varchar, codigoP integer,precoP float, categoriaP varchar, tipoP varchar) returns void AS $$
Begin
	insert into Produto(descricao, codigo, preco, categoria, tipo) values (descricaoP, codigoP, precoP, categoriaP, tipoP);
End;
$$ Language 'plpgsql';

--Povoando a tabela de produtos
select cadastrar_produto('Ponta de Agulha', 123, 7.2, 'Resfriado', 'Peça');

select cadastrar_produto('Dianteiro', 375, 8.9, 'Resfriado', 'Peça');

select cadastrar_produto('Traseiro', 750, 12.0, 'Resfriado', 'Peça');

select cadastrar_produto('Alcatra', 36, 17.0, 'Resfriado', 'Caixaria');

select cadastrar_produto('Coração', 2346, 6.2, 'Congelado', 'Caixaria');

select cadastrar_produto('Rim', 1002, 3.2, 'Congelado', 'Caixaria');

select cadastrar_produto('Coxão Duro', 47, 14.2, 'Resfriado', 'Caixaria');

--Procedure para cadastrar telefones
create or replace function cadastrar_telefone_s(codigoT varchar, numeroT integer, tipoT varchar) returns void AS $$
Begin
	insert into telefone (codigo, numero, tipo) values (codigoT, numeroT, tipoT);
End;
$$ Language 'plpgsql';

--Povoando tabela telefone
select cadastrar_telefone_s('84','987654321','Cel');

select cadastrar_telefone_s('84','982354321','Cel');

select cadastrar_telefone_s('83','986654321','Cel');

select cadastrar_telefone_s('83','347654321','Fixo');

select cadastrar_telefone_s('81','988884321','Cel');

select cadastrar_telefone_s('84','323654321','Fixo');

select cadastrar_telefone_s('11','341454321','Fixo');

select cadastrar_telefone_s('61','32510000','Fixo');

select cadastrar_telefone_s('41','985554321','Cel');

select cadastrar_telefone_s('84','999965321','Cel');

select cadastrar_telefone_s('84','328654321','Fixo');

select cadastrar_telefone_s('84','966668421','Cel');

select cadastrar_telefone_s('84','981117667','Cel');

select cadastrar_telefone_s('99','987654321','Cel');

select cadastrar_telefone_s('63','982354321','Cel');

--Procedure para cadastrar endereços
create or replace function cadastrar_endereco_s(ruaE varchar, numeroE integer,complementoE varchar, bairroE varchar, cidadeE varchar, ufE char, cepE varchar) returns void AS $$
Begin
	insert into Endereco(rua, numero, complemento, bairro, cidade, uf, cep) values (ruaE, numeroE, complementoE, bairroE, cidadeE, ufE, cepE);
End;
$$ Language 'plpgsql';

--Povoando tabela endereço
select cadastrar_endereco_s('Av. São José', 543,' ','Quintas','Natal', 'RN','59123000');

select cadastrar_endereco_s('Rua Estreita', 1020,'Lado sul ','Planalto','Natal', 'RN','59025000');

select cadastrar_endereco_s('Rua Alta', 26,' ','Centro','Natal', 'RN','59078123');

select cadastrar_endereco_s('Av. Presidente', 2356,' ','Estados','João Pessoa', 'PB','58123000');

select cadastrar_endereco_s('Av. Tietê', 15543,'Ed. Trindade ','Tietê','São Paulo', 'SP','11123000');

select cadastrar_endereco_s('Av. Sul', 6060,'Quadra BC45 ','Asa Sul','Brasilia', 'DF','65047500');

select cadastrar_endereco_s('Rua das Flores', 97,' ','Alteras','Joenvile', 'SC','35890000');

select cadastrar_endereco_s('Rua Retiro', 753,' ','Emaús','Natal', 'RN','59023000');

select cadastrar_endereco_s('Av. Presidente Quaresma', 1234,' ','Alecrim','Natal', 'RN','59198000');

select cadastrar_endereco_s('Av. Ribeira', 9745,' ','Ribeira','Natal', 'RN','59113200');

select cadastrar_endereco_s('Rua da Saudade', 15,' ','Centro','Parnamirim', 'RN','59654300');

select cadastrar_endereco_s('Rua Profº Duarte', 345,' ','Centro','Ceará Mirim', 'RN','59128650');

select cadastrar_endereco_s('Rua Praia de Búzios', 153,' ','Ponta Negra','Natal', 'RN','59075000');

select cadastrar_endereco_s('Rod. 456', 0,'Km 5 ','Zona Rural','Açailândia', 'MA','45123000');

select cadastrar_endereco_s('Rod 235', 0 ,'Km 20 Lado sul ','Zona Rural','Araguaiana', 'TO','43956000');

--Procedure para cadastrar fornecedor
create or replace function cadastrar_fornecedor_s(cnpjF varchar, nomeF varchar, nomeFantasiaF varchar, idEnderecoF integer, idTelefoneF integer) returns void AS $$
Begin
	insert into fornecedor(cnpj, nome, nomeFantasia, idEndereco, idTelefone) values (cnpjF, nomeF, nomeFantasiaF, idEnderecoF, idTelefoneF);
End;
$$ Language 'plpgsql';

--Povoando tabela fornecedor
select cadastrar_fornecedor_s('01234567890123', 'Frigorifico', '', 12,13);

select cadastrar_fornecedor_s('34565437890123', 'Cereal', '', 13,14);

select cadastrar_fornecedor_s('5432167890123', 'Variação', '', 14,15);

--Apagando dupla repetida
delete from fornecedor where idfornecedor = 4;

--Procedure para cadastrar usuário
create or replace function cadastrar_usuario(cpfU varchar, nomeU varchar, cargoU varchar, idEndereco integer, idTelefone integer) returns void AS $$
Begin
	insert into usuario(cpf, nome, cargo, idEndereco, idTelefone) values (cpfU, nomeU, cargoU, idEndereco, idTelefone);
End;
$$ Language 'plpgsql';

--Povoando tabela usuário
select cadastrar_usuario('01234567890','João Maria', 'vendedor', 18,16);

select cadastrar_usuario('98765432100', 'Paulo', 'gerente',19,17);

select cadastrar_usuario('65478392736', 'Maria', 'auxiliar',20,18);

--Procedure para cadastrar cliente
create or replace function cadastrar_cliente_s(cnpjC varchar, nomeC varchar, nomeFantasiaC varchar, codigoC integer, redeC varchar, pagamentoDescargaC boolean, prazoC varchar, idEnderecoC integer, idTelefoneC integer) returns void AS $$
Begin
	insert into cliente(cnpj, nome, nomeFantasia, codigo, rede, pagamentoDescarga, prazo, idEndereco, idTelefone) values (cnpjC, nomeC, nomeFantasiaC, codigoC,  redeC, pagamentoDescargaC, prazoC, idEnderecoC, idTelefoneC);
End;
$$ Language 'plpgsql';

--Povoando tabela cliente
select * from endereco;

select cadastrar_cliente_s('01020203040506', 'Almeida Souza ME','Supermercado Quero mais', 324134,  ' ', true, '21/28/35', 2, 2);

select cadastrar_cliente_s('76543213040506', 'Supermercado Tanto Faz','', 546372,  ' ', true, '07', 9, 6);

select cadastrar_cliente_s('54321203040506', 'Otaviano Morais ME','Supermercado Tem de Tudo', 983256,  'Bom Preço ', true, '21/28/35', 21, 7);

select cadastrar_cliente_s('01020203040506', 'Rede Menor Preco','Supermercado Cristo', 123134,  ' ', true, '21/28/35', 10, 9);

select cadastrar_cliente_s('01020203040507', 'Rede Menor Preco','Supermercado Estado', 543134,  ' ', true, '21/28/35', 12, 8);

select cadastrar_cliente_s('11111203040506', 'Geraldo Souza ME','Supermercado Veneza', 324134,  'Rede Mais ', true, '21/28/35', 16, 11);

select cadastrar_cliente_s('22222203040506', 'Distribuidora de Carnes','', 900134,  ' ', true, '21/28/35', 11, 10);

select cadastrar_cliente_s('33333203040506', 'Salvador Cruz ME','Supermercado Bom Pastor', 112233,  ' SuperCop', true, '21/28/35', 17, 15);

--Procedure para cadastrar unidade
create or replace function cadastrar_unidade(idFornecedorU integer, idEnderecoU integer, idTelefoneU integer) returns void AS $$
Begin
	insert into unidade(idFornecedor, idEndereco, idTelefone) values (idFornecedorU, idEnderecoU, idTelefoneU);
End;
$$ Language 'plpgsql';

--Povoando tabela unidade
select cadastrar_unidade(2,22,15);

select cadastrar_unidade(2,23,16);

--Procedure para inserir dados na tabela telefone e possibilitar que seja cadastrado fornecedor, cliente e usuário com uma única chamada
--Só funciona para a primeira chamada
create or replace function cadastrar_telefone(codigoT varchar, numeroT varchar, tipo char) returns varchar AS $$
Declare id varchar;
Begin
	insert into Telefone (codigo, numero, tipo) values (codigoT, numeroT, tipo);
	id = (select idTelefone from Telefone);
	return id;
End;
$$ Language 'plpgsql';

--Procedure para inserir dados na tabela endereço e possibilitar que seja cadastrado fornecedor, cliente e usuário com uma única chamada
--Só funciona para a primeira chamada
create or replace function cadastrar_endereco(rua varchar, numeroE integer, complemento varchar, bairro varchar, cidade varchar, uf char, cep varchar) returns varchar AS $$
Declare id varchar;
Begin
	insert into Endereco (rua, numero, complemento, bairro, cidade, uf, cep) values (rua, numeroE, complemento, bairro, cidade, uf, cep);
	id = (select idEndereco from Endereco);
	return id;
End;
$$ Language 'plpgsql';

--Procedura para cadastrar um fornecedor
--Só funciona para a primeira chamada
create or replace function cadastrar_fornecedor(rua varchar, numeroE integer, complemento varchar, bairro varchar, cidade varchar, uf char, cep varchar, codigoT varchar, numeroT varchar, tipo char, cnpj varchar, nome varchar, nomeFantasia varchar) returns void AS $$
Declare id1 integer;
Declare id2 integer;
Begin
	id1 = (select cadastrar_endereco(rua, numeroE, complemento, bairro, cidade, uf, cep));
	id2 = (select cadastrar_telefone(codigoT, numeroT, tipo));
	insert into Fornecedor(cnpj, nome, nomeFantasia, idEndereco, idTelefone) values (cnpj, nome, nomeFantasia, id1, id2);
End;
$$ Language 'plpgsql';



select cadastrar_fornecedor('Apodi', '234', 'B2', 'Centro', 'Natal', 'RN', '59000000', '84', '32324000', 'Fixo','00111222000156', 'LojaTudo', 'Aquitem');

--Comandos DQL

--Criando função testar_reserva para testar se existe necessidade de fazer a reserva
create or replace function testar_reserva() returns trigger AS $testar_reserva$
Begin
	If NEW.requerReserva is true then
		Raise Exception 'Precisa ser feita uma reserva';
	End If;
	Return NEW;
End;
$testar_reserva$ Language 'plpgsql';

--Criando a trigger para inserção de pedido
create trigger pedido_insert before insert or update on pedido
for each row execute
procedure testar_reserva();

--Povoando tabela pedido
insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (1, 4, 2, 7.5, 20, '07', false, '19/11/2017');

insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (7, 4, 2, 17.5, 10, '21/28/35', false, '19/11/2017');

insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (4, 8, 2, 5.5, 30, '21/28/35', true, '19/11/2017');

insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (3, 10, 5, 7.5, 50, '21/28/35', false, '19/11/2017');

insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (2, 3, 2, 12.5, 2, '07', false, '19/11/2017');

--Comando full join
select c.nome, p.quantidade from pedido p 
full outer join cliente c on
c.idcliente = p.idcliente;

--Comando join
select u.nome, t.codigo,t.numero from usuario u join telefone t on u.idtelefone = t.idtelefone;

--Criação de view com relação dos cliente de Natal
create view vw_relacaoClientesNatal as
select c.nome, c.nomeFantasia, e.bairro, t.codigo, t.numero
from cliente c
	join endereco e on c.idendereco = e.idendereco
	join telefone t on c.idtelefone = t.idtelefone
where e.cidade = 'Natal'
order by c.nome;

select * from vw_relacaoClientesNatal;

--Criação de view com os pedidos dos clientes
create view vw_pedidoCliente as
select c.nome, p.quantidade, pd.descricao
from pedido p
	join produto pd on p.idproduto = pd.idproduto
	join cliente c on c.idcliente = p.idcliente
order by c.nome;

select * from vw_pedidoCliente;

