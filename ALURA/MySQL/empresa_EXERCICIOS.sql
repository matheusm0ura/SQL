/*Recupere o nome e o endereço de todos os funcionários que trabalham para o departamento de pesquisa*/
SELECT CONCAT(f.PRIMEIRO_NOME," ", f.ULTIMO_NOME) AS NOME, f.ENDERECO FROM tb_funcionario AS f
JOIN tb_departamento AS d ON f.NUMERO_DEPARTAMENTO = d.NUMERO_DEPARTAMENTO
WHERE d.NOME_DEPARTAMENTO = "Pesquisa";

/*Para cada projeto localizado em Mauá vou liste o número do projeto, o número do departamento que controla 
aquele projeto, e o último nome, endereço e data de nascimento do gerente do departamento.*/
SELECT p.NUMERO_PROJETO, d.NUMERO_DEPARTAMENTO, f.ULTIMO_NOME, f.ENDERECO, f.DATA_NASCIMENTO FROM tb_projeto AS p
JOIN tb_departamento AS d ON p.NUMERO_DEPARTAMENTO = d.NUMERO_DEPARTAMENTO
JOIN tb_funcionario AS f ON d.CPF_GERENTE = f.CPF
WHERE p.LOCAL_PROJETO = "Mauá";

/*Liste o nome dos gerentes que possuem pelo menos um dependente.*/
SELECT DISTINCT CONCAT(f.PRIMEIRO_NOME," ", f.ULTIMO_NOME) AS NOME FROM tb_funcionario AS f
JOIN tb_departamento AS d ON f.CPF = d.CPF_GERENTE
JOIN tb_dependente AS e ON d.CPF_GERENTE = e.CPF_FUNCIONARIO;

/*Faça uma lista dos números dos projetos que envolvam funcionários cujo último nome seja Souza, seja ele como trabalhador 
ou como gerente do departamento que controla o projeto*/
SELECT t.NUMERO_PROJETO FROM tb_trabalha_em AS t
JOIN tb_funcionario AS f ON f.CPF = t.CPF_FUNCIONARIO
WHERE f.ULTIMO_NOME = "Souza"
UNION
SELECT p.NUMERO_PROJETO FROM tb_projeto AS p
JOIN tb_departamento AS d ON d.NUMERO_DEPARTAMENTO = p.NUMERO_DEPARTAMENTO
JOIN tb_funcionario AS f ON d.CPF_GERENTE = f.CPF
WHERE f.ULTIMO_NOME = "Souza";

/*Selecione todos os funcionários que não possuem dependentes.*/
SELECT CONCAT(f.PRIMEIRO_NOME," ", f.ULTIMO_NOME) AS NOME FROM tb_funcionario AS f
WHERE f.CPF NOT IN (SELECT CPF_FUNCIONARIO FROM tb_dependente);

/*Selecione todos dependentes dos funcionários que são do sexo feminino.*/
SELECT d.*, f.PRIMEIRO_NOME, f.ULTIMO_NOME FROM tb_dependente AS d 
JOIN tb_funcionario AS f ON d.CPF_FUNCIONARIO = f.CPF
WHERE f.SEXO = "F";

/*Recupere todos os nomes dos funcionários do departamento 5 que 
trabalham mais de 10 horas por semana no projeto 10.*/
SELECT CONCAT(f.PRIMEIRO_NOME,' ', f.NOME_MEIO,'. ', f.ULTIMO_NOME) AS NOME FROM tb_funcionario AS f
JOIN tb_trabalha_em AS t ON f.CPF = t.CPF_FUNCIONARIO
WHERE f.NUMERO_DEPARTAMENTO = 5 AND t.NUMERO_PROJETO = 10 AND t.HORAS >= 10;
