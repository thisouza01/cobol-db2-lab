000001 --INSERT INTO FUNCIONARIOS             
000002 --  VALUES('AA01',                   
000003 --         'THIAGO SOUZA',           
000004 --         1210.45,                  
000005 --         'ADM',                    
000006 --         '08/15/2025',             
000007 --         23,                       
000008 --         'THIAGO@TESTE.COM')      
000009 -----------------------------------  
000010 --INSERT INTO DEPARTAMENTOS          
000011 --    VALUES('ADM',                  
000012 --           'ADMINISTRACAO')        
000013 -----------------------------------  
000014   SELECT * FROM FUNCIONARIOS;         
000015 -----------------------------------                             
000016   SELECT NOMEFUN, SALARIOFUN, ADMISSFUN                         
000017         FROM FUNCIONARIOS                                       
000018         WHERE ADMISSFUN BETWEEN '2025-08-01' AND '2025-09-30'   
000019         ORDER BY NOMEFUN                                        

