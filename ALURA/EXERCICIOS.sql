/*Qual o total de clientes que possuem MATTOS no nome?*/
SELECT count(*) as TOTAL FROM tabela_de_clientes  WHERE nome LIKE'%MATTOS%';

/*Quais são os tipos de embalagem sem repetição em que o sabor é laranja?*/
SELECT DISTINCT embalagem, tamanho FROM tabela_de_produtos WHERE sabor = 'Laranja';

/*Quais são os bairros da cidade do Rio de Janeiro que possuem clientes?*/
SELECT DISTINCT bairro, cidade FROM tabela_de_clientes WHERE cidade = 'Rio de Janeiro';

/*Queremos obter as 10 primeiras vendas do dia 01/01/2017. Qual seria o comando SQL para obter este resultado?*/
SELECT * FROM notas_fiscais WHERE DATA_VENDA = '2017-01-01' LIMIT 10;

/*Qual (ou quais) foi (foram) a(s) maior(es) venda(s) do produto “Linha Refrescante - 1 Litro - Morango/Limão”, em quantidade? 
(Obtenha este resultado usando 2 SQLs)*/
SELECT * FROM tabela_de_produtos WHERE NOME_DO_PRODUTO =  'Linha Refrescante - 1 Litro - Morango/Limão';
SELECT * FROM itens_notas_fiscais WHERE CODIGO_DO_PRODUTO = 1101035 ORDER BY QUANTIDADE DESC;

/*Qual o total de cliente por estado?*/
SELECT COUNT(*) AS 'TOTAL DE CLIENTE', ESTADO FROM tabela_de_clientes GROUP BY ESTADO;

/*Qual o produto mais caro de cada categoria de embalagem?*/
SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS 'MAIOR PREÇO' FROM tabela_de_produtos GROUP BY EMBALAGEM;

/*Qual a soma total de limite de crédito por bairro?*/
SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS 'LIMITE TOTAL' FROM tabela_de_clientes 
GROUP BY BAIRRO order by 'LIMITE TOTAL';

/*Quantos itens de venda existem com a maior quantidade do produto '1101035'?*/
SELECT COUNT(*) AS 'TOTAL' FROM itens_notas_fiscais 
WHERE CODIGO_DO_PRODUTO = '1101035' 
AND QUANTIDADE = (SELECT MAX(QUANTIDADE) FROM  itens_notas_fiscais WHERE CODIGO_DO_PRODUTO = '1101035')
GROUP BY CODIGO_DO_PRODUTO;

/*Quais foram os clientes que fizeram mais de 2000 compras em 2016?*/
SELECT CPF, COUNT(*) AS TOTAL_DE_COMPRAS FROM notas_fiscais 
WHERE YEAR(DATA_VENDA) = 2016 
GROUP BY CPF HAVING TOTAL_DE_COMPRAS > 2000;

/*Classifique os produtos em barato, em conta e caro*/
SELECT NOME_DO_PRODUTO, PRECO_DE_LISTA,
CASE 
	WHEN PRECO_DE_LISTA >= 12 THEN 'Produto caro'
	WHEN PRECO_DE_LISTA >=7 AND PRECO_DE_LISTA < 12 THEN 'Produto em conta'
	ELSE 'Produto barato'
END AS 'STATUS_PREÇO' 
FROM tabela_de_produtos;

/*Veja o ano de nascimento dos clientes e classifique-os como: Nascidos antes de 1990 são velhos, 
nascidos entre 1990 e 1995 são jovens e nascidos depois de 1995 são crianças. Liste o nome do cliente e esta classificação.*/
SELECT NOME,
CASE 
	WHEN YEAR(DATA_DE_NASCIMENTO) < 1990 THEN 'VELHO'
    WHEN YEAR(DATA_DE_NASCIMENTO) BETWEEN 1990 AND 1995 THEN 'JOVEM'
    ELSE 'CRIANÇA'
END AS 'CLASSIFICAÇÃO_ETÁRIA' 
FROM tabela_de_clientes;

