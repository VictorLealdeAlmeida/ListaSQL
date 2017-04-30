#QUESTAO 1
#Retorne o CNPJ e o Ano de Fundação do Clube que possui mais participações em Campeonatos. Use COUNT.

SELECT C.cnpj_empresa, C.ano_fundacao, COUNT(*) 
FROM clube c, participar P
WHERE C.cnpj_empresa = P.cnpj_clube
GROUP BY c.cnpj_empresa, c.ano_fundacao
HAVING COUNT(*) = 2; #VER COMO PEGAR O MAX

/* Reposta:
CNPJ_EMPRESA	ANO_FUNDACAO	COUNT(*)
14519599024395	1999	2
75755568005489	1988	2
89888265542625	1973	2
85843255014304	1957	2
*/

#QUSTAO 2
#Faça uma consulta que retorne todos os Clubes que possuem a substring '01' em seu CNPJ, 
#cujo jogos foram sediados no mês de Maio de 2016. Use algumas Junções e NOT LIKE.

SELECT E.razao_social
FROM empresa E INNER JOIN clube C
ON E.cnpj = C.cnpj_empresa
WHERE E.cnpj LIKE '%01%'
AND E.cnpj IN (SELECT J.cnpj_clube
                FROM jogar J
                WHERE J.data LIKE '%MAY-17%');

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

/*Reposta: no data found
.Nao teve nenhum jogo em janeiro*/

#Retorne o Código dos 3 Estádios que mais sediaram jogos no Campeonato de Nome 'Copa Nordeste'
#e o Código dos 3 Estádios que mais sediaram jogos no Campeonato de Nome 'Copa Sulamericana' . Utilize UNION e ORDER BY.
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
                            WHERE C.nome = 'Campeonato Penambucano Sub-20')
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
WHERE J.data LIKE '16-JUL-17'
OR J.data LIKE '17-JUL-17'
OR J.data LIKE '18-JUL-17'

/*
DATA	COD_ESTADIO
17-JUL-17	103
17-JUL-17	102
16-JUL-17	107
16-JUL-17	107
17-JUL-17	103
17-JUL-17	102
*/

#Indique o CNPJ, Razão Social e 
#Tipo de Patrocínio do Patrocinador que possui mais contratos no patrocínio do Campeonato de código 200.

SELECT E.cnpj, E.razao_social, P.tipo_patrocinio
FROM patrocinar P, empresa E
WHERE P.cod_empresa IN (SELECT)



SELECT P.cod_contrato
FROM patrocinar P
--WHERE P.cod_contrato IS NOT NULL
GROUP BY P.cod_contrato
HAVING COUNT(*) IN (SELECT MAX(COUNT(*)) FROM patrocinador P GROUP BY P.cod_contrato)

#Retorne o Número Total de Contratos que cada Patrocinador existente 
#fez no mês de Fevereiro até Abril de 2017. Apenas os 5 que fizeram mais contratos. Use ROWNUM.
SELECT E.razao_social, COUNT(*)
FROM patrocinador P, empresa E
WHERE P.cnpj_empresa = E.cnpj
AND P.cod_contrato IN (SELECT C.cod
                        FROM contrato C
                        WHERE C.data_inicio >= TO_DATE('1-FEB-10')
                        AND C.data_fim < TO_DATE('1-MAR-22'))
AND ROWNUM <= 5
GROUP BY E.razao_social

/*Precisa dos ajustes nos dados para ter resultados*/

#Mostre o número de Funcionários por cada Setor da Empresa de CNPJ '20069875410'. Utilize COUNT.



































