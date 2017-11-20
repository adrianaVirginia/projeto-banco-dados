--Comandos DML (Data Manipulation Language)
--Comandos DQL(Data Query Languagem) junto com comandos DML

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

--Povoando tabela pedido
insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (1, 4, 2, 7.5, 20, '07', false, '19/11/2017');

insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (7, 4, 2, 17.5, 10, '21/28/35', false, '19/11/2017');

insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (4, 8, 2, 5.5, 30, '21/28/35', true, '19/11/2017');

insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (3, 10, 5, 7.5, 50, '21/28/35', false, '19/11/2017');

insert into pedido (idProduto, idCliente, idFornecedor, precoPedido, quantidade, prazo, requerReserva, data) values (2, 3, 2, 12.5, 2, '07', false, '19/11/2017');

