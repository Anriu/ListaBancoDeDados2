-- Lista 02 

-- VIEWS COMUNS
-- 01 
CREATE OR REPLACE VIEW vw_titulos_netflix AS
SELECT 
    titulo,
    tipo,
    ano_lancamento,
    classificacao,
    duracao
FROM netflix;

SELECT * FROM vw_titulos_netflix;


-- 02 
CREATE OR REPLACE VIEW vw_filmes_netflix AS 
SELECT 
    titulo,
    diretor,
    ano_lancamento,
    duracao
FROM netflix
WHERE tipo = 'Filme';

SELECT * FROM vw_filmes_netflix;


-- 03 
CREATE OR REPLACE VIEW vw_titulos_recentes AS 
SELECT 
    titulo,
    tipo,
    ano_lancamento
FROM netflix
WHERE ano_lancamento >= 2020;

SELECT * FROM vw_titulos_recentes;


-- 04 
CREATE OR REPLACE VIEW vw_quantidade_por_tipo AS 
SELECT 
	tipo,
	COUNT(*) AS quantidade
FROM netflix
GROUP BY tipo;

SELECT * FROM vw_quantidade_por_tipo;


-- 05
CREATE OR REPLACE VIEW vw_titulos_por_pais AS
SELECT
	titulo,
	pais,
	ano_lancamento
FROM netflix;

SELECT * FROM vw_titulos_por_pais;


-- Views Materializadas

-- 06
CREATE MATERIALIZED VIEW mv_quantidade_por_tipo AS 
SELECT 
    tipo,
    COUNT(*) AS quantidade
FROM netflix
GROUP BY tipo;


SELECT * FROM mv_quantidade_por_tipo;

-- 07
CREATE MATERIALIZED VIEW mv_titulos_por_ano AS 
SELECT 
	ano_lancamento,
	COUNT(*) AS quantidade
FROM netflix
GROUP BY ano_lancamento;

SELECT * FROM mv_titulos_por_ano;

-- 08 
CREATE MATERIALIZED VIEW mv_media_duracao_por_tipo AS
SELECT
	tipo,
	ROUND(AVG(duracao), 2) AS media_duracao
FROM netflix
GROUP BY tipo;

SELECT * FROM mv_media_duracao_por_tipo;

-- 09

INSERT INTO netflix (
    id_exibicao, 
    tipo, 
    titulo, 
    diretor, 
    elenco, 
    pais, 
    data_adicao, 
    ano_lancamento, 
    classificacao, 
    duracao, 
    generos, 
    descricao
) VALUES 
(
    'z1999', 
    'Filme', 
    'O Irlandês', 
    'Martin Scorsese', 
    'Robert De Niro, Al Pacino, Joe Pesci', 
    'United States', 
    '2019-11-27', 
    2019, 
    'R', 
    209, 
    'Crimes, Dramas', 
    'Um motorista de caminhão se torna um assassino de aluguel envolvido com a máfia.'
),
(
    'z2999', 
    'Serie', 
    'Stranger Things', 
    NULL, 
    'Winona Ryder, David Harbour, Millie Bobby Brown', 
    'United States', 
    '2016-07-15', 
    2016, 
    'TV-14', 
    4, 
    'Séries de ficção científica, Séries de terror', 
    'Quando um garoto desaparece, uma pequena cidade descobre um mistério envolvendo experimentos secretos.'
),
(
    'z3999', 
    'Filme', 
    'Cidade de Deus', 
    'Fernando Meirelles, Kátia Lund', 
    'Alexandre Rodrigues, Leandro Firmino, Seu Jorge', 
    'Brazil', 
    '2020-09-01', 
    2002, 
    'R', 
    130, 
    'Dramas, Filmes independentes', 
    'Dois meninos crescendo em um bairro violento do Rio de Janeiro tomam caminhos diferentes.'
),
(
    'z4999', 
    'Filme', 
    'Glass Onion: Um Mistério Knives Out', 
    'Rian Johnson', 
    'Daniel Craig, Edward Norton, Janelle Monáe', 
    'United States', 
    '2022-12-23', 
    2022, 
    'PG-13', 
    139, 
    'Comédia, Mistério', 
    'O detetive Benoit Blanc viaja para a Grécia para desvendar um mistério envolvendo um bilionário da tecnologia.'
),
(
    'z5999', 
    'Serie', 
    'Sintonia', 
    NULL, 
    'Jottapê, Christian Malheiros, Bruna Mascarenhas', 
    'Brazil', 
    '2021-10-27', 
    2021, 
    'TV-MA', 
    3, 
    'Séries dramáticas', 
    'Três amigos da mesma favela de São Paulo perseguem seus sonhos enquanto dependem do apoio mútuo.'
);

-- Ao adicionar novas séries ao catálogo, elas só passam a constar na view materializada após a execução do comando de atualização.
REFRESH MATERIALIZED VIEW mv_quantidade_por_tipo;


-- 10
CREATE MATERIALIZED VIEW mv_titulos_por_classificacao AS 
SELECT 
    classificacao,
    COUNT(*) AS quantidade_classificacao
FROM netflix
GROUP BY classificacao;

SELECT * 
FROM mv_titulos_por_classificacao 
ORDER BY quantidade_classificacao DESC;


-- Transações

-- 11

ROLLBACK;

BEGIN;

INSERT INTO netflix (
    id_exibicao, 
    tipo, 
    titulo, 
    diretor, 
    elenco, 
    pais, 
    data_adicao, 
    ano_lancamento, 
    classificacao, 
    duracao, 
    generos, 
    descricao
) VALUES (
    'k999', 
    'Filme', 
    'Matrix Resurrections', 
    'Lana Wachowski', 
    'Keanu Reeves, Carrie-Anne Moss', 
    'United States', 
    '2021-12-22', 
    2021, 
    '14', 
    148, 
    'Ação, Ficção Científica', 
    'Retorne a um mundo de duas realidades.'
);

SELECT * 
FROM netflix 
WHERE id_exibicao = 'k999';

COMMIT;


-- 12 

BEGIN;

UPDATE netflix 
SET ano_lancamento = 1999 
WHERE id_exibicao = 's1';

ROLLBACK;

SELECT id_exibicao, titulo, ano_lancamento 
FROM netflix 
WHERE id_exibicao = 's1';


-- 13
BEGIN;

UPDATE netflix 
SET classificacao = '16' 
WHERE id_exibicao = 's1';

UPDATE netflix 
SET duracao = 120 
WHERE id_exibicao = 's1';

COMMIT;

SELECT id_exibicao, titulo, classificacao, duracao 
FROM netflix 
WHERE id_exibicao = 's1';

-- 14
BEGIN;

DELETE FROM netflix 
WHERE id_exibicao = 's10';

SELECT * 
FROM netflix 
WHERE id_exibicao = 's10';

ROLLBACK;

SELECT id_exibicao, titulo 
FROM netflix 
WHERE id_exibicao = 's10';


-- 15 
-- Primeira operação 
BEGIN;

UPDATE netflix 
SET classificacao = 'Livre' 
WHERE ano_lancamento < 2000 AND classificacao IS NULL;

UPDATE netflix 
SET generos = 'Clássicos, Dramas' 
WHERE id_exibicao = 's100';

COMMIT;

-- Segunda operação 
BEGIN;

UPDATE netflix 
SET classificacao = '18' 
WHERE id_exibicao = 's100';

UPDATE netflix 
SET titulo = NULL 
WHERE id_exibicao = 's100';

ROLLBACK;

