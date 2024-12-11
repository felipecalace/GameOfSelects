	
CREATE DATABASE SPTech;

USE SPTech;

CREATE TABLE aluno(
    RA INT PRIMARY KEY,
    nome VARCHAR(50),
    fkMonitor INT,
    FOREIGN KEY(fkMonitor) REFERENCES aluno(RA)
);
INSERT INTO aluno (RA, nome) VALUES
(01242074, 'Luz'),
(01242049, 'Luiza'),
(01242137, 'Paloma'),
(01242061, 'Calace'),
(01242015, 'Mateus');

CREATE TABLE poder(
    idPoder INT PRIMARY KEY AUTO_INCREMENT,
    poder VARCHAR(50)
);
INSERT INTO poder (poder) VALUES
('Invisibilidade'),
('Super Força'),
('Controle de Tecnologia'),
('Telepatia'),
('Velocidade Sobrenatural');

CREATE TABLE poderAluno(
    idPoderAluno INT AUTO_INCREMENT,
    QtdPoder FLOAT,
    fkPoder INT,
    fkAluno INT,
    FOREIGN KEY(fkAluno) REFERENCES aluno(RA),
    FOREIGN KEY(fkPoder) REFERENCES poder(idPoder),
    PRIMARY KEY(idPoderAluno, fkAluno, fkPoder)
);
INSERT INTO poderAluno (QtdPoder, fkPoder, fkAluno) VALUES
(100, 1, 01242074), -- Luz: Invisibilidade
(100, 2, 01242049), -- Luiza: Super Força
(100, 3, 01242137), -- Paloma: Controle de Tecnologia
(100, 4, 01242061), -- Calace: Telepatia
(100, 5, 01242015); -- Mateus: Velocidade Sobrenatural

CREATE TABLE vilao (
    idVilao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    caracteristica VARCHAR(100)
);
INSERT INTO vilao (nome, caracteristica) VALUES
('Dr. Malware', 'Controle de Tecnologia'),  -- Correspondente à fraqueza e poder do aluno
('Shadow', 'Invisibilidade'),               -- Correspondente à fraqueza e poder do aluno
('Capitão Bug', 'Velocidade Sobrenatural'), -- Correspondente à fraqueza e poder do aluno
('Trojanizer', 'Telepatia'),                -- Correspondente à fraqueza e poder do aluno
('Overclock', 'Super Força');               -- Correspondente à fraqueza e poder do aluno

CREATE TABLE fraqueza (
    idFraqueza INT PRIMARY KEY AUTO_INCREMENT,
    fraqueza VARCHAR(50)
);
INSERT INTO fraqueza (fraqueza) VALUES
('Controle de Tecnologia'), -- Fraqueza do Dr. Malware
('Invisibilidade'),         -- Fraqueza de Shadow
('Velocidade Sobrenatural'),-- Fraqueza de Capitão Bug
('Telepatia'),              -- Fraqueza de Trojanizer
('Super Força');            -- Fraqueza de Overclock

CREATE TABLE vilaoDoAluno (
    fkVilao INT,
    fkAluno INT,
    PRIMARY KEY (fkVilao, fkAluno),
    CONSTRAINT fkdoVilao FOREIGN KEY (fkVilao) REFERENCES vilao(idVilao),
    CONSTRAINT fkdoAluno FOREIGN KEY (fkAluno) REFERENCES aluno(RA)
);
INSERT INTO vilaoDoAluno (fkVilao, fkAluno) VALUES
(1, 01242137), -- Dr. Malware enfrenta Paloma (Controle de Tecnologia)
(2, 01242074), -- Shadow enfrenta Luz (Invisibilidade)
(3, 01242015), -- Capitão Bug enfrenta Mateus (Velocidade Sobrenatural)
(4, 01242061), -- Trojanizer enfrenta Calace (Telepatia)
(5, 01242049); -- Overclock enfrenta Luiza (Super Força)

-- FÁCIL --
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

-- (Facil) 13. Liste os vilões em ordem decrescente por ID.
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

-- MÉDIO --
-- (Médio) 1. Nome do Aluno e seu Respectivo Poder
SELECT aluno.nome AS Aluno, poder.poder AS Poder
FROM aluno
JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
JOIN poder ON poderAluno.fkPoder = poder.idPoder;

-- (Médio) 2. Vilões e Suas Fraquezas Correspondentes
SELECT vilao.nome AS Vilão, fraqueza.fraqueza AS Fraqueza
FROM vilao
JOIN fraqueza ON vilao.idVilao = fraqueza.idFraqueza;

-- (Médio) 3. Nome do Aluno e o Vilão Que Irá Enfrentar
SELECT aluno.nome AS Aluno, vilao.nome AS Vilão
FROM aluno
JOIN vilaoDoAluno ON aluno.RA = vilaoDoAluno.fkAluno
JOIN vilao ON vilao.idVilao = vilaoDoAluno.fkVilao;

-- (Médio) 4. Quantidade de alunos enfrentando cada vilão
SELECT vilao.nome AS Vilão, COUNT(vilaoDoAluno.fkAluno) AS Alunos_Enfrentados
FROM vilao
LEFT JOIN vilaoDoAluno ON vilao.idVilao = vilaoDoAluno.fkVilao
GROUP BY vilao.nome;

-- (Médio) 5. Alunos que não têm poderes
SELECT aluno.nome AS Aluno
FROM aluno
LEFT JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
WHERE poderAluno.fkPoder IS NULL;

-- (Médio) 6. Quantidade total de vilões e fraquezas
SELECT (SELECT COUNT(*) FROM vilao) AS Total_Vilões,
(SELECT COUNT(*) FROM fraqueza) AS Total_Fraquezas;

-- (Médio) 7. Alunos com seus respectivos poderes e vilões
SELECT aluno.nome AS Aluno, poder.poder AS Poder, vilao.nome AS Vilão
FROM aluno
JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
JOIN poder ON poderAluno.fkPoder = poder.idPoder
JOIN vilaoDoAluno ON aluno.RA = vilaoDoAluno.fkAluno
JOIN vilao ON vilao.idVilao = vilaoDoAluno.fkVilao;

-- (Médio) 8. Número de Poderes por Aluno
SELECT aluno.nome AS Aluno, COUNT(poderAluno.fkPoder) AS Quantidade_Poderes
FROM aluno
LEFT JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
GROUP BY aluno.nome;

-- (Médio) 9. Resumo geral (alunos, vilões e poderes)	
SELECT (SELECT COUNT(*) FROM aluno) AS Total_Alunos,
(SELECT COUNT(*) FROM vilao) AS Total_Vilões,
(SELECT COUNT(*) FROM poder) AS Total_Poderes,
(SELECT COUNT(*) FROM fraqueza) AS Total_Fraquezas;

-- (Médio) 10. Vilões com Fraquezas Que Correspondem Aos Poderes de Seus Oponentes
SELECT vilao.nome AS Vilão, fraqueza.fraqueza AS Fraqueza, aluno.nome AS Oponente, poder.poder AS Poder_Aluno
FROM vilao
JOIN fraqueza ON vilao.idVilao = fraqueza.idFraqueza
JOIN vilaoDoAluno ON vilao.idVilao = vilaoDoAluno.fkVilao
JOIN aluno ON vilaoDoAluno.fkAluno = aluno.RA
JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
JOIN poder ON poderAluno.fkPoder = poder.idPoder
WHERE fraqueza.fraqueza = poder.poder;

-- DÍFICIL --

/* (Díficil) 1. Identifique quais alunos têm poderes que correspondem às fraquezas dos vilões que enfrentam. */
SELECT v.nome AS NomeVilao,
f.fraqueza AS Fraqueza,
a.nome AS NomeAluno,
p.poder AS PoderAluno
FROM vilao v
LEFT JOIN fraqueza f ON v.caracteristica = f.fraqueza
RIGHT JOIN vilaoDoAluno vda ON v.idVilao = vda.fkVilao
LEFT JOIN aluno a ON vda.fkAluno = a.RA
LEFT JOIN poderAluno pa ON a.RA = pa.fkAluno
LEFT JOIN poder p ON pa.fkPoder = p.idPoder
GROUP BY v.nome, f.fraqueza, a.nome, p.poder;
    

