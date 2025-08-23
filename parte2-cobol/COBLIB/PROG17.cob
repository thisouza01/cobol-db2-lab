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
000029        77  WK-INDICATOR-EMAIL     PIC S9(04) COMP VALUE ZEROS.          
000030        77  WK-SALARIO-EDIT        PIC ZZZ.ZZ9,99  VALUE ZEROS.          
000031        77  WK-SQLCODE-EDIT        PIC -999        VALUE ZEROS.          
000032        77  WK-ACCEPT-CODFUN       PIC X(04)       VALUE SPACES.         
000033       *                                                                 
000034        PROCEDURE DIVISION.                                              
000035        000-PRINCIPAL SECTION.                                           
000036        001-PRINCIPAL.                                                   
000037            PERFORM 101-INICIAR.                                         
000038            PERFORM 201-PROCESSAR UNTIL SQLCODE = 100.                   
000039            PERFORM 901-FINALIZAR.                                       
000040            STOP RUN.                                                    
000041       *******************************************************           
000042        100-INICIAR SECTION.                                             
000043        101-INICIAR.                                                     
000044            EXEC SQL                                                     
000045                OPEN FUNCTEMP                                            
000046            END-EXEC.                                                         
000047            EVALUATE SQLCODE                                            
000048                WHEN 0                                                  
000049                    PERFORM 301-LER-FUNCIONARIOS                        
000050                WHEN 100                                                
000051                    DISPLAY 'FIM DA TABELA'                             
000052                WHEN OTHER                                              
000053                    MOVE SQLCODE TO WK-SQLCODE-EDIT                     
000054                    DISPLAY 'ERRO: ' WK-SQLCODE-EDIT                    
000055                            ' NO COMANDO OPEN CURSOR'                   
000056                    MOVE 12 TO RETURN-CODE                              
000057                    STOP RUN                                            
000058            END-EVALUATE.                                               
000059       *******************************************************          
000060        200-PROCESSAR SECTION.                                          
000061        201-PROCESSAR.                                                  
000062            DISPLAY 'CODIGO      : ' DB2-CODFUN.                        
000063            DISPLAY 'NOME        : ' DB2-NOMEFUN-TEXT.                  
000064            MOVE DB2-SALARIOFUN TO WK-SALARIO-EDIT.                     
000065            DISPLAY 'SALARIO     : ' WK-SALARIO-EDIT.                   
000066            DISPLAY 'DEPARTAMENTO: ' DB2-DEPTOFUN.                      
000067            DISPLAY 'ADMISSSAO   : ' DB2-ADMISSFUN.                     
000068            DISPLAY 'IDADE       : ' DB2-IDADEFUN.                      
000069            DISPLAY 'EMAIL       : ' DB2-EMAILFUN-TEXT.                 
000070            DISPLAY '****************************************'.         
000071            PERFORM 301-LER-FUNCIONARIOS.                               
000072       *******************************************************          
000073        300-LER-FUNCIONARIOS SECTION.                                   
000074        301-LER-FUNCIONARIOS.                                           
000075            MOVE SPACES TO DB2-NOMEFUN-TEXT.                            
000076            MOVE SPACES TO DB2-EMAILFUN-TEXT.                           
000077            EXEC SQL                                                    
000078                FETCH FUNCTEMP                                          
000079                  INTO :DB2-CODFUN,                                   
000080                       :DB2-NOMEFUN,                                  
000081                       :DB2-SALARIOFUN,                               
000082                       :DB2-DEPTOFUN,                                 
000083                       :DB2-ADMISSFUN,                                
000084                       :DB2-IDADEFUN,                                 
000085                       :DB2-EMAILFUN INDICATOR :WK-INDICATOR-EMAIL    
000086            END-EXEC.                                                   
000087            IF WK-INDICATOR-EMAIL = -1                                  
000088                MOVE '-------------------' TO DB2-EMAILFUN              
000089            END-IF.                                                     
000090            EVALUATE SQLCODE                                            
000091                WHEN 0                                                  
000092                    CONTINUE                                            
000093                WHEN 100                                                
000094                    DISPLAY 'FIM DA TABELA'                             
000095                WHEN OTHER                                              
000096                    MOVE SQLCODE TO WK-SQLCODE-EDIT                     
000097                    DISPLAY 'ERRO: ' WK-SQLCODE-EDIT  
000098                            ' NO COMANDO FETCH'                         
000099                    MOVE 12 TO RETURN-CODE                              
000100                    STOP RUN                                            
000101            END-EVALUATE.                                               
000102       *******************************************************          
000103        900-FINALIZAR SECTION.                                          
000104        901-FINALIZAR.                                                  
000105            EXEC SQL                                                    
000106                CLOSE FUNCTEMP                                          
000107            END-EXEC.                                                                     
