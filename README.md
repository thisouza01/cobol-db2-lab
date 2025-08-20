# Curso de DB2 em Mainframe

Este repositório contém anotações e exemplos práticos do **curso de DB2 em Mainframe**.  
O curso está dividido em duas partes principais: fundamentos de SQL e integração do DB2 com programas COBOL.

---

## Parte 1 – Fundamentos de SQL

Nesta etapa, o foco é aprender os conceitos básicos de **manipulação de dados** e **definição de estruturas no DB2**.  
Principais tópicos estudados:

- **DDL (Data Definition Language)**  
  - `CREATE` → criar tabelas, índices e outros objetos.  
  - `ALTER` → alterar a estrutura de tabelas.  
  - `DROP` → remover objetos do banco.  

- **DML (Data Manipulation Language)**  
  - `INSERT` → inserir registros.  
  - `UPDATE` → atualizar registros existentes.  
  - `DELETE` → excluir registros.  
  - `SELECT` → consultar dados.  

- **Condições e cláusulas para filtragem**  
  - `WHERE` → aplicar condições.  
  - `BETWEEN`, `IN`, `LIKE`, `IS NULL`.  
  - Operadores lógicos: `AND`, `OR`, `NOT`.  
  - Ordenação e agrupamento: `ORDER BY`, `GROUP BY`, `HAVING`.  

---

## Parte 2 – Integração DB2 + COBOL

Nesta fase, o curso mostra como **programas COBOL podem interagir com o DB2**.  
Isso é feito utilizando o **DCLGEN** e comandos **SQL embutidos no COBOL**.

- **DCLGEN (Declaration Generator)**  
  - Ferramenta que gera automaticamente as **declarações de tabelas** para uso em COBOL.  
  - Cria estruturas de **COPYBOOKS** compatíveis com as tabelas do DB2.  

- **EXEC SQL** no COBOL  
  - Permite inserir instruções SQL diretamente dentro de um programa COBOL.  
  - Exemplos comuns:  
    ```cobol
    EXEC SQL
        SELECT COLUNA1, COLUNA2
        INTO :VAR1, :VAR2
        FROM TABELA
        WHERE CONDICAO = :VAR-CONDI
    END-EXEC.
    ```
  - Uso de **host variables** (variáveis COBOL conectadas aos campos do DB2).  

---

## Objetivo do Curso

- Dominar o **SQL básico no DB2**.  
- Aprender a **interagir com DB2 via COBOL**, utilizando **DCLGEN** e **EXEC SQL**.  
- Desenvolver aplicações que realizam **operações de consulta, inserção, atualização e exclusão** diretamente no banco DB2.  