/* (Díficil) 2. Calcule o número de alunos que têm poderes correspondentes às fraquezas de cada vilão. */
SELECT a.nome AS NomeAluno, v.nome AS NomeVilao,
COUNT(pa.fkPoder) AS QuantidadeDePoderes
FROM aluno a
LEFT JOIN vilaoDoAluno vda ON a.RA = vda.fkAluno
LEFT JOIN vilao v ON vda.fkVilao = v.idVilao
LEFT JOIN poderAluno pa ON a.RA = pa.fkAluno
GROUP BY a.nome, v.nome;
    

/* (Díficil) 3. Liste os alunos cujos poderes não correspondem às fraquezas dos vilões que enfrentam. */
SELECT a.nome AS NomeAluno,
p.poder AS PoderAluno,
v.nome AS NomeVilao,f.fraqueza AS Fraqueza
FROM aluno a
LEFT JOIN poderAluno pa ON a.RA = pa.fkAluno
LEFT JOIN poder p ON pa.fkPoder = p.idPoder
LEFT JOIN fraqueza f ON p.poder = f.fraqueza
LEFT JOIN vilao v ON f.fraqueza = v.caracteristica
GROUP BY a.nome, p.poder, v.nome, f.fraqueza;
    
    

/* (Díficil) 4. Calcule a quantidade total de poderes de cada aluno e classifique-os do mais poderoso para o menos poderoso. */
SELECT a.nome AS NomeAluno,
v.nome AS NomeVilao,
p.poder AS PoderQueEFraqueza
FROM aluno a
LEFT JOIN vilaoDoAluno vda ON a.RA = vda.fkAluno
LEFT JOIN vilao v ON vda.fkVilao = v.idVilao
LEFT JOIN poderAluno pa ON a.RA = pa.fkAluno
LEFT JOIN poder p ON pa.fkPoder = p.idPoder
WHERE p.poder IN (
SELECT f.fraqueza
FROM fraqueza f)
GROUP BY a.nome, v.nome, p.poder;


/* (Díficil) 5. Verifique se algum vilão não tem fraqueza registrada ou algum aluno não tem vilão associado.*/
SELECT v.nome AS NomeVilao,
f.fraqueza AS Fraqueza,
COUNT(DISTINCT a.RA) AS AlunosComPoderesCorrespondentes
FROM vilao v
LEFT JOIN fraqueza f ON v.caracteristica = f.fraqueza
LEFT JOIN poder p ON f.fraqueza = p.poder
LEFT JOIN poderAluno pa ON p.idPoder = pa.fkPoder
LEFT JOIN aluno a ON pa.fkAluno = a.RA
GROUP BY v.nome, f.fraqueza;

-- DESAFIO --
-- (Desafio) 1.
--Relatório Detalhado de Alunos, Poderes e Vilões com Funções Matemáticas
-- Instrução:

    --Liste os alunos, seus poderes, os vilões enfrentados e as respectivas fraquezas de cada vilão.
    --Calcule funções matemáticas sobre os poderes dos alunos:
      --  Contagem total de poderes (COUNT),
        --Média dos poderes (AVG),
       -- Maior poder (MAX),
       -- Menor poder (MIN).
    --Inclua apenas os alunos cujos nomes contêm a letra "a".
    --Agrupe os resultados por aluno, poder, vilão e fraqueza.
    --Ordene pela quantidade de poderes em ordem decrescente.
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

-- (Desafio) 2.
--Análise de Vilões com Nome Iniciado por 'C' e Seus Respectivos Alunos
--Instrução:

  --  Liste os alunos e seus poderes relacionados aos vilões cujos nomes começam com a letra "C".
   -- Inclua as seguintes informações:
     --   A quantidade de vilões enfrentados por cada aluno,
       -- O nome do vilão,
        --A fraqueza do vilão,
       -- Estatísticas dos poderes dos alunos (usando funções matemáticas):
         --   Contagem total de poderes (COUNT),
          --  Média dos poderes (AVG),
          --  Maior poder (MAX),
          --  Menor poder (MIN).
    -- Agrupe os resultados por aluno, poder, vilão e fraqueza.
   -- Ordene os resultados pela média dos poderes em ordem crescente.



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

