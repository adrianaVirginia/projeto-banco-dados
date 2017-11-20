--Comandos DQL(Data Query Language)

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

