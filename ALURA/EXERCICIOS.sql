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

/*Retorne todos os bairros em uma mesma consulta*/
SELECT bairro FROM tabela_de_vendedores 
UNION SELECT bairro FROM tabela_de_clientes;
