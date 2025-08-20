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
000024        77  WK-SALARIO-EDIT        PIC ZZZ.ZZ9,99 VALUE ZEROS.          
000025       *                                                                
000026        PROCEDURE DIVISION.                                             
000027        000-PRINCIPAL SECTION.                                          
000028        001-PRINCIPAL.                                                  
000029            PERFORM 101-INICIAR.                                        
000030            PERFORM 201-PROCESSAR UNTIL WK-FS-CLIENTES = '10'.          
000031            PERFORM 901-FINALIZAR.                                      
000032            STOP RUN.                                                   
000033       *******************************************************          
000034        100-INICIAR SECTION.                                            
000035        101-INICIAR.                                                    
000036            OPEN INPUT ARQ-CLIENTES.                                    
000037            EVALUATE WK-FS-CLIENTES                                     
000038                WHEN '00'                                               
000039                    PERFORM 301-LER-CLIENTES                            
000040                WHEN '35'                                               
000041                    DISPLAY 'ARQUIVO CLIENTES NAO ENCONTRADO'           
000042                    MOVE 12 TO RETURN-CODE                              
000043                    STOP RUN                                            
000044                WHEN OTHER                                              
000045                    DISPLAY 'ERRO: ' WK-FS-CLIENTES                     
000046                            ' O COMANDO OPEN CLIENTES'                  
000047                    MOVE 12 TO RETURN-CODE                              
000048                    STOP RUN                                            
000049            END-EVALUATE.                                               
000050       *******************************************************          
000051        200-PROCESSAR SECTION.                                          
000052        201-PROCESSAR.                                                   
000053            DISPLAY 'AGENCIA: ' FD-AGENCIA-CLIENTES.                     
000054            DISPLAY 'CONTA  : ' FD-CONTA-CLIENTES.                       
000055            DISPLAY 'NOME   : ' FD-NOME-CLIENTES.                        
000056            MOVE    FD-SALDO-CLIENTES TO WK-SALDO-EDIT.                  
000057            DISPLAY 'SALDO  : ' WK-SALDO-EDIT.                           
000058            DISPLAY ' '.                                                 
000059            PERFORM 301-LER-CLIENTES.                                    
000060       *******************************************************           
000061        300-LER-CLIENTES SECTION.                                        
000062        301-LER-CLIENTES.                                                
000063            READ ARQ-CLIENTES.                                           
000064            EVALUATE WK-FS-CLIENTES                                      
000065                WHEN '00'                                                
000066                    CONTINUE                                             
000067                WHEN '10'                                                
000068                    DISPLAY 'FIM DO ARQUIVO'                             
000069                WHEN OTHER                                               
000070                    DISPLAY 'ERRO: ' WK-FS-CLIENTES                      
000071                            ' O COMANDO READ CLIENTES'                   
000072                    MOVE 12 TO RETURN-CODE                               
000073                    STOP RUN                                             
000074            END-EVALUATE.                                                
000075       *******************************************************           
000076        900-FINALIZAR SECTION.                                           
000077        901-FINALIZAR.                                                   
000078            CLOSE ARQ-CLIENTES.                                          
000079                                                                         