/*Qual o total de vendas para cada vendedor?*/
SELECT n.matricula, v.nome, COUNT(*) AS TOTAL_DE_VENDAS FROM notas_fiscais AS n
JOIN tabela_de_vendedores AS v on n.MATRICULA = v.MATRICULA 
GROUP BY n.MATRICULA;

/*Obtenha o faturamento anual da empresa. Leve em consideração que o valor financeiro das vendas consiste em multiplicar a quantidade pelo preço.*/
SELECT YEAR(n.DATA_VENDA) AS ANO, SUM(i.QUANTIDADE * i.PRECO) AS FATURAMENTO_ANUAL 
FROM notas_fiscais as n
JOIN itens_notas_fiscais AS i on n.NUMERO = i.NUMERO 
GROUP BY ANO;

/*Quais são os vendedores que têm escritório no mesmo bairro que os clientes?*/
SELECT v.nome AS NOME_VENDEDOR, c.nome AS NOME_CLIENTE, c.bairro AS BAIRRO 
FROM tabela_de_vendedores AS v 
JOIN tabela_de_clientes AS c ON v.BAIRRO = c.BAIRRO;

/*Retorne todos os bairros em uma mesma consulta.*/
SELECT bairro, nome, 'VENDEDOR' AS TIPO FROM tabela_de_vendedores 
UNION 
SELECT bairro, nome, 'CLIENTE' AS TIPO FROM tabela_de_clientes;

/*A partir de uma view, selecione os maiores preços de cada produto*/
SELECT P.nome_do_produto, P.embalagem, P.preco_de_lista, X.preco_maximo FROM tabela_de_produtos AS P
JOIN vw_maiores_precos_embalagens AS X
ON P.embalagem = X.embalagem;

/*Faça uma consulta listando o nome do cliente e o endereço completo (Com rua, bairro, cidade e estado).*/
SELECT nome AS 'NOME_DO_CLIENTE', CONCAT(endereco_1, ', ', bairro, ', ', cidade, ', ', estado) AS 'ENDEREÇO COMPLETO'from tabela_de_clientes;

/*Crie uma consulta que mostre o nome e a idade atual dos clientes.*/
SELECT NOME AS NOME_DO_CLIENTE, TIMESTAMPDIFF (YEAR, DATA_DE_NASCIMENTO, CURDATE()) AS IDADE FROM  tabela_de_clientes;

/*Na tabela de notas fiscais temos o valor do imposto. Já na tabela de itens temos a quantidade e o faturamento. 
Calcule o valor do imposto pago no ano de 2016 arredondando para o menor inteiro.*/
SELECT YEAR(n.data_venda) AS ANO, CONCAT("R$ ", CAST(FLOOR(SUM(n.imposto * i.quantidade * i.preco)) AS DECIMAL(10, 2))) AS IMPOSTO_PAGO 
FROM notas_fiscais AS n 
JOIN itens_notas_fiscais AS i 
ON n.numero = i.numero
WHERE YEAR(n.data_venda) = 2016
GROUP BY ANO;

/*Retorne a data atual no padrão dia/mês/ano.*/
SELECT CONCAT('A data de hoje é: ', DATE_FORMAT(CURDATE(), '%d/%m/%Y')) AS DATA_DE_HOJE;

/*Queremos construir um SQL cujo resultado seja, para cada cliente:
“O cliente João da Silva faturou 120000 no ano de 2016”.
Somente para o ano de 2016.*/
SELECT c.nome AS NOME_CLIENTE, ROUND(SUM(i.preco * i.quantidade), 2) AS FATURAMENTO, n.data_venda AS 'DATA'
from tabela_de_clientes AS c
JOIN notas_fiscais AS n ON c.cpf = n.cpf
JOIN itens_notas_fiscais AS i on n.numero = i.numero
WHERE YEAR(n.DATA_VENDA) = 2016
GROUP BY c.nome, YEAR('DATA');

