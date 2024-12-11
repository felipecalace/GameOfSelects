	
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


