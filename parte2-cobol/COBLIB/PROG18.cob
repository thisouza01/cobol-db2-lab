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
000035            05 WK-EMAILFUN-ACCEPT     PIC X(30)       VALUE SPACES.     
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
000049       *******************************************************          
000050        200-PROCESSAR SECTION.                                          
000051        201-PROCESSAR.                                                  
000052            EVALUATE WK-FUNCAO-ACCEPT                                   
000053                WHEN 'I'                                                
000054                    PERFORM 202-INCLUSAO                                
000055                WHEN 'E'                                                
000056                    PERFORM 203-EXCLUSAO                                
000057                WHEN 'A'                                                
000058                    PERFORM 204-ALTERACAO                               
000059                WHEN OTHER                                              
000060                    DISPLAY 'FUNCAO ' WK-FUNCAO-ACCEPT ' INVALIDA!'     
000061            END-EVALUATE.                                               
000062       *                                                                
000063        202-INCLUSAO.                                                   
000064            MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.                    
000065            MOVE WK-NOMEFUN-ACCEPT    TO DB2-NOMEFUN-TEXT.              
000066            PERFORM 205-CONTA-NOMEFUN.                                  
000067            MOVE WK-SALARIOFUN-ACCEPT TO DB2-SALARIOFUN.                
000068            MOVE WK-DEPTOFUN-ACCEPT   TO DB2-DEPTOFUN.                  
000069            MOVE WK-ADMISSFUN-ACCEPT  TO DB2-ADMISSFUN.                 
000070            MOVE WK-IDADEFUN-ACCEPT   TO DB2-IDADEFUN.                  
000071            MOVE WK-EMAILFUN-ACCEPT   TO DB2-EMAILFUN-TEXT.             
000072            PERFORM 206-CONTA-EMAILFUN.                                 
000073            EXEC SQL                                                    
000074                INSERT INTO EAD719.FUNCIONARIOS                         
000075                VALUES(:DB2-CODFUN,                                     
000076                       :DB2-NOMEFUN,                                    
000077                       :DB2-SALARIOFUN,                                 
000078                       :DB2-DEPTOFUN,                                   
000079                       :DB2-ADMISSFUN,                                  
000080                       :DB2-IDADEFUN,                                   
000081                       :DB2-EMAILFUN)                                   
000082            END-EXEC.                                                   
000083            EVALUATE SQLCODE                                            
000084                WHEN 0                                                  
000085                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000086                            ' FOI INCLUIDO!'                            
000087                WHEN -803                                               
000088                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000089                            ' JA EXISTE!'                               
000090                WHEN -530                                               
000091                    DISPLAY 'DEPARTAMENTO ' DB2-DEPTOFUN                
000092                            ' NAO EXISTE!'                              
000093                WHEN OTHER                                              
000094                    MOVE SQLCODE TO WK-SQLCODE-EDIT                     
000095                    DISPLAY 'ERRO ' WK-SQLCODE-EDIT                     
000096                            ' NO COMANDO INSERT'                        
000097                    MOVE 12 TO RETURN-CODE                               
000098                    STOP RUN                                             
000099            END-EVALUATE.                                                
000100       *                                                                 
000101        203-EXCLUSAO.                                                    
000102            EXIT.                                                        
000103       *                                                                 
000104        204-ALTERACAO.                                                   
000105            EXIT.                                                        
000106       *                                                                 
000107        205-CONTA-NOMEFUN.                                               
000108            MOVE 30 TO DB2-NOMEFUN-LEN.                                  
000109            PERFORM VARYING WK-POSICAO FROM 30 BY -1                     
000110                    UNTIL DB2-NOMEFUN-TEXT(WK-POSICAO:1) NOT EQUAL SPACES
000111                SUBTRACT 1 FROM DB2-NOMEFUN-LEN                          
000112            END-PERFORM.                                                 
000113       *                                                                 
000114        206-CONTA-EMAILFUN.                                              
000115            MOVE 30 TO DB2-EMAILFUN-LEN.                                 
000116            PERFORM VARYING WK-POSICAO FROM 30 BY -1                     
000117                   UNTIL DB2-EMAILFUN-TEXT(WK-POSICAO:1) NOT EQUAL SPACES
000118                SUBTRACT 1 FROM DB2-EMAILFUN-LEN                         
000119            END-PERFORM.                                                 
000120       *******************************************************           
000121        300-LER-FUNCIONARIOS SECTION.                                    
000122        301-LER-FUNCIONARIOS.                                            
000123            EXIT.                                                        
000124       *******************************************************           
000125        900-FINALIZAR SECTION.                                           
000126        901-FINALIZAR.                                                   
000127            EXIT.                                                        