/*Retorne a soma da quantidade para cada cliente em cada mês do ano.*/
SELECT DATE_FORMAT(n.data_venda, '%Y/%m') AS ANO_MES, c.nome AS NOME_CLIENTE, c.cpf AS CPF, SUM(i.quantidade) AS SOMA_QUANTIDADE FROM tabela_de_clientes AS c
JOIN notas_fiscais AS n ON c.cpf = n.cpf
JOIN itens_notas_fiscais AS i ON i.numero = n.numero
GROUP BY n.cpf, ANO_MES;

/*RELATÓRIO DE VENDAS*/
/*Faça um relátorio de compras que agrupe todas as compras do mês de cada cliente, verificando se elas são válidas ou não.*/
SELECT x.ANO_MES, x.NOME_CLIENTE, x.CPF, x.SOMA_QUANTIDADE, x.VOLUME_DE_COMPRAS, 
CASE 
	WHEN (x.SOMA_QUANTIDADE <= x.VOLUME_DE_COMPRAS) THEN 'COMPRA VÁLIDA'
    WHEN (x.SOMA_QUANTIDADE > x.VOLUME_DE_COMPRAS) THEN 'COMPRA INVÁLIDA'
END AS 'STATUS'
FROM(
SELECT DATE_FORMAT(n.data_venda, '%Y/%m') AS ANO_MES, 
c.nome AS NOME_CLIENTE, c.cpf AS CPF, 
SUM(i.quantidade) AS SOMA_QUANTIDADE, 
MAX(c.volume_de_compra) AS VOLUME_DE_COMPRAS
FROM tabela_de_clientes AS c
JOIN notas_fiscais AS n ON c.cpf = n.cpf
JOIN itens_notas_fiscais AS i ON i.numero = n.numero
GROUP BY n.cpf, ANO_MES, NOME_CLIENTE) AS x;

/*A partir da consulta anterior, retorne apenas as compras inválidas.*/
SELECT x.ANO_MES, x.NOME_CLIENTE, x.CPF, x.SOMA_QUANTIDADE, x.VOLUME_DE_COMPRAS, 
CASE 
	WHEN (x.SOMA_QUANTIDADE <= x.VOLUME_DE_COMPRAS) THEN 'COMPRA VÁLIDA'
    WHEN (x.SOMA_QUANTIDADE > x.VOLUME_DE_COMPRAS) THEN 'COMPRA INVÁLIDA'
END AS 'STATUS'

FROM(
SELECT DATE_FORMAT(n.data_venda, '%Y/%m') AS ANO_MES, 
c.nome AS NOME_CLIENTE, c.cpf AS CPF, 
SUM(i.quantidade) AS SOMA_QUANTIDADE, 
MAX(c.volume_de_compra) AS VOLUME_DE_COMPRAS
FROM tabela_de_clientes AS c
JOIN notas_fiscais AS n ON c.cpf = n.cpf
JOIN itens_notas_fiscais AS i ON i.numero = n.numero
GROUP BY n.cpf, ANO_MES, NOME_CLIENTE) AS x
WHERE x.SOMA_QUANTIDADE > x.VOLUME_DE_COMPRAS;

/*Retorne a quantidade de vendas no ano de 2016 e o percentual da quantidade de cada valor em relação ao valor total vendido nesse ano.*/
SELECT VENDA_SABOR.SABOR, VENDA_SABOR.QUANTIDADE, VENDA_SABOR.ANO, ROUND((VENDA_SABOR.quantidade / VENDA_TOTAL.quantidade) * 100, 2) AS PERCENTUAL FROM 
(SELECT p.sabor, SUM(i.quantidade) AS QUANTIDADE, YEAR(n.data_venda) AS ANO FROM tabela_de_produtos AS p
JOIN itens_notas_fiscais AS i ON p.codigo_do_produto = i.codigo_do_produto
JOIN notas_fiscais AS n ON n.numero = i.numero
WHERE YEAR(n.data_venda) = 2016
GROUP BY p.sabor, ANO) AS VENDA_SABOR
JOIN 
(SELECT SUM(i.quantidade) AS QUANTIDADE, YEAR(n.data_venda) AS ANO FROM tabela_de_produtos AS p
JOIN itens_notas_fiscais AS i ON p.codigo_do_produto = i.codigo_do_produto
JOIN notas_fiscais AS n ON n.numero = i.numero
WHERE YEAR(n.data_venda) = 2016
GROUP BY ANO) AS VENDA_TOTAL
ON VENDA_SABOR.ANO = VENDA_TOTAL.ANO
ORDER BY VENDA_SABOR.quantidade DESC;

