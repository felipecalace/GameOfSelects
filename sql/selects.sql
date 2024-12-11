-- (Facil)1. Liste o nome dos alunos e os RAs de alunos com poderes identificados pelo ID do poder igual a 1 (Invisibilidade).
SELECT aluno.nome, aluno.RA
FROM aluno, poderAluno
WHERE aluno.RA = poderAluno.fkAluno
  AND poderAluno.fkPoder = 1;

-- (Facil)2. Liste os nomes e RAs de alunos que possuem os IDs de poder 3 ou 5.
SELECT aluno.nome, aluno.RA
FROM aluno, poderAluno
WHERE aluno.RA = poderAluno.fkAluno
  AND poderAluno.fkPoder IN (3, 5);

-- (Facil)3. Liste os alunos cujo nome começa com a letra "L".
SELECT nome, RA
FROM aluno
WHERE nome LIKE 'L%';

-- (Facil)4. Qual é o aluno com o menor RA registrado?
SELECT nome, RA
FROM aluno
ORDER BY RA ASC
LIMIT 1;

-- (Facil)5. Liste os alunos e seus RAs em ordem decrescente.
SELECT nome, RA
FROM aluno
ORDER BY RA DESC;

-- (Facil)6. Liste todos os poderes disponíveis, ordenados em ordem alfabética.
SELECT poder
FROM poder
ORDER BY poder ASC;

-- (Facil)7. Qual é o último poder listado em ordem alfabética?
SELECT poder
FROM poder
ORDER BY poder DESC
LIMIT 1;

-- (Facil)8. Quais poderes têm o id maior que 10?
SELECT poder
FROM poder
WHERE idPoder > 10;

-- (Facil)9. Liste os poderes com IDs menores que 4.
SELECT idPoder, poder
FROM poder
WHERE idPoder < 4;

-- (Facil)10. Liste os poderes atribuídos aos alunos, em ordem decrescente pelo ID do poder.
SELECT poderAluno.fkAluno, poderAluno.fkPoder
FROM poderAluno
ORDER BY poderAluno.fkPoder DESC;

-- (Facil)11. Liste o nome dos vilões que enfrentam o aluno cujo RA seja 01242074.
SELECT vilao.nome
FROM vilao, vilaoDoAluno
WHERE vilao.idVilao = vilaoDoAluno.fkVilao
  AND vilaoDoAluno.fkAluno = 01242074;

-- (Facil)12. Liste o nome e a característica dos vilões enfrentados pelos alunos com poderes atribuídos ao ID do poder 4.
SELECT vilao.nome, vilao.caracteristica
FROM vilao, vilaoDoAluno, poderAluno
WHERE vilao.idVilao = vilaoDoAluno.fkVilao
  AND vilaoDoAluno.fkAluno = poderAluno.fkAluno
  AND poderAluno.fkPoder = 4;

-- (Facil)13. Liste os vilões em ordem decrescente por ID.
SELECT idVilao, nome
FROM vilao
ORDER BY idVilao DESC;

-- (Facil)14. Quais são os vilões cujas características incluem a palavra "rápido"?
SELECT nome, caracteristica
FROM vilao
WHERE caracteristica LIKE '%rápido%';

-- (Facil)15. Liste os vilões enfrentados por alunos com RAs maiores que 01242050.
SELECT vilao.nome
FROM vilao, vilaoDoAluno, aluno
WHERE vilao.idVilao = vilaoDoAluno.fkVilao
  AND vilaoDoAluno.fkAluno = aluno.RA
  AND aluno.RA > 01242050;


SELECT CHALLENGES

SELECT 
    a.nome AS aluno,
    p.poder AS poder,
    v.nome AS vilao,
    f.fraqueza AS fraqueza,
    COUNT(pa.idPoderAluno) AS qtdPoderes, 
    AVG(pa.QtdPoder) AS mediaPoderes,
    MAX(pa.QtdPoder) AS maiorPoder,
    MIN(pa.QtdPoder) AS menorPoder
FROM aluno a
LEFT JOIN poderAluno pa ON a.RA = pa.fkAluno
LEFT JOIN poder p ON pa.fkPoder = p.idPoder
RIGHT JOIN vilaoDoAluno vda ON a.RA = vda.fkAluno -- Certifique-se de usar o nome correto!
JOIN vilao v ON vda.fkVilao = v.idVilao
JOIN fraqueza f ON f.fraqueza = p.poder
WHERE a.nome LIKE '%a%' -- Nome do aluno contém "a"
GROUP BY a.nome, p.poder, v.nome, f.fraqueza
ORDER BY qtdPoderes DESC;


SELECT 
    a.nome AS aluno,
    p.poder AS poder,
    COUNT(vda.fkVilao) AS qtdViloes, -- Contagem direta dos vilões
    v.nome AS vilao,
    f.fraqueza AS fraqueza,
    COUNT(pa.idPoderAluno) AS qtdPoderes,
    AVG(pa.QtdPoder) AS mediaPoderes,
    MAX(pa.QtdPoder) AS maiorPoder,
    MIN(pa.QtdPoder) AS menorPoder
FROM aluno a
LEFT JOIN poderAluno pa ON a.RA = pa.fkAluno
JOIN poder p ON pa.fkPoder = p.idPoder
LEFT JOIN vilaoDoAluno vda ON a.RA = vda.fkAluno
JOIN vilao v ON vda.fkVilao = v.idVilao
JOIN fraqueza f ON f.fraqueza = p.poder
WHERE v.nome LIKE 'C%' -- Nome do vilão começa com "C"
GROUP BY a.nome, p.poder, v.nome, f.fraqueza
ORDER BY mediaPoderes ASC;
