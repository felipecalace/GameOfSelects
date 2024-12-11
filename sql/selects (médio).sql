CREATE DATABASE SPTech;

USE SPTech;

CREATE TABLE aluno(
    RA INT PRIMARY KEY,
    nome VARCHAR(50)
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
    idPoderAluno int AUTO_INCREMENT,
    fkPoder int,
    fkAluno int,
    FOREIGN KEY(fkAluno) REFERENCES aluno(RA),
    FOREIGN KEY(fkPoder) REFERENCES poder(idPoder),
    PRIMARY KEY(idPoderAluno, fkAluno, fkPoder)
);
INSERT INTO poderAluno (fkPoder, fkAluno) VALUES
(1, 01242074), -- Luz: Invisibilidade
(2, 01242049), -- Luiza: Super Força
(3, 01242137), -- Paloma: Controle de Tecnologia
(4, 01242061), -- Calace: Telepatia
(5, 01242015); -- Mateus: Velocidade Sobrenatural


CREATE TABLE vilao (
    idVilao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    caracteristica VARCHAR(100)
);
INSERT INTO vilao (nome, caracteristica) VALUES
('Dr. Malware', 'Controla vírus digitais'),
('Shadow', 'Manipula as sombras'),
('Capitão Bug', 'Causa erros e sabota sistemas'),
('Trojanizer', 'Mestre da infiltração furtiva'),
('Overclock', 'Extremamente rápido, mas instável');

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
(3, 01242015), -- Captain Bug enfrenta Mateus (Velocidade Sobrenatural)
(4, 01242061), -- Trojanizer enfrenta Calace (Telepatia)
(5, 01242049); -- Overclock enfrenta Luiza (Super Força)


-- MÉDIO --
-- 1. Nome do Aluno e seu Respectivo Poder
SELECT aluno.nome AS Aluno, poder.poder AS Poder
FROM aluno
JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
JOIN poder ON poderAluno.fkPoder = poder.idPoder;

-- 2. Vilões e Suas Fraquezas Correspondentes
SELECT vilao.nome AS Vilão, fraqueza.fraqueza AS Fraqueza
FROM vilao
JOIN fraqueza ON vilao.idVilao = fraqueza.idFraqueza;

-- 3. Nome do Aluno e o Vilão Que Irá Enfrentar
SELECT aluno.nome AS Aluno, vilao.nome AS Vilão
FROM aluno
JOIN vilaoDoAluno ON aluno.RA = vilaoDoAluno.fkAluno
JOIN vilao ON vilao.idVilao = vilaoDoAluno.fkVilao;

-- 4. Quantidade de alunos enfrentando cada vilão
SELECT vilao.nome AS Vilão, COUNT(vilaoDoAluno.fkAluno) AS Alunos_Enfrentados
FROM vilao
LEFT JOIN vilaoDoAluno ON vilao.idVilao = vilaoDoAluno.fkVilao
GROUP BY vilao.nome;

-- 5. Alunos que não têm poderes
SELECT aluno.nome AS Aluno
FROM aluno
LEFT JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
WHERE poderAluno.fkPoder IS NULL;

-- 6. Quantidade total de vilões e fraquezas
SELECT (SELECT COUNT(*) FROM vilao) AS Total_Vilões,
(SELECT COUNT(*) FROM fraqueza) AS Total_Fraquezas;

-- 7. Alunos com seus respectivos poderes e vilões
SELECT aluno.nome AS Aluno, poder.poder AS Poder, vilao.nome AS Vilão
FROM aluno
JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
JOIN poder ON poderAluno.fkPoder = poder.idPoder
JOIN vilaoDoAluno ON aluno.RA = vilaoDoAluno.fkAluno
JOIN vilao ON vilao.idVilao = vilaoDoAluno.fkVilao;

-- 8. Número de Poderes por Aluno
SELECT aluno.nome AS Aluno, COUNT(poderAluno.fkPoder) AS Quantidade_Poderes
FROM aluno
LEFT JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
GROUP BY aluno.nome;

-- 9. Resumo geral (alunos, vilões e poderes)	
SELECT (SELECT COUNT(*) FROM aluno) AS Total_Alunos,
(SELECT COUNT(*) FROM vilao) AS Total_Vilões,
(SELECT COUNT(*) FROM poder) AS Total_Poderes,
(SELECT COUNT(*) FROM fraqueza) AS Total_Fraquezas;

-- 10. Vilões com Fraquezas Que Correspondem Aos Poderes de Seus Oponentes
SELECT vilao.nome AS Vilão, fraqueza.fraqueza AS Fraqueza, aluno.nome AS Oponente, poder.poder AS Poder_Aluno
FROM vilao
JOIN fraqueza ON vilao.idVilao = fraqueza.idFraqueza
JOIN vilaoDoAluno ON vilao.idVilao = vilaoDoAluno.fkVilao
JOIN aluno ON vilaoDoAluno.fkAluno = aluno.RA
JOIN poderAluno ON aluno.RA = poderAluno.fkAluno
JOIN poder ON poderAluno.fkPoder = poder.idPoder
WHERE fraqueza.fraqueza = poder.poder;




