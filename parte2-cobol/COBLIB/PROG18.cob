000001        IDENTIFICATION DIVISION.                                        
000002        PROGRAM-ID.    EAD71918.                                        
000003        AUTHOR.        THIAGO.                                          
000004       **************************************************               
000005       * INCLUSAO, EXCLUSAO E ALTERACAO DE FUNCIONARIOS *               
000006       **************************************************               
000007       *                                                                
000008        ENVIRONMENT DIVISION.                                           
000009        CONFIGURATION SECTION.                                          
000010        SPECIAL-NAMES.                                                  
000011            DECIMAL-POINT IS COMMA.                                     
000012        INPUT-OUTPUT SECTION.                                           
000013        FILE-CONTROL.                                                   
000014       *                                                                
000015        DATA DIVISION.                                                  
000016        FILE SECTION.                                                   
000017        WORKING-STORAGE SECTION.                                        
000018            EXEC SQL                                                    
000019                INCLUDE BOOKFUNC                                        
000020            END-EXEC.                                                   
000021            EXEC SQL                                                    
000022                INCLUDE SQLCA                                           
000023            END-EXEC.                                                   
000024        77  WK-SALARIO-EDIT           PIC ZZZ.ZZ9,99  VALUE ZEROS.      
000025        77  WK-SQLCODE-EDIT           PIC -999        VALUE ZEROS.      
000026        77  WK-POSICAO                PIC 99          VALUE ZEROS.      
000027        01  WK-ACCEPT.                                                  
000028            05 WK-FUNCAO-ACCEPT       PIC X           VALUE SPACES.     
000029            05 WK-CODFUN-ACCEPT       PIC X(4)        VALUE SPACES.     
000030            05 WK-NOMEFUN-ACCEPT      PIC X(30)       VALUE SPACES.     
000031            05 WK-SALARIOFUN-ACCEPT   PIC 9(6)V99     VALUE ZEROS.      
000032            05 WK-DEPTOFUN-ACCEPT     PIC X(3)        VALUE SPACES.     
000033            05 WK-ADMISSFUN-ACCEPT    PIC X(10)       VALUE SPACES.     
000034            05 WK-IDADEFUN-ACCEPT     PIC 99          VALUE ZEROS.      
000035        77  WK-EMAILFUN-ACCEPT     PIC X(30)       VALUE SPACES.         
000036       *                                                                 
000037        PROCEDURE DIVISION.                                              
000038        000-PRINCIPAL SECTION.                                           
000039        001-PRINCIPAL.                                                   
000040            PERFORM 101-INICIAR.                                         
000041            PERFORM 201-PROCESSAR.                                       
000042            PERFORM 901-FINALIZAR.                                       
000043            STOP RUN.                                                    
000044       *******************************************************           
000045        100-INICIAR SECTION.                                             
000046        101-INICIAR.                                                     
000047            ACCEPT WK-ACCEPT FROM SYSIN.                                 
000048            ACCEPT WK-ACCEPT FROM SYSIN.                                 
000049            ACCEPT WK-EMAILFUN-ACCEPT FROM SYSIN.                        
000050       *******************************************************           
000051        200-PROCESSAR SECTION.                                           
000052        201-PROCESSAR.                                                   
000053            EVALUATE WK-FUNCAO-ACCEPT                                    
000054                WHEN 'I'                                                 
000055                    PERFORM 202-INCLUSAO                                 
000056                WHEN 'E'                                                 
000057                    PERFORM 203-EXCLUSAO                                 
000058                WHEN 'A'                                                 
000059                    PERFORM 204-ALTERACAO                                
000060                WHEN OTHER                                               
000061                    DISPLAY 'FUNCAO ' WK-FUNCAO-ACCEPT ' INVALIDA!'      
000062            END-EVALUATE.                                                
000063       *                                                                 
000064        202-INCLUSAO.                                                    
000065            MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.                     
000066            MOVE WK-NOMEFUN-ACCEPT    TO DB2-NOMEFUN-TEXT.               
000067            PERFORM 205-CONTA-NOMEFUN.                                   
000068            MOVE WK-SALARIOFUN-ACCEPT TO DB2-SALARIOFUN.                 
000069            MOVE WK-DEPTOFUN-ACCEPT   TO DB2-DEPTOFUN.                   
000070            MOVE WK-ADMISSFUN-ACCEPT  TO DB2-ADMISSFUN.                  
000071            MOVE WK-IDADEFUN-ACCEPT   TO DB2-IDADEFUN.                   
000072            MOVE WK-EMAILFUN-ACCEPT   TO DB2-EMAILFUN-TEXT.              
000073            PERFORM 206-CONTA-EMAILFUN.                                  
000074            EXEC SQL                                                     
000075                INSERT INTO EAD719.FUNCIONARIOS                          
000076                VALUES(:DB2-CODFUN,                                      
000077                       :DB2-NOMEFUN,                                     
000078                       :DB2-SALARIOFUN,                                  
000079                       :DB2-DEPTOFUN,                                    
000080                       :DB2-ADMISSFUN,                                   
000081                       :DB2-IDADEFUN,                                   
000082                       :DB2-EMAILFUN)                                   
000083            END-EXEC.                                                   
000084            EVALUATE SQLCODE                                            
000085                WHEN 0                                                  
000086                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000087                            ' FOI INCLUIDO!'                            
000088                WHEN -803                                               
000089                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000090                            ' JA EXISTE!'                               
000091                WHEN -530                                               
000092                    DISPLAY 'DEPARTAMENTO ' DB2-DEPTOFUN                
000093                            ' NAO EXISTE!'                              
000094                WHEN OTHER                                              
000095                    MOVE SQLCODE TO WK-SQLCODE-EDIT                     
000096                    DISPLAY 'ERRO ' WK-SQLCODE-EDIT                     
000097                            ' NO COMANDO INSERT'                        
000098                    MOVE 12 TO RETURN-CODE                              
000099                    STOP RUN                                            
000100            END-EVALUATE.                                               
000101       *                                                                
000102        203-EXCLUSAO.                                                   
000103            MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.                    
000104            EXEC SQL                                                    
000105                DELETE FROM EAD719.FUNCIONARIOS                         
000106                    WHERE CODFUN = :DB2-CODFUN                          
000107            END-EXEC.                                                   
000108            EVALUATE SQLCODE                                            
000109                WHEN 0                                                  
000110                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000111                            ' FOI EXCLUIDO!'                            
000112                WHEN 100                                                
000113                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000114                            ' NAO EXISTE!'                              
000115                WHEN OTHER                                              
000116                    MOVE SQLCODE TO WK-SQLCODE-EDIT                     
000117                    DISPLAY 'ERRO ' WK-SQLCODE-EDIT                     
000118                            ' NO COMANDO DELETE'                        
000119                    MOVE 12 TO RETURN-CODE                              
000120                    STOP RUN                                            
000121            END-EVALUATE.                                               
000122       *                                                                
000123        204-ALTERACAO.                                                  
000124            MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.                    
000125            IF   WK-NOMEFUN-ACCEPT    NOT = SPACES                      
000126                PERFORM 210-ALTERA-NOME                                 
000127            END-IF.                                                     
000128            IF   WK-SALARIOFUN-ACCEPT IS NUMERIC                        
000129                PERFORM 211-ALTERA-SALARIO                              
000130            END-IF.                                                     
000131            IF   WK-DEPTOFUN-ACCEPT   NOT = SPACES                      
000132                PERFORM 212-ALTERA-DEPARTAMENTO                         
000133            END-IF.                                                     
000134            IF   WK-ADMISSFUN-ACCEPT  NOT = SPACES                      
000135                PERFORM 213-ALTERA-ADMISSAO                             
000136            END-IF.                                                     
000137            IF   WK-IDADEFUN-ACCEPT   IS NUMERIC                        
000138                PERFORM 214-ALTERA-IDADE                                
000139            END-IF.                                                     
000140            IF   WK-EMAILFUN-ACCEPT   NOT = SPACES                      
000141                PERFORM 215-ALTERA-EMAIL                                 
000142            END-IF.                                                      
000143       *                                                                 
000144        205-CONTA-NOMEFUN.                                               
000145            MOVE 30 TO DB2-NOMEFUN-LEN.                                  
000146            PERFORM VARYING WK-POSICAO FROM 30 BY -1                     
000147                    UNTIL DB2-NOMEFUN-TEXT(WK-POSICAO:1) NOT EQUAL SPACES
000148                SUBTRACT 1 FROM DB2-NOMEFUN-LEN                          
000149            END-PERFORM.                                                 
000150       *                                                                 
000151        206-CONTA-EMAILFUN.                                              
000152            MOVE 30 TO DB2-EMAILFUN-LEN.                                 
000153            PERFORM VARYING WK-POSICAO FROM 30 BY -1                     
000154                   UNTIL DB2-EMAILFUN-TEXT(WK-POSICAO:1) NOT EQUAL SPACES
000155                SUBTRACT 1 FROM DB2-EMAILFUN-LEN                         
000156            END-PERFORM.                                                 
000157       *                                                                 
000158        210-ALTERA-NOME.                                                 
000159            MOVE WK-NOMEFUN-ACCEPT    TO DB2-NOMEFUN-TEXT.               
000160            PERFORM 205-CONTA-NOMEFUN.                                   
000161            EXEC SQL                                                     
000162                UPDATE EAD719.FUNCIONARIOS                               
000163                    SET NOMEFUN = :DB2-NOMEFUN                           
000164                    WHERE CODFUN = :DB2-CODFUN                           
000165            END-EXEC.                                                    
000166            EVALUATE SQLCODE                                             
000167                WHEN 0                                                   
000168                    DISPLAY 'NOME DO FUNCIONARIO ' DB2-CODFUN            
000169                            ' FOI ALTERADO PARA ' DB2-NOMEFUN-TEXT       
000170                WHEN 100                                                 
000171                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                    
000172                            ' NAO EXISTE!'                               
000173                WHEN OTHER                                               
000174                    MOVE SQLCODE TO WK-SQLCODE-EDIT                      
000175                    DISPLAY 'ERRO ' WK-SQLCODE-EDIT                      
000176                            ' NO COMANDO UPDATE'                         
000177                    MOVE 12 TO RETURN-CODE                               
000178                    STOP RUN                                             
000179            END-EVALUATE.                                                
000180       *                                                                 
000181        211-ALTERA-SALARIO.                                              
000182            MOVE WK-SALARIOFUN-ACCEPT    TO DB2-SALARIOFUN.              
000183            EXEC SQL                                                     
000184                UPDATE EAD719.FUNCIONARIOS                               
000185                    SET SALARIOFUN = :DB2-SALARIOFUN                     
000186                    WHERE CODFUN = :DB2-CODFUN                           
000187            END-EXEC.                                                    
000188            EVALUATE SQLCODE                                             
000189                WHEN 0                                                   
000190                    MOVE WK-SALARIOFUN-ACCEPT TO WK-SALARIO-EDIT         
000191                    DISPLAY 'SALARIO DO FUNCIONARIO ' DB2-CODFUN         
000192                            ' FOI ALTERADO PARA ' WK-SALARIO-EDIT        
000193                WHEN 100                                                 
000194                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                    
000195                            ' NAO EXISTE!'                               
000196                WHEN OTHER                                               
000197                    MOVE SQLCODE TO WK-SQLCODE-EDIT                      
000198                    DISPLAY 'ERRO ' WK-SQLCODE-EDIT                      
000199                            ' NO COMANDO UPDATE DO SALARIO'              
000200                    MOVE 12 TO RETURN-CODE                               
000201                    STOP RUN                                             
000202            END-EVALUATE.                                                
000203       *                                                                 
000204        212-ALTERA-DEPARTAMENTO.                                         
000205            MOVE WK-DEPTOFUN-ACCEPT TO DB2-DEPTOFUN.                     
000206            EXEC SQL                                                     
000207                UPDATE EAD719.FUNCIONARIOS                               
000208                    SET DEPTOFUN = :DB2-DEPTOFUN                         
000209                    WHERE CODFUN = :DB2-CODFUN                           
000210            END-EXEC.                                                    
000211            EVALUATE SQLCODE                                             
000212                WHEN 0                                                   
000213                    DISPLAY 'DEPARTAMENTO DO FUNCIONARIO ' DB2-CODFUN    
000214                            ' FOI ALTERADO PARA ' DB2-DEPTOFUN           
000215                WHEN 100                                                 
000216                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000217                            ' NAO EXISTE!'                              
000218                WHEN -530                                               
000219                    DISPLAY 'DEPARTAMENTO ' WK-DEPTOFUN-ACCEPT          
000220                            ' NAO EXISTE!'                              
000221                WHEN OTHER                                              
000222                    MOVE SQLCODE TO WK-SQLCODE-EDIT                     
000223                    DISPLAY 'ERRO ' WK-SQLCODE-EDIT                     
000224                            ' NO COMANDO UPDATE DO DEPARTAMENTO'        
000225                    MOVE 12 TO RETURN-CODE                              
000226                    STOP RUN                                            
000227            END-EVALUATE.                                               
000228       *                                                                
000229        213-ALTERA-ADMISSAO.                                            
000230            MOVE WK-ADMISSFUN-ACCEPT  TO DB2-ADMISSFUN.                 
000231            EXEC SQL                                                    
000232                UPDATE EAD719.FUNCIONARIOS                              
000233                    SET ADMISSFUN = :DB2-ADMISSFUN                      
000234                    WHERE CODFUN = :DB2-CODFUN                          
000235            END-EXEC.                                                   
000236            EVALUATE SQLCODE                                            
000237                WHEN 0                                                  
000238                    DISPLAY 'ADMISSAO DO FUNCIONARIO ' DB2-CODFUN       
000239                            ' FOI ALTERADO PARA ' DB2-DEPTOFUN          
000240                WHEN 100                                                
000241                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000242                            ' NAO EXISTE!'                              
000243                WHEN OTHER                                              
000244                    MOVE SQLCODE TO WK-SQLCODE-EDIT                     
000245                    DISPLAY 'ERRO ' WK-SQLCODE-EDIT                     
000246                            ' NO COMANDO UPDATE DA ADMISSAO'            
000247                    MOVE 12 TO RETURN-CODE                              
000248                    STOP RUN                                            
000249            END-EVALUATE.                                               
000250       *                                                                
000251        214-ALTERA-IDADE.                                               
000252            MOVE WK-IDADEFUN-ACCEPT  TO DB2-IDADEFUN.                   
000253            EXEC SQL                                                    
000254                UPDATE EAD719.FUNCIONARIOS                              
000255                    SET IDADEFUN = :DB2-IDADEFUN                        
000256                    WHERE CODFUN = :DB2-CODFUN                          
000257            END-EXEC.                                                   
000258            EVALUATE SQLCODE                                            
000259                WHEN 0                                                  
000260                    DISPLAY 'IDADE DO FUNCIONARIO ' DB2-CODFUN          
000261                            ' FOI ALTERADO PARA ' DB2-IDADEFUN           
000262                WHEN 100                                                 
000263                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                    
000264                            ' NAO EXISTE!'                               
000265                WHEN OTHER                                               
000266                    MOVE SQLCODE TO WK-SQLCODE-EDIT                      
000267                    DISPLAY 'ERRO ' WK-SQLCODE-EDIT                      
000268                            ' NO COMANDO UPDATE DA IDADE'                
000269                    MOVE 12 TO RETURN-CODE                               
000270                    STOP RUN                                             
000271            END-EVALUATE.                                                
000272       *                                                                 
000273        215-ALTERA-EMAIL.                                                
000274            MOVE WK-EMAILFUN-ACCEPT  TO DB2-EMAILFUN.                    
000275            EXEC SQL                                                     
000276                UPDATE EAD719.FUNCIONARIOS                              
000277                    SET EMAILFUN = :DB2-EMAILFUN                        
000278                    WHERE CODFUN = :DB2-CODFUN                          
000279            END-EXEC.                                                   
000280            EVALUATE SQLCODE                                            
000281                WHEN 0                                                  
000282                    DISPLAY 'EMAIL DO FUNCIONARIO ' DB2-CODFUN          
000283                            ' FOI ALTERADO PARA ' DB2-EMAILFUN          
000284                WHEN 100                                                
000285                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000286                            ' NAO EXISTE!'                              
000287                WHEN OTHER                                              
000288                    MOVE SQLCODE TO WK-SQLCODE-EDIT                     
000289                    DISPLAY 'ERRO ' WK-SQLCODE-EDIT                     
000290                            ' NO COMANDO UPDATE DA EMAIL'               
000291                    MOVE 12 TO RETURN-CODE                               
000292                    STOP RUN                                             
000293            END-EVALUATE.                                                
000294       *******************************************************           
000295        300-LER-FUNCIONARIOS SECTION.                                    
000296        301-LER-FUNCIONARIOS.                                            
000297            EXIT.                                                        
000298       *******************************************************           
000299        900-FINALIZAR SECTION.                                           
000300        901-FINALIZAR.                                                   
000301            EXIT.                                                        
