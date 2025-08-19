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
000016 --SELECT NOMEFUN, SALARIOFUN, ADMISSFUN                         
000017 --      FROM FUNCIONARIOS                                       
000018 --      WHERE ADMISSFUN BETWEEN '2025-08-01' AND '2025-09-30'   
000019 --      ORDER BY NOMEFUN    
000020 -----------------------------------      
000021 --SELECT NOMEFUN, SALARIOFUN, IDADEFUN   
000022 --      FROM FUNCIONARIOS                
000023 --      WHERE IDADEFUN IN(20, 22)        
000024 --      ORDER BY NOMEFUN         
000025 -----------------------------------   
000026 --SELECT NOMEFUN, SALARIOFUN          
000027 --      FROM FUNCIONARIOS             
000028 --      WHERE NOMEFUN LIKE '%T%'      
000029 --      ORDER BY NOMEFUN DESC         
000030 -----------------------------------                       
000031 --SELECT SUM(SALARIOFUN) AS "SOMA DOS SALARIOS DA ADM"    
000032 --      FROM FUNCIONARIOS                                 
000033 --      WHERE DEPTOFUN = 'ADM'  
000034 -----------------------------------                        
000035 --SELECT DEPTOFUN, SUM(SALARIOFUN) AS "SOMA DOS SALARIOS"  
000036 --      FROM FUNCIONARIOS                                  
000037 --      GROUP BY DEPTOFUN       
000038 -----------------------------------                      
000039 --SELECT FUNC.NOMEFUN, DEPT.NOMEDEPTO, FUNC.SALARIOFUN   
000040 --      FROM FUNCIONARIOS FUNC,                          
000041 --           DEPARTAMENTOS DEPT                          
000042 --      WHERE DEPT.CODDEPTO = FUNC.DEPTOFUN              
000043 --           AND SALARIOFUN > 1000.00                    
000044 --      ORDER BY NOMEFUN  
000045 -----------------------------------          
000046   SELECT NOMEFUN, SALARIOFUN                 
000047         FROM FUNCIONARIOS                    
000048         WHERE DEPTOFUN = 'ADM'               
000049               AND SALARIOFUN >               
000050         (SELECT AVG(SALARIOFUN)              
000051                FROM FUNCIONARIOS             
000052                WHERE DEPTOFUN = 'RH')        
000053         ORDER BY NOMEFUN                     

