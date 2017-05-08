#QUESTAO 1
#Retorne o CNPJ e o Ano de Fundação do Clube que possui mais participações em Campeonatos. Use COUNT.

SSELECT C.cnpj_empresa, C.ano_fundacao 
FROM clube C, participar P
WHERE C.cnpj_empresa = P.cnpj_clube
GROUP BY C.cnpj_empresa, C.ano_fundacao
HAVING COUNT(*) IN (SELECT MAX(COUNT(*)) 
                    FROM participar P 
                    GROUP BY P.cnpj_clube);

/* Reposta:
CNPJ_EMPRESA	ANO_FUNDACAO
57916881061973	1905
*/

#QUSTAO 2
#Faça uma consulta que retorne todos os Clubes que possuem a substring '01' em seu CNPJ, 
#cujo jogos foram sediados no mês de Maio de 2016. Use algumas Junções e NOT LIKE.

SELECT E.razao_social
FROM empresa E INNER JOIN clube C
ON E.cnpj = C.cnpj_empresa
WHERE E.cnpj NOT LIKE '%01%'
AND E.cnpj IN (SELECT J.cnpj_clube
                FROM jogar J
                WHERE J.data LIKE '%MAY-16%');

/*Respota: no data found
.Nao tem jogos em maio*/

#Questão 3
#Retorne o Estádio com maior capacidade de jogos ocorridos no mês de Janeiro de 2017. Use MAX.

SELECT E.nome
FROM estadio E
WHERE E.cod IN (SELECT J.cod_estadio
                FROM jogar J
                WHERE J.data LIKE '%JAN-17')
                AND E.capacidade IN (SELECT MAX(capacidade) FROM estadio);

/*Reposta: 
NOME
Arruda
*/

#Opcao de solução

SELECT E.nome
FROM estadio E, jogar J
WHERE E.cod = J.cod_estadio
AND J.data LIKE '%JAN-17%'
AND E.capacidade in (SELECT MAX(capacidade) 
                        FROM estadio)
GROUP BY E.nome

#Retorne o Código dos 3 Estádios que mais sediaram jogos no Campeonato de Nome 'Campeonato Pernambucano' e o 
#Código dos 3 Estádios que mais sediaram jogos no Campeonato de Nome 'Copa Pernambucano' . Utilize UNION e ORDER BY.

SELECT J.cod_estadio, COUNT(*) 
FROM jogar J
WHERE j.cod_campeonato in (SELECT C.cod
                            FROM campeonato C
                            WHERE C.nome = 'Campeonato Penambucano')
GROUP BY J.cod_estadio 
ORDER BY COUNT(*) DESC;

SELECT J.cod_estadio, COUNT(*) 
FROM jogar J
WHERE j.cod_campeonato in (SELECT C.cod
                            FROM campeonato C
                            WHERE C.nome = 'Copa Pernambucano')
GROUP BY J.cod_estadio 
ORDER BY COUNT(*) DESC;

#FALTA UNIR E LIMITAR #

#Mostre a quantidade de Funcionários homens e mulheres que recebem salário maior que R$ 1.500. Use GROUP BY e COUNT.
SELECT F.sexo, COUNT(*)
FROM funcionario F
WHERE salario > 1500
GROUP BY F.sexo

/*
SEXO COUNT(*)
 M	   7
 F	   6
*/

#Faça uma consulta que retorne a Data do Jogo 
#e o Código do Estádio que sediou jogos nos dias 15, 16 e 17 de Janeiro de 2017.

SELECT J.data, J.cod_estadio
FROM jogar J
WHERE J.data = TO_DATE('15-JAN-17')
OR J.data = TO_DATE('16-JAN-17')
OR J.data = TO_DATE('17-JAN-17')
GROUP BY J.data, J.cod_estadio

/*
DATA	COD_ESTADIO
15-JAN-17	100
17-JAN-17	102
16-JAN-17	102
17-JAN-17	103
17-JAN-17	100
*/

#Indique o CNPJ, Razão Social e 
#Tipo de Patrocínio do Patrocinador que possui mais contratos no patrocínio do Campeonato de código 301.

SELECT P.cnpj_empresa, E.razao_social, P.tipo_patrocinio  
FROM patrocinador P, empresa E, patrocinar PR
WHERE P.cnpj_empresa = E.cnpj
AND P.cnpj_empresa = PR.cnpj_patrocinador
AND PR.cod_campeonato = 301;

/*Falta pegar o maior
CNPJ_EMPRESA	RAZAO_SOCIAL						TIPO_PATROCINIO
19547278302429	Prefeitura de Salgueiro				Publico
89399529222292	Companhia Energética de Pernambuco	Publico
*/

#Retorne o Número Total de Contratos que cada Patrocinador existente 
#fez no mês de Fevereiro até Abril de 2017. Apenas os 5 que fizeram mais contratos. Use ROWNUM.
SELECT E.razao_social, COUNT(*)
FROM patrocinador P, empresa E
WHERE P.cnpj_empresa = E.cnpj
AND P.cod_contrato IN (SELECT C.cod
                        FROM contrato C
                        WHERE C.data_inicio >= TO_DATE('1-FEB-17')
                        AND C.data_fim < TO_DATE('1-MAY-17'))
AND ROWNUM <= 2
GROUP BY E.razao_social

/*Precisa dos ajustes nos dados para ter resultados como a questao pede*/

#Mostre o número de Funcionários por cada Setor da Empresa de CNPJ '94642232300001'. Utilize COUNT.

SELECT S.descricao, COUNT(*)
FROM setor S, funcionario F
WHERE S.cnpj_empresa = 94642232300001
AND F.cod_setor = S.cod
GROUP BY S.descricao;

/*
DESCRICAO		COUNT(*)
Atividades		2
Almoxarifado	3
TI				3
Financeiro		3
ServiÁos Gerais	2
RH				2
*/

#Liste Nome e CPF de todos os Funcionários com o Cargo de 'Bilheteiro' de uma Federação de Futebol.

SELECT F.nome, F.cpf
FROM funcionario F, cargo C
WHERE F.cod_cargo = C.cod
AND C.descricao = 'Bilheteiro' 

/*
NOME						CPF
Diego Silva Gomes			255116122-35
Tomás Ribeiro Rodrigues		318244656-88
Nicolas Araujo Dias			386417499-69
*/




















