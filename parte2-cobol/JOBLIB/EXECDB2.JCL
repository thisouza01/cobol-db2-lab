 000001 //EAD719XX JOB 'COMPDB2',MSGCLASS=X,CLASS=C,NOTIFY=&SYSUID              
 000002 //*-------------------------------------------------------------------* 
 000003 //*      JOB DE EXECUCAO   DE PROGRAMA COBOL COM DB2 BATCH            * 
 000004 //*-------------------------------------------------------------------* 
 000005 //EXECDB   EXEC PGM=IKJEFT01,DYNAMNBR=20                                
 000006 //STEPLIB  DD   DSN=DSN810.SDSNLOAD,DISP=SHR                            
 000007 //DBRMLIB  DD   DSN=DSN810.DBRMLIB.DATA,DISP=SHR                        
 000008 //SYSTSPRT DD   SYSOUT=*                                                
 000009 //SYSPRINT DD   SYSOUT=*                                                
 000010 //*YSOUT   DD   SYSOUT=*                                                
 000011 //SYSTSIN  DD   *                                                       
 000012   DSN  SYSTEM(DB8G)                                                     
 000013   RUN PROGRAM(EAD71916) PLAN(EAD71916) -                                
 000014        LIB('GR.GERAL.LOADLIB')                                          
 000015   END                                                                   
 000016 //*************************************************                     
