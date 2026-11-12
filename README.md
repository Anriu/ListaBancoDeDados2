# 🐘 Listas de Exercícios — Banco de Dados II

Repositório dedicado à resolução das listas práticas da disciplina de **Banco de Dados II**, explorando recursos avançados de programação, otimização de consultas e controle transacional no **PostgreSQL**.

## 📂 Arquivos do Repositório

* **[Lista 01 — Procedimentos, Funções e Gatilhos](./Lista%201%20-%20Procedimentos,%20Fun%C3%A7%C3%B5es%20e%20Gatilhos.sql)**
  * **Procedimentos Armazenados (*Stored Procedures*):** Encapsulamento de regras de negócio e rotinas de manipulação de dados no servidor.
  * **Funções (*Functions*):** Criação de rotinas em PL/pgSQL com retorno de valores e uso integrado em consultas.
  * **Gatilhos (*Triggers*):** Automação de ações (`BEFORE` e `AFTER`) disparadas por eventos de `INSERT`, `UPDATE` e `DELETE`.

* **[Lista 02 — Views, Views Materializadas e Transações](./Lista%202%20-%20Views,%20Views%20Materializadas%20e%20Transa%C3%A7%C3%B5es.sql)**
  * **Views:** Criação de tabelas virtuais para abstração de consultas complexas e controle de visualização.
  * **Views Materializadas (*Materialized Views*):** Persistência física de resultados para ganho de performance e atualização via `REFRESH MATERIALIZED VIEW`.
  * **Transações:** Controle de concorrência e garantia das propriedades ACID utilizando `BEGIN`, `COMMIT`, `ROLLBACK` e `SAVEPOINT`.

## 🛠️ Tecnologias Utilizadas

* **SGBD:** PostgreSQL
* **Linguagens:** SQL e PL/pgSQL

## 🚀 Como Executar

1. Clone este repositório:
   ```bash
   git clone [https://github.com/Anriu/ListaBancoDeDados2.git](https://github.com/Anriu/ListaBancoDeDados2.git)