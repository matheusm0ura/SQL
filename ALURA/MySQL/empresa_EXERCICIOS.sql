/*Recupere o nome e o endereço de todos os funcionários que trabalham para o departamento de pesquisa*/

SELECT CONCAT(f.PRIMEIRO_NOME," ", f.ULTIMO_NOME) AS NOME, f.ENDERECO FROM tb_funcionario AS f
JOIN tb_departamento AS d ON f.NUMERO_DEPARTAMENTO = d.NUMERO_DEPARTAMENTO
WHERE d.NOME_DEPARTAMENTO = "Pesquisa";