/*Vamos aumentar em 30% o volume de compra dos clientes que possuem, em seus endereços bairros onde os vendedores possuam escritórios.*/
UPDATE tabela_de_clientes AS c 
JOIN tabela_de_vendedores AS v
ON c.bairro = v.bairro
SET c.limite_de_credito = limite_de_credito * 1.3;

/*Vamos excluir as notas fiscais (Apenas o cabeçalho) cujos clientes tenham menos que 18 anos.*/
DELETE n FROM tabela_de_clientes AS c
JOIN notas_fiscais AS n 
ON c.CPF = n.CPF
WHERE c.IDADE <= 18;

/*Aumente a comissão dos venderores em 15% e utilize transação para isso.*/
START TRANSACTION;
SELECT * FROM tabela_de_vendedores;
UPDATE tabela_de_vendedores SET percentual_comissao = percentual_comissao * 1.15;
ROLLBACK; /*não modifica os dados*/

START TRANSACTION;
SELECT * FROM tabela_de_vendedores;
UPDATE tabela_de_vendedores SET percentual_comissao = percentual_comissao * 1.15;
COMMIT; /*salva as alterações feitas no BD*/

/*Construa uma TRIGGER (Vamos chamá-la de TG_CLIENTES_IDADE_INSERT) que atualize as idades dos clientes, na tabela de clientes, toda vez que a tabela sofrer uma inclusão.*/
DELIMITER //
CREATE TRIGGER TG_CLIENTES_IDADE_INSERT BEFORE INSERT ON tabela_de_clientes
FOR EACH ROW
BEGIN
SET NEW.IDADE = timestampdiff(YEAR, NEW.DATA_DE_NASCIMENTO, NOW());
END//

/*Crie uma Stored procedure que atualize a idade dos clientes. Lembrando que o comando para calcular a idade*/
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Calcula_Idade`()
BEGIN
update tabela_de_clientes as c
set c.idade = TIMESTAMPDIFF(YEAR, c.data_de_nascimento, CURDATE()); 
END$$

/*Crie uma Stored Procedure que insira um registro na tabela de produtos*/
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `inclui_produto_parametro`(vCodigo varchar(50), vproduto varchar(50), vEmbalagem varchar(50),
vTamanho varchar(50), vSabor varchar(50),  vPreco decimal(10,2))
BEGIN
	declare mensagem varchar(50);
	declare exit handler for 1062
	BEGIN
		set mensagem = 'CHAVE PRIMÁRIA DUPLICADA';
		select mensagem;
	END;
	INSERT INTO `sucos_vendas`.`tabela_de_produtos`
	(`CODIGO_DO_PRODUTO`,
	`NOME_DO_PRODUTO`,
	`EMBALAGEM`,
	`TAMANHO`,
	`SABOR`,
	`PRECO_DE_LISTA`)
	VALUES
	(vCodigo, vproduto, vEmbalagem, vTamanho, vSabor, vPreco);
	set mensagem = 'PRODUTO INCLUÍDO COM SUCESSO';
	select mensagem;
END$$

/*Crie uma Stored procedure para reajustar o % de comissão dos vendedores. Inclua como parâmetro da SP o %, expresso em valor*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Reajuste_Comissao`(vCodigo varchar(5), vComissao float)
BEGIN
update tabela_de_vendedores set percentual_comissao = percentual_comissao * (1 + vComissao)
where matricula =  vCodigo;
END$$

