000001        IDENTIFICATION DIVISION.                                         
000002        PROGRAM-ID.    EAD71916.                                         
000003        AUTHOR.        THIAGO.                                           
000004       **************************************                            
000005       *    LER E EXIBIR 1 FUNCIONARIO (DB2)*                            
000006       **************************************                            
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
000024        77  WK-SALARIO-EDIT        PIC ZZZ.ZZ9,99 VALUE ZEROS.           
000025        77  WK-SQLCODE-EDIT        PIC -999       VALUE ZEROS.           
000026        77  WK-ACCEPT-CODFUN       PIC X(04)      VALUE SPACES.          
000027       *                                                                 
000028        PROCEDURE DIVISION.                                              
000029        000-PRINCIPAL SECTION.                                           
000030        001-PRINCIPAL.                                                   
000031            PERFORM 101-INICIAR.                                         
000032            IF SQLCODE = 0                                               
000033                PERFORM 201-PROCESSAR                                    
000034            END-IF.                                                      
000035            PERFORM 901-FINALIZAR.                                       
000036            STOP RUN.                                                    
000037       *******************************************************                   
000038        100-INICIAR SECTION.                                             
000039        101-INICIAR.                                                     
000040            ACCEPT WK-ACCEPT-CODFUN.                                     
000041            PERFORM 301-LER-FUNCIONARIOS.                                
000042       *******************************************************           
000043        200-PROCESSAR SECTION.                                           
000044        201-PROCESSAR.                                                   
000045            DISPLAY 'CODIGO      : ' DB2-CODFUN.                         
000046            DISPLAY 'NOME        : ' DB2-NOMEFUN-TEXT.                   
000047            MOVE DB2-SALARIOFUN TO WK-SALARIO-EDIT.                      
000048            DISPLAY 'SALARIO     : ' WK-SALARIO-EDIT.                    
000049            DISPLAY 'DEPARTAMENTO: ' DB2-DEPTOFUN.                       
000050            DISPLAY 'ADMISSSAO   : ' DB2-ADMISSAOFUN.                    
000051            DISPLAY 'IDADE       : ' DB2-IDADEFUN.                       
000052            DISPLAY 'EMAIL       : ' DB2-EMAILFUN-TEXT.                  
000053       *******************************************************           
000054        300-LER-FUNCIONARIOS SECTION.                                    
000055        301-LER-FUNCIONARIOS.                                           
000056            MOVE WK-ACCEPT-CODFUN TO DB2-CODFUN                         
000057            EXEC SQL                                                    
000058                SELECT *                                                
000059                    INTO :REG-FUNCIONARIOS                              
000060                    FROM EAD719.FUNCIONARIOS                            
000061                    WHERE CODFUN = :DB2-CODFUN                          
000062            END-EXEC.                                                   
000063            EVALUATE SQLCODE                                            
000064                WHEN 0                                                  
000065                    CONTINUE                                            
000066                WHEN 100                                                
000067                    DISPLAY 'FUNCIONARIO ' DB2-CODFUN                   
000068                            ' NAO EXISTE'                               
000069                WHEN OTHER                                              
000070                    MOVE SQLCODE TO WK-SQLCODE-EDIT                                         
000071                    DISPLAY 'ERRO: ' WK-SQLCODE-EDIT                    
000072                            ' NO COMANDO SELECT'                        
000073                    MOVE 12 TO RETURN-CODE                              
000074                    STOP RUN                                            
000075            END-EVALUATE.                                               
000076       *******************************************************          
000077        900-FINALIZAR SECTION.                                          
000078        901-FINALIZAR.                                                  
000079            EXIT.                                                       
