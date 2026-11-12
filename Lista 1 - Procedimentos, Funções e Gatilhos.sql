CREATE TABLE netflix ( 
    show_id VARCHAR(5) NOT NULL, 
    tipo VARCHAR(10) NOT NULL, 
    title VARCHAR(150) NOT NULL, 
    director VARCHAR(250), 
    elenco TEXT, 
    country VARCHAR(150), 
    date_added DATE, 
    release_year INTEGER NOT NULL, 
    rating VARCHAR(10), 
    duration INTEGER NOT NULL, 
    genres VARCHAR(100) NOT NULL, 
    description TEXT NOT NULL, 
    CONSTRAINT pk_netflix PRIMARY KEY (show_id) 
); 

-- FUNÇÕES

-- Questão 01: Crie uma função capaz de contar a quantidade de títulos existentes de acordo com o tipo informado 
CREATE OR REPLACE FUNCTION contar_titulos_por_tipo(p_tipo VARCHAR) 
RETURNS INTEGER AS $$ 
DECLARE 
    v_total INTEGER; 
BEGIN 
    SELECT COUNT(*) 
    INTO v_total 
    FROM netflix 
    WHERE tipo = p_tipo; 

    RETURN v_total; 
END; 
$$ LANGUAGE plpgsql; 

SELECT contar_titulos_por_tipo('Movie'); 
SELECT contar_titulos_por_tipo('Serie');


-- Questão 02: Crie uma função que receba como parâmetro um ano e retorne a quantidade de títulos lançados naquele determinado ano. 
CREATE OR REPLACE FUNCTION contar_titulos_ano_lancamento(p_ano INTEGER) 
RETURNS INTEGER AS $$ 
DECLARE 
    v_total INTEGER; 
BEGIN 
    SELECT COUNT(*) 
    INTO v_total 
    FROM netflix 
    WHERE release_year = p_ano; 

    RETURN v_total; 
END; 
$$ LANGUAGE plpgsql; 

SELECT contar_titulos_ano_lancamento(2017); 


-- Questão 03: Crie uma função que receba o nome de um país como parâmetro e retorne a quantidade de títulos relacionados a esse país. 
CREATE OR REPLACE FUNCTION contar_titulos_por_pais_origem(p_pais VARCHAR) 
RETURNS INTEGER AS $$ 
DECLARE 
    v_total INTEGER; 
BEGIN 
    SELECT COUNT(*) 
    INTO v_total 
    FROM netflix 
    WHERE country = p_pais; 

    RETURN v_total; 
END; 
$$ LANGUAGE plpgsql; 

SELECT contar_titulos_por_pais_origem('United States'); 
SELECT contar_titulos_por_pais_origem('Brazil'); 


-- Questão 04: Crie uma função que receba um gênero como parâmetro e retorne uma tabela contendo todos os títulos relacionados ao gênero informado 
CREATE OR REPLACE FUNCTION mostrar_titulos_por_genero(p_genero VARCHAR) 
RETURNS TABLE ( 
    titulo VARCHAR(150) 
) AS $$
BEGIN 
    RETURN QUERY 
    SELECT netflix.title 
    FROM netflix 
    WHERE genres ILIKE '%' || p_genero || '%'; 
END; 
$$ LANGUAGE plpgsql; 

SELECT mostrar_titulos_por_genero('Horror Movies'); 
SELECT mostrar_titulos_por_genero('Comedies'); 


-- Questão 05: Crie uma função capaz de calcular a média da duração dos títulos de acordo com o tipo informado. 
CREATE OR REPLACE FUNCTION mostrar_media_de_duracao_por_tipo(p_tipo VARCHAR) 
RETURNS NUMERIC(10, 2) AS $$ 
BEGIN 
    RETURN ( 
        SELECT ROUND(AVG(duration), 2) 
        FROM netflix 
        WHERE tipo = p_tipo 
    ); 
END; 
$$ LANGUAGE plpgsql; 

SELECT mostrar_media_de_duracao_por_tipo('Movie'); 
SELECT mostrar_media_de_duracao_por_tipo('Serie'); 


-- PROCEDIMENTOS

-- Questão 06: Crie uma procedure para alterar os nomes das colunas da tabela Netflix para nomes em português. 
CREATE OR REPLACE PROCEDURE alterar_nome_das_colunas() 
AS $$ 
BEGIN 
    RAISE NOTICE 'Iniciando a tradução dos nomes das colunas da tabela Netflix.'; 
    
    ALTER TABLE netflix RENAME COLUMN show_id TO id_exibicao; 
    ALTER TABLE netflix RENAME COLUMN title TO titulo; 
    ALTER TABLE netflix RENAME COLUMN director TO diretor; 
    ALTER TABLE netflix RENAME COLUMN country TO pais; 
    ALTER TABLE netflix RENAME COLUMN date_added TO data_adicao; 
    ALTER TABLE netflix RENAME COLUMN release_year TO ano_lancamento; 
    ALTER TABLE netflix RENAME COLUMN rating TO classificacao;
    ALTER TABLE netflix RENAME COLUMN duration TO duracao; 
    ALTER TABLE netflix RENAME COLUMN genres TO generos; 
    ALTER TABLE netflix RENAME COLUMN description TO descricao; 
    
    RAISE NOTICE 'Nomes das colunas alterados para português com sucesso!'; 
END; 
$$ LANGUAGE plpgsql; 

CALL alterar_nome_das_colunas(); 


-- Questão 07: Crie uma procedure que permita alterar a classificação indicativa de um título específico. 
CREATE OR REPLACE PROCEDURE alterar_classificacao_titulo(p_titulo VARCHAR, p_nova_classificacao VARCHAR) 
AS $$ 
BEGIN 
    RAISE NOTICE 'Atualizando a classificação do título "%" para "%".', p_titulo, p_nova_classificacao; 
    
    UPDATE netflix 
    SET classificacao = p_nova_classificacao 
    WHERE titulo = p_titulo; 
    
    RAISE NOTICE 'Classificação atualizada com sucesso!'; 
END; 
$$ LANGUAGE plpgsql; 

CALL alterar_classificacao_titulo('Stranger Things', '16'); 


-- Questão 08: Crie uma procedure que permita atualizar a duração de um título da tabela Netflix 
CREATE OR REPLACE PROCEDURE atualizar_duracao_por_titulo(p_titulo VARCHAR, p_nova_duracao INTEGER) 
AS $$ 
BEGIN 
    RAISE NOTICE 'Atualizando a duração do título "%" para %.', p_titulo, p_nova_duracao; 
    
    UPDATE netflix 
    SET duracao = p_nova_duracao 
    WHERE titulo = p_titulo; 
    
    RAISE NOTICE 'Duração atualizada com sucesso!'; 
END; 
$$ LANGUAGE plpgsql; 

CALL atualizar_duracao_por_titulo('Stranger Things', 16);


-- Questão 09: Crie uma procedure que permita atualizar o diretor responsável por um título. 
CREATE OR REPLACE PROCEDURE atualizar_diretor_por_titulo(p_titulo VARCHAR, p_novo_diretor VARCHAR) 
AS $$ 
BEGIN 
    RAISE NOTICE 'Atualizando o diretor do título "%" para "%".', p_titulo, p_novo_diretor; 
    
    UPDATE netflix 
    SET diretor = p_novo_diretor 
    WHERE titulo = p_titulo; 
    
    RAISE NOTICE 'Diretor atualizado com sucesso!'; 
END; 
$$ LANGUAGE plpgsql; 

CALL atualizar_diretor_por_titulo('Stranger Things', 'Anriu'); 


-- Questão 10: Crie uma procedure capaz de excluir títulos anteriores a um determinado ano informado pelo usuário. 
CREATE OR REPLACE PROCEDURE excluir_titulos_anteriores(p_ano INTEGER) 
AS $$ 
BEGIN 
    RAISE NOTICE 'Iniciando a exclusão de títulos lançados antes do ano %.', p_ano; 
    
    DELETE FROM netflix 
    WHERE ano_lancamento < p_ano; 
    
    RAISE NOTICE 'Processo de exclusão finalizado!'; 
END; 
$$ LANGUAGE plpgsql; 

CALL excluir_titulos_anteriores(1500); 


-- GATILHOS (TRIGGERS)

-- Questão 11: Crie um gatilho (trigger) para validar o tipo de conteúdo inserido ou atualizado na tabela Netflix. 
CREATE OR REPLACE FUNCTION validar_tipo_conteudo() 
RETURNS TRIGGER AS $$ 
BEGIN 
    IF NEW.tipo NOT IN ('Filme', 'Serie') THEN 
        RAISE EXCEPTION 'Tipo de conteúdo inválido: %. Use Filme ou Serie.', NEW.tipo; 
    END IF;
    
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 