/*Crie uma variável chamada NUMNOTAS e atribua a ela o número de notas fiscais do dia 01/01/2017. 
Mostre na saída do script o valor da variável. (Chame esta Stored Procedure de Quantidade_Notas)*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Quantidade_Notas`()
BEGIN
declare NUMNOTAS int;
select count(*) into NUMNOTAS from notas_fiscais 
where data_venda = '2017-01-01';
select NUMNOTAS;

END$$

/*Crie uma Stored Procedure que, baseado em uma data, contamos o número de notas fiscais. Se houverem mais que 70 notas exibimos a mensagem: ‘Muita nota’. 
Ou então exibimos a mensagem ‘Pouca nota’. Também exibir o número de notas. Chame esta Stored Procedure de Testa_Numero_Notas.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Testa_Numero_Notas`(vData date)
BEGIN
DECLARE vResultado VARCHAR(15);
DECLARE vQuantidade INT;
SELECT count(*) INTO vQuantidade FROM notas_fiscais 
WHERE data_venda = vData;

IF vQuantidade > 70 THEN
	SET vResultado = 'Muita nota';
ELSE
	SET vResultado = 'Pouca nota';
END IF;
SELECT vQuantidade AS 'Quantidade de notas ', vResultado AS 'Resultado';
END$$

/*Crie uma Stored Procedure que classifique os produtos em CARO, EM CONTA ou BARATO os produtos.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `classifica_produto`(vCod varchar(10))
BEGIN
DECLARE vResultado VARCHAR(10);
DECLARE vPreco FLOAT;

SELECT PRECO_DE_LISTA INTO vPreco from tabela_de_produtos WHERE codigo_do_produto = vCod;

IF vPreco >= 12 THEN
	SET vResultado = 'CARO';
ELSEIF vPreco >= 7 AND vPreco < 12 THEN
	SET vResultado = 'EM CONTA';
ELSE
	SET vResultado = 'BARATO';
END IF;
SELECT vResultado;
END$$

/*Construa uma Stored Procedure chamada Comparativo_Vendas que compara as vendas em duas datas (Estas duas datas serão parâmetros da SP). 
Se a variação percentual destas vendas for maior que 10% a resposta deve ser ‘Verde’. 
Se for entre -10% e 10% deve retornar ‘Amarela1. Se o retorno form menor que -10% deve retornar ‘Vermelho’.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Comparativo_Vendas`(vData1 date, vData2 date)
BEGIN
DECLARE vSoma1 DECIMAL(10,2);
DECLARE vSoma2 DECIMAL(10,2);
DECLARE vVariacao DECIMAL(10,2);

SELECT SUM(B.QUANTIDADE * B.PRECO) INTO vSoma1 FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA = vData1;

SELECT SUM(B.QUANTIDADE * B.PRECO) INTO vSoma2 FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA = vData2;

SET vVariacao = ((vSoma2 / vSoma1) - 1) * 100;

IF vVariacao > 10 THEN
	SELECT 'VERDE';
ELSEIF vVariacao >= -10 AND vVariacao <= 10 THEN
	SELECT 'AMARELO';
ELSE
	SELECT 'VERMELHO';
END IF;
END$$

/*Utlizando uma SP, classifique os sabores dos produtos.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `classifica_sabor`(vProduto varchar(20))
BEGIN
DECLARE vSabor varchar(30);
SELECT sabor INTO vSabor from tabela_de_produtos WHERE codigo_do_produto = vProduto;

CASE vSabor 
    WHEN 'Lima/Limão' THEN SELECT 'CÍTRICO';
    WHEN 'Laranja' THEN SELECT 'CÍTRICO';
    WHEN 'Morango/Limão' THEN SELECT 'CÍTRICO';
    WHEN 'Uva' THEN SELECT 'NEUTRO';
    WHEN 'Morango' THEN SELECT 'NEUTRO';
    ELSE SELECT 'ÁCIDO';
END CASE;

END$$

/*Implemente a Stored Procedure do exercício do vídeo 2, agora usando CASE CONDICIONAL. Chame de Comparativo_Vendas_Case_Cond.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Comparativo_Vendas_Case_Cond`(data_1 date, data_2 date)
BEGIN
DECLARE vSoma1 DECIMAL(10,2);
DECLARE vSoma2 DECIMAL(10,2);
DECLARE vVariacao DECIMAL(10,2);

SELECT SUM(B.QUANTIDADE * B.PRECO) INTO vSoma1 FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA= data_1;

SELECT SUM(B.QUANTIDADE * B.PRECO) INTO vSoma2 FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA = data_2;

SET vVariacao = ((vSoma2 / vSoma1) - 1) * 100;
CASE 
WHEN vVariacao > 10 THEN SELECT 'VERDE';
WHEN vVariacao >= -10 AND vVariacao <= 10 THEN SELECT 'AMARELO';
WHEN vVariacao < -10 THEN SELECT 'VERMELHO';	
END CASE;

END$$

/*Crie uma Stored Procedure usando um cursor para achar o valor total de todos os créditos de todos os clientes. Chame esta SP de Limite_Creditos.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Limite_Creditos`()
BEGIN
    DECLARE fim_do_cursor BIT DEFAULT 0;
    DECLARE vLimite_credito FLOAT;
    DECLARE vLimite_total FLOAT DEFAULT 0;
    DECLARE c CURSOR FOR SELECT limite_de_credito FROM tabela_de_clientes;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_do_cursor = 1; 
    OPEN c;
	
    WHILE fim_do_cursor = 0
    DO 	
		FETCH c INTO vLimite_credito;
		IF fim_do_cursor = 0 THEN
			SET vLimite_total = vLimite_credito + vLimite_total;
		END IF;
	
    END WHILE;
    SELECT vLimite_total AS 'TOTAL DE CRÉDITO ';
    CLOSE c;

END$$

/*Crie uma função que retorne o tipo de sabor.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `acha_tipo_sabor`(vSabor VARCHAR(50)) RETURNS varchar(20) CHARSET utf8mb4
BEGIN
	DECLARE vRetorno VARCHAR(20) DEFAULT "";
    
    CASE vSabor 
		WHEN 'Lima/Limão' THEN SET vRetorno = 'CÍTRICO';
		WHEN 'Laranja' THEN SET vRetorno = 'CÍTRICO';
		WHEN 'Morango/Limão'  THEN SET vRetorno = 'CÍTRICO';
		WHEN 'Uva'  THEN SET vRetorno = 'NEUTRO';
		WHEN 'Morango'  THEN SET vRetorno = 'NEUTRO';
		ELSE SET vRetorno ='ÁCIDO';
	END CASE;
    RETURN vRetorno;
END$$

/*Retorne, a partir da função criada, o nome, o sabor e o tipo do sabor do produto.*/
SELECT nome_do_produto, sabor, acha_tipo_sabor(SABOR) AS TIPO FROM tabela_de_produtos;

