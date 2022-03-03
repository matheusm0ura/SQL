SET FOREIGN_KEY_CHECKS = 0; /*Desliga as restrições, possibilitando a inserção dos dados.*/

INSERT INTO tb_funcionario VALUES
('3248493205','1966-03-04','Pedro','P','Machado',
'Rua Projetada A numero 27',20000, 'M', '3248493205', 1), 
('8859483743','1973-05-16','Maria','R','Oliveira','Rua Altamira 23',18000, 'F', '8859483743', 1);

INSERT INTO tb_departamento VALUES
(1, '2020-02-01','Pesquisa','3248493205'), 
(2, '2018-10-02','Comercial','8859483743');


SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO tb_funcionario VALUES
('65477565447','1983-10-18','Marcio','J','Gomes',
'Rua Casemiro 28',10000, 'M', '3248493205', 1);
INSERT INTO tb_funcionario VALUES
('8549598545','1987-09-11','Claudia','K','Lopes',
'Rua Utubaiana',12000, 'F', '3248493205', 1);
INSERT INTO tb_funcionario 
(CPF, DATA_NASCIMENTO, PRIMEIRO_NOME, NOME_MEIO, ULTIMO_NOME,
ENDERECO, CPF_SUPERVISOR, SALARIO, SEXO, NUMERO_DEPARTAMENTO)
VALUES
('35785747845','1987-09-11','Marcelo','V','Silva',
'Rua Utubaiana', '3248493205', 12000, 'F', 1);
INSERT INTO tb_funcionario 
(CPF, DATA_NASCIMENTO, PRIMEIRO_NOME, NOME_MEIO, ULTIMO_NOME,
ENDERECO, CPF_SUPERVISOR, SALARIO, SEXO, NUMERO_DEPARTAMENTO)
VALUES
('34434994034','1990-09-11','Viana','T','Correia',
'Rua Utubaiana', '3248493205', 8000, 'M', 1),
('44409394034','1982-09-11','Marcela','P','Andrade',
'Rua Utubaiana', '8859483743', 12000, 'F', 2);
