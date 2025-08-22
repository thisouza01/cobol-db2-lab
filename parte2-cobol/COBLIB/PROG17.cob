000001        IDENTIFICATION DIVISION.                                        
000002        PROGRAM-ID.    EAD71917.                                        
000003        AUTHOR.        THIAGO.                                          
000004       ********************************************                     
000005       *    LER E EXIBIR TODOS FUNCIONARIOS (DB2) *                     
000006       ********************************************                     
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
000024            EXEC SQL                                                    
000025                DECLARE FUNCTEMP CURSOR FOR                             
000026                    SELECT * FROM EAD719.FUNCIONARIOS                   
000027                    ORDER BY CODFUN                                     
000028            END-EXEC.                                                   
000029        77  WK-SALARIO-EDIT        PIC ZZZ.ZZ9,99 VALUE ZEROS.          
000030        77  WK-SQLCODE-EDIT        PIC -999       VALUE ZEROS.          
000031        77  WK-ACCEPT-CODFUN       PIC X(04)      VALUE SPACES.         
000032       *                                                                
000033        PROCEDURE DIVISION.                                             
000034        000-PRINCIPAL SECTION.                                          
000035        001-PRINCIPAL.                                                  
000036            PERFORM 101-INICIAR.                                        
000037            PERFORM 201-PROCESSAR UNTIL SQLCODE = 100.                  
000038            PERFORM 901-FINALIZAR.                                      
000039            STOP RUN.                                                   
000040       *******************************************************          
000041        100-INICIAR SECTION.                                            
000042        101-INICIAR.                                                    
000043            EXEC SQL                                                    
000044                OPEN FUNCTEMP                                           
000045            END-EXEC.                                                   
000046            EVALUATE SQLCODE                                            
000047                WHEN 0                                                  
000048                    PERFORM 301-LER-FUNCIONARIOS                        
000049                WHEN 100                                                
000050                    DISPLAY 'FIM DA TABELA'                             
000051                WHEN OTHER                                               
000052                    MOVE SQLCODE TO WK-SQLCODE-EDIT                      
000053                    DISPLAY 'ERRO: ' WK-SQLCODE-EDIT                     
000054                            ' NO COMANDO OPEN CURSOR'                    
000055                    MOVE 12 TO RETURN-CODE                               
000056                    STOP RUN                                             
000057            END-EVALUATE.                                                
000058       *******************************************************           
000059        200-PROCESSAR SECTION.                                           
000060        201-PROCESSAR.                                                   
000061            DISPLAY 'CODIGO      : ' DB2-CODFUN.                         
000062            DISPLAY 'NOME        : ' DB2-NOMEFUN-TEXT.                   
000063            MOVE DB2-SALARIOFUN TO WK-SALARIO-EDIT.                      
000064            DISPLAY 'SALARIO     : ' WK-SALARIO-EDIT.                    
000065            DISPLAY 'DEPARTAMENTO: ' DB2-DEPTOFUN.                       
000066            DISPLAY 'ADMISSSAO   : ' DB2-ADMISSFUN.                      
000067            DISPLAY 'IDADE       : ' DB2-IDADEFUN.                       
000068            DISPLAY 'EMAIL       : ' DB2-EMAILFUN-TEXT.                 
000069            DISPLAY '****************************************'.         
000070            PERFORM 301-LER-FUNCIONARIOS.                               
000071       *******************************************************          
000072        300-LER-FUNCIONARIOS SECTION.                                   
000073        301-LER-FUNCIONARIOS.                                           
000074            MOVE SPACES TO DB2-NOMEFUN-TEXT.                            
000075            MOVE SPACES TO DB2-EMAILFUN-TEXT.                           
000076            EXEC SQL                                                    
000077                FETCH FUNCTEMP                                          
000078                    INTO :REG-FUNCIONARIOS                              
000079            END-EXEC.                                                   
000080            EVALUATE SQLCODE                                            
000081                WHEN 0                                                  
000082                    CONTINUE                                            
000083                WHEN 100                                                
000084                    DISPLAY 'FIM DA TABELA'                             
000085                WHEN OTHER                                               
000086                    MOVE SQLCODE TO WK-SQLCODE-EDIT                      
000087                    DISPLAY 'ERRO: ' WK-SQLCODE-EDIT                     
000088                            ' NO COMANDO FETCH'                          
000089                    MOVE 12 TO RETURN-CODE                               
000090                    STOP RUN                                             
000091            END-EVALUATE.                                                
000092       *******************************************************           
000093        900-FINALIZAR SECTION.                                           
000094        901-FINALIZAR.                                                   
000095            EXEC SQL                                                     
000096                CLOSE FUNCTEMP                                           
000097            END-EXEC.                                                    
