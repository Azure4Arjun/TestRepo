/*-------------------------------------------------------------------------------------------------
        NAME: sp_who2_Filtered.sql
 MODIFIED BY: Sal Young
       EMAIL: saleyoun@yahoo.com
 DESCRIPTION: Displays the result from executing sp_who2. The result is stored in a table 
              variable which can be then queried.
-------------------------------------------------------------------------------------------------
         DATE MODIFIED      DESCRIPTION   
-------------------------------------------------------------------------------------------------
   02.12.2012 SYoung        Initial creation.
-------------------------------------------------------------------------------------------------
  DISCLAIMER: The AUTHOR  ASSUMES NO RESPONSIBILITY  FOR ANYTHING, including  the destruction of 
              personal property, creating singularities, making deep fried chicken, causing your 
              toilet to  explode, making  your animals spin  around like mad, causing hair loss, 
              killing your buzz or ANYTHING else that can be thought up.
-------------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

DECLARE @Login SYSNAME 
SET @Login = ''

DECLARE @Who2 TABLE (
        SPID INT,  
        [Status] VARCHAR(1000) NULL,  
        [Login] SYSNAME NULL,  
        HostName SYSNAME NULL,  
        BlkBy SYSNAME NULL,  
        DBName SYSNAME NULL,  
        Command VARCHAR(1000) NULL,  
        CPUTime INT NULL,  
        DiskIO INT NULL,  
        LastBatch VARCHAR(1000) NULL,  
        ProgramName VARCHAR(1000) NULL,  
        SPID2 INT,
        REQUESTID INT) 

INSERT INTO @Who2
  EXEC sp_who2 active;

SELECT SPID
     , HostName
     , [Login]
     , BlkBy
     , DBName
     , Command
     , CPUTime
     , DiskIO
     , LastBatch
     , ProgramName
  FROM @Who2
 WHERE Login = @Login;
GO
