000001 //EAD71916 JOB 'COMPDB2',MSGCLASS=X,CLASS=C,NOTIFY=&SYSUID              
000002 //*-------------------------------------------------------------------* 
000003 //*      JOB DE COMPILACAO DE PROGRAMA COBOL COM DB2 BATCH            * 
000005 //*-------------------------------------------------------------------* 
000006 //         JCLLIB ORDER=GR.GERAL.PROCLIB                                
000007 //COMPDB2B EXEC DFHCODB2,NAME=EAD71916,INSTR=EAD719                     
000008 //LKED.SYSIN    DD   *                                                  
000009   NAME EAD71916(R)                                                      
000010 //*                                                                     
000011 //BIND.SYSTSIN  DD *                                                    
000012 DSN  SYSTEM(DB8G)                                                       
000013 BIND PLAN(EAD71916) MEM(EAD71916) ACT(REP) ISOLATION(CS) -              
000014        LIB('DSN810.DBRMLIB.DATA')                                       
000015 END                                                                     
000016 //*                                                                     