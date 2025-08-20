000001       ******************************************************************
000002       * DCLGEN TABLE(EAD719.DEPARTAMENTOS)                             *
000003       *        LIBRARY(GR.EAD719.BOOKLIB(BOOKDEPT))                    *
000004       *        ACTION(REPLACE)                                         *
000005       *        LANGUAGE(COBOL)                                         *
000006       *        NAMES(DB2-)                                             *
000007       *        STRUCTURE(REG-DEPARTAMENTOS)                            *
000008       *        QUOTE                                                   *
000009       *        DBCSDELIM(NO)                                           *
000010       *        COLSUFFIX(YES)                                          *
000011       * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
000012       ******************************************************************
000013            EXEC SQL DECLARE EAD719.DEPARTAMENTOS TABLE                  
000014            ( CODDEPTO                       CHAR(3) NOT NULL,           
000015              NOMEDEPTO                      VARCHAR(30) NOT NULL        
000016            ) END-EXEC.                                                  
000017       ******************************************************************
000018       * COBOL DECLARATION FOR TABLE EAD719.DEPARTAMENTOS               *
000019       ******************************************************************
000020        01  REG-DEPARTAMENTOS.                                           
000021       *                       CODDEPTO                                  
000022            10 DB2-CODDEPTO         PIC X(3).                            
000023            10 DB2-NOMEDEPTO.                                            
000024       *                       NOMEDEPTO LENGTH                          
000025               49 DB2-NOMEDEPTO-LEN                                      
000026                  PIC S9(4) USAGE COMP.                                  
000027       *                       NOMEDEPTO                                 
000028               49 DB2-NOMEDEPTO-TEXT                                     
000029                  PIC X(30).                                             
000030       ******************************************************************
000031       * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 2       *
000032       ******************************************************************