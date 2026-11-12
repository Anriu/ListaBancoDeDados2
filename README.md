# 🐘 Listas de Exercícios — Banco de Dados II

Repositório dedicado à resolução das listas práticas da disciplina de **Banco de Dados II**, explorando recursos avançados de programação procedural, otimização de consultas e controle transacional no **PostgreSQL**.

## 📊 Base de Dados

As atividades utilizam dados reais do catálogo da **Netflix**, obtidos a partir do Kaggle e importados para o banco de dados durante as aulas.

* **Fonte do Dataset:** [Netflix Dataset — Kaggle](https://www.kaggle.com/datasets/imtkaggleteam/netflix)

## 📂 Arquivos do Repositório

* **[Lista 01 — Procedimentos, Funções e Gatilhos](./Lista%201%20-%20Procedimentos,%20Fun%C3%A7%C3%B5es%20e%20Gatilhos.sql)**
  * **Funções (*Functions*):** Consultas parametrizadas em PL/pgSQL com retorno escalar e tabular (`RETURNS TABLE`) para contagem por tipo, ano, país, busca por gênero e média de duração.
  * **Procedimentos Armazenados (*Stored Procedures*):** Rotinas para refatoração de esquema (`ALTER TABLE RENAME COLUMN` para português), atualização de metadados (classificação, duração, diretor) e limpeza de registros antigos.
  * **Gatilhos (*Triggers*):** Regras de validação (`BEFORE INSERT/UPDATE/DELETE`) para integridade de tipos e anos de lançamento, formatação automática de títulos em caixa alta, bloqueio de exclusão de títulos recentes e log completo na tabela `auditoria_netflix`.

* **[Lista 02 — Views, Views Materializadas e Transações](./Lista%202%20-%20Views,%20Views%20Materializadas%20e%20Transa%C3%A7%C3%B5es.sql)**
  * **Views:** Criação de visões para filtragem de filmes, lançamentos recentes e agrupamentos por tipo e país.
  * **Views Materializadas (*Materialized Views*):** Persistência de métricas agregadas e atualização manual de cache via `REFRESH MATERIALIZED VIEW` após novas inserções.
  * **Transações:** Controle de atomicidade e consistência utilizando blocos `BEGIN`, `COMMIT` e `ROLLBACK` em operações de inserção, atualização em lote e exclusão.

## 🛠️ Tecnologias Utilizadas

* **SGBD:** PostgreSQL
* **Linguagens:** SQL e PL/pgSQL

## 🚀 Como Executar

1. Clone este repositório:
   ```bash
   git clone [https://github.com/Anriu/ListaBancoDeDados2.git](https://github.com/Anriu/ListaBancoDeDados2.git)
   ```
2. Conecte-se à sua instância do **PostgreSQL** utilizando um cliente de sua preferência (pgAdmin, DBeaver, DataGrip ou `psql`).
3. Crie a tabela `netflix` a partir do início do script da **Lista 01** e importe os registros do [dataset do Kaggle](https://www.kaggle.com/datasets/imtkaggleteam/netflix) (ou utilize os comandos de inserção presentes nos scripts).
4. Execute o restante da **Lista 01** (funções, procedimentos de renomeação das colunas para português e gatilhos) e, em seguida, execute o script da **Lista 02**.
