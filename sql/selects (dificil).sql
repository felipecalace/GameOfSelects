
/* 1. Identifique quais alunos têm poderes que correspondem às fraquezas dos vilões que enfrentam. */
SELECT v.nome AS NomeVilao,
    f.fraqueza AS Fraqueza,
    a.nome AS NomeAluno,
    p.poder AS PoderAluno
FROM 
    vilao v
LEFT JOIN 
    fraqueza f ON v.caracteristica = f.fraqueza
RIGHT JOIN 
    vilaoDoAluno vda ON v.idVilao = vda.fkVilao
LEFT JOIN 
    aluno a ON vda.fkAluno = a.RA
LEFT JOIN 
    poderAluno pa ON a.RA = pa.fkAluno
LEFT JOIN 
    poder p ON pa.fkPoder = p.idPoder
GROUP BY 
    v.nome, f.fraqueza, a.nome, p.poder;
    

/* 2. Calcule o número de alunos que têm poderes correspondentes às fraquezas de cada vilão. */
SELECT 
    a.nome AS NomeAluno,
    v.nome AS NomeVilao,
    COUNT(pa.fkPoder) AS QuantidadeDePoderes
FROM 
    aluno a
LEFT JOIN 
    vilaoDoAluno vda ON a.RA = vda.fkAluno
LEFT JOIN 
    vilao v ON vda.fkVilao = v.idVilao
LEFT JOIN 
    poderAluno pa ON a.RA = pa.fkAluno
GROUP BY 
    a.nome, v.nome;
    

/* 3. Liste os alunos cujos poderes não correspondem às fraquezas dos vilões que enfrentam. */
SELECT 
    a.nome AS NomeAluno,
    p.poder AS PoderAluno,
    v.nome AS NomeVilao,
    f.fraqueza AS Fraqueza
FROM 
    aluno a
LEFT JOIN 
    poderAluno pa ON a.RA = pa.fkAluno
LEFT JOIN 
    poder p ON pa.fkPoder = p.idPoder
LEFT JOIN 
    fraqueza f ON p.poder = f.fraqueza
LEFT JOIN 
    vilao v ON f.fraqueza = v.caracteristica
GROUP BY 
    a.nome, p.poder, v.nome, f.fraqueza;
    
    

/* 4. Calcule a quantidade total de poderes de cada aluno e classifique-os do mais poderoso para o menos poderoso. */
SELECT 
    a.nome AS NomeAluno,
    v.nome AS NomeVilao,
    p.poder AS PoderQueEFraqueza
FROM 
    aluno a
LEFT JOIN 
    vilaoDoAluno vda ON a.RA = vda.fkAluno
LEFT JOIN 
    vilao v ON vda.fkVilao = v.idVilao
LEFT JOIN 
    poderAluno pa ON a.RA = pa.fkAluno
LEFT JOIN 
    poder p ON pa.fkPoder = p.idPoder
WHERE 
    p.poder IN (
        SELECT 
            f.fraqueza
        FROM 
            fraqueza f
    )
GROUP BY 
    a.nome, v.nome, p.poder;


/*5. Verifique se algum vilão não tem fraqueza registrada ou algum aluno não tem vilão associado.*/
SELECT 
    v.nome AS NomeVilao,
    f.fraqueza AS Fraqueza,
    COUNT(DISTINCT a.RA) AS AlunosComPoderesCorrespondentes
FROM 
    vilao v
LEFT JOIN 
    fraqueza f ON v.caracteristica = f.fraqueza
LEFT JOIN 
    poder p ON f.fraqueza = p.poder
LEFT JOIN 
    poderAluno pa ON p.idPoder = pa.fkPoder
LEFT JOIN 
    aluno a ON pa.fkAluno = a.RA
GROUP BY 
    v.nome, f.fraqueza;