CREATE TRIGGER trg_validar_tipo_conteudo 
BEFORE INSERT OR UPDATE OF tipo 
ON netflix 
FOR EACH ROW 
EXECUTE FUNCTION validar_tipo_conteudo(); 


-- Questão 12: Crie um gatilho (trigger) que impeça a inserção ou atualização de títulos com ano de lançamento futuro. 
CREATE OR REPLACE FUNCTION validar_ano_lancamento() 
RETURNS TRIGGER AS $$ 
BEGIN 
    IF NEW.ano_lancamento > EXTRACT(YEAR FROM CURRENT_DATE) THEN 
        RAISE EXCEPTION 'Ano de lançamento inválido: %. O ano não pode ser futuro.', NEW.ano_lancamento; 
    END IF;
    
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql; 

CREATE TRIGGER trg_validar_ano_lancamento 
BEFORE INSERT OR UPDATE OF ano_lancamento 
ON netflix 
FOR EACH ROW 
EXECUTE FUNCTION validar_ano_lancamento(); 


-- Questão 13: Crie um gatilho (trigger) que converta automaticamente o título de um conteúdo para letras maiúsculas. 
CREATE OR REPLACE FUNCTION converter_titulo_maiusculo() 
RETURNS TRIGGER AS $$ 
BEGIN 
    NEW.titulo = UPPER(NEW.titulo); 
    RETURN NEW; 
END; 
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_converter_titulo_maiusculo 
BEFORE INSERT OR UPDATE OF titulo 
ON netflix 
FOR EACH ROW 
EXECUTE FUNCTION converter_titulo_maiusculo(); 


-- Questão 14: Crie uma tabela denominada auditoria_netflix para registrar operações realizadas na tabela Netflix. 
CREATE TABLE auditoria_netflix ( 
    id_auditoria SERIAL PRIMARY KEY, 
    operacao VARCHAR(10) NOT NULL, 
    id_exibicao VARCHAR(5), 
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    informacoes TEXT 
); 

CREATE OR REPLACE FUNCTION registrar_auditoria_netflix() 
RETURNS TRIGGER AS $$ 
BEGIN 
    IF TG_OP = 'INSERT' THEN 
        INSERT INTO auditoria_netflix ( 
            operacao, 
            id_exibicao, 
            informacoes 
        ) 
        VALUES ( 
            'INSERT', 
            NEW.id_exibicao, 
            'Título inserido: ' || NEW.titulo 
        ); 
        RETURN NEW; 
        
    ELSIF TG_OP = 'UPDATE' THEN 
        INSERT INTO auditoria_netflix ( 
            operacao, 
            id_exibicao, 
            informacoes 
        ) 
        VALUES ( 
            'UPDATE', 
            NEW.id_exibicao, 
            'Título alterado: ' || OLD.titulo || ' para ' || NEW.titulo 
        );
        RETURN NEW; 
        
    ELSIF TG_OP = 'DELETE' THEN 
        INSERT INTO auditoria_netflix ( 
            operacao, 
            id_exibicao, 
            informacoes 
        ) 
        VALUES ( 
            'DELETE', 
            OLD.id_exibicao, 
            'Título excluído: ' || OLD.titulo 
        ); 
        RETURN OLD; 
    END IF; 
END; 
$$ LANGUAGE plpgsql; 

CREATE TRIGGER trg_auditoria_netflix 
AFTER INSERT OR UPDATE OR DELETE 
ON netflix 
FOR EACH ROW 
EXECUTE FUNCTION registrar_auditoria_netflix(); 


-- Questão 15: Crie um gatilho (trigger) que impeça a exclusão de títulos recentes. 
CREATE OR REPLACE FUNCTION impedir_exclusao_titulo_recente() 
RETURNS TRIGGER AS $$ 
BEGIN 
    IF OLD.ano_lancamento = EXTRACT(YEAR FROM CURRENT_DATE) - 1 THEN 
        RAISE EXCEPTION 'Exclusão cancelada: o título "%" é recente e não pode ser excluído.', OLD.titulo; 
    END IF; 
    
    RETURN OLD; 
END; 
$$ LANGUAGE plpgsql; 

CREATE TRIGGER trg_impedir_exclusao_recente
BEFORE DELETE 
ON netflix 
FOR EACH ROW 
EXECUTE FUNCTION impedir_exclusao_titulo_recente();