/*Utilizando uma função que retorne o número de notas fiscais em determinada data.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `NumeroNotas`(vData date) RETURNS int
BEGIN
    DECLARE vRetorno INTEGER DEFAULT 0;
    SELECT COUNT(*) INTO vRetorno FROM notas_fiscais WHERE data_venda =  vData;

RETURN vRetorno;
END$$

/*Crie uma função que retorne um número aleatório de acordo com determinado intervalo.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `retorna_num_aleatorio`(num_max int, num_min int) RETURNS int
BEGIN
	DECLARE num_aleatorio INTEGER;
    SELECT FLOOR((RAND() *  num_max - num_min + 1) + num_min) INTO num_aleatorio;
    RETURN num_aleatorio;
END$$

/*Faça uma SP (Chame-a de Tabela_Numeros) que use um loop para gravar nesta tabela 100 números aleatórios entre 0 e 1000. Depois liste numa consulta esta tabela.*/
DELIMITER $$
USE `sucos_vendas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `tab_numeros_aleatorios`()
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE num_aleatorio INT;
    TRUNCATE tabela_aleatorios;
    
    WHILE counter < 100
     DO
        SELECT retorna_num_aleatorio(1000, 0) INTO num_aleatorio;
        INSERT INTO tabela_aleatorios values (num_aleatorio);
	SET counter = counter + 1;
    END WHILE;
    SELECT * FROM tabela_aleatorios;
END$$

/*Faça uma consulta que retorne um produto aleatório.*/
SELECT * FROM tabela_de_produtos ORDER BY RAND () LIMIT 1; 

