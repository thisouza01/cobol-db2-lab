000001       ******************************************************************
000002       * DCLGEN TABLE(EAD719.FUNCIONARIOS)                              *
000003       *        LIBRARY(GR.EAD719.BOOKLIB(BOOKFUNC))                    *
000004       *        ACTION(REPLACE)                                         *
000005       *        LANGUAGE(COBOL)                                         *
000006       *        NAMES(DB2-)                                             *
000007       *        STRUCTURE(REG-FUNCIONARIOS)                             *
000008       *        QUOTE                                                   *
000009       *        DBCSDELIM(NO)                                           *
000010       *        COLSUFFIX(YES)                                          *
000011       * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
000012       ******************************************************************
000013            EXEC SQL DECLARE EAD719.FUNCIONARIOS TABLE                   
000014            ( CODFUN                         CHAR(4) NOT NULL,           
000015              NOMEFUN                        VARCHAR(30) NOT NULL,       
000016              SALARIOFUN                     DECIMAL(8, 2) NOT NULL,     
000017              DEPTOFUN                       CHAR(3) NOT NULL,           
000018              ADMISSFUN                      DATE NOT NULL,              
000019              IDADEFUN                       SMALLINT NOT NULL,          
000020              EMAILFUN                       VARCHAR(30)                 
000021            ) END-EXEC.                                                  
000022       ******************************************************************
000023       * COBOL DECLARATION FOR TABLE EAD719.FUNCIONARIOS                *
000024       ******************************************************************
000025        01  REG-FUNCIONARIOS.                                            
000026       *                       CODFUN                                    
000027            10 DB2-CODFUN           PIC X(4).                            
000028            10 DB2-NOMEFUN.                                              
000029       *                       NOMEFUN LENGTH                            
000030               49 DB2-NOMEFUN-LEN   PIC S9(4) USAGE COMP.                
000031       *                       NOMEFUN                                   
000032               49 DB2-NOMEFUN-TEXT                                       
000033                  PIC X(30).                                             
000034       *                       SALARIOFUN                                
000035            10 DB2-SALARIOFUN       PIC S9(6)V9(2) USAGE COMP-3.         
000036       *                       DEPTOFUN                                  
000037            10 DB2-DEPTOFUN         PIC X(3).                            
000038       *                       ADMISSFUN                                 
000039            10 DB2-ADMISSFUN        PIC X(10).                           
000040       *                       IDADEFUN                                  
000041            10 DB2-IDADEFUN         PIC S9(4) USAGE COMP.                
000042            10 DB2-EMAILFUN.                                             
000043       *                       EMAILFUN LENGTH                           
000044               49 DB2-EMAILFUN-LEN                                       
000045                  PIC S9(4) USAGE COMP.                                  
000046       *                       EMAILFUN                                  
000047               49 DB2-EMAILFUN-TEXT                                      
000048                  PIC X(30).                                             
000049       ******************************************************************
000050       * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 7       *
000051       ******************************************************************