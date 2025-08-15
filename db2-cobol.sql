000001 --CREATE TABLE DEPARTAMENTOS                       
000002 --    (CODDEPTO     CHAR(3) PRIMARY KEY NOT NULL,  
000003 --     NOMEDEPTO    VARCHAR(30)         NOT NULL)  
000004 --------------------------------------------------
000005 --DROP   TABLE DEPARTAMENTOS                      
000006 --------------------------------------------------
000007 --CREATE TABLE FUNCIONARIOS                       
000008 --    (CODFUN       CHAR(4) PRIMARY KEY NOT NULL, 
000009 --     NOMEFUN      VARCHAR(30)         NOT NULL, 
000010 --     SALARIOFUN   DECIMAL(8,2)        NOT NULL, 
000011 --     DEPTOFUN     CHAR(3)             NOT NULL, 
000012 --     ADMISSFUN    DATE                NOT NULL, 
000013 --     IDADEFUN     SMALLINT            NOT NULL, 
000014 --     EMAILFUN     VARCHAR(30))                  
000015 --------------------------------------------------
000016   CREATE UNIQUE INDEX IDXFUNC                     
000017       ON FUNCIONARIOS(CODFUN);                    
000018   CREATE UNIQUE INDEX IDXDEPTO                    
000019       ON DEPARTAMENTOS(CODDEPTO)                  
000020 --------------------------------------------------