USE [msdb]
GO

IF OBJECT_ID(N'dbo.fn_CreateTimeString','FN') IS NOT NULL 
   DROP FUNCTION dbo.fn_CreateTimeString
GO

/*-------------------------------------------------------------------------------------------------
        NAME: fn_CreateTimeString.sql
 MODIFIED BY: Sal Young
       EMAIL: saleyoun@yahoo.com
 DESCRIPTION: Returns a string representation of time.
   PARAMETER: @seconds
-------------------------------------------------------------------------------------------------
         DATE MODIFIED      DESCRIPTION   
-------------------------------------------------------------------------------------------------
   06.21.2012 SYoung        Initial creation.
-------------------------------------------------------------------------------------------------
  DISCLAIMER: The AUTHOR  ASSUMES NO RESPONSIBILITY  FOR ANYTHING, including  the destruction of 
              personal property, creating singularities, making deep fried chicken, causing your 
              toilet to  explode, making  your animals spin  around like mad, causing hair loss, 
              killing your buzz or ANYTHING else that can be thought up.
-------------------------------------------------------------------------------------------------*/
CREATE FUNCTION [dbo].[fn_CreateTimeString] (@seconds INT)
RETURNS VARCHAR(50)

AS

BEGIN
	DECLARE @h INT
		,@m INT
		,@s INT
		,@secs INT
		,@BuildDate VARCHAR(50)

	SELECT @secs = @seconds
	SELECT @h = @secs / 3600
	SELECT @secs = @secs - (@h * 3600)
	SELECT @m = @secs / 60
	SELECT @secs = @secs - (@m * 60)
	SELECT @s = @secs

	IF @h = 0
	BEGIN
		IF @m = 0
		BEGIN
			SELECT @BuildDate = CASE @s
					WHEN 1
						THEN CAST(@s AS VARCHAR) + ' second'
					ELSE CAST(@s AS VARCHAR) + ' seconds'
					END
		END
		ELSE
		BEGIN
			SELECT @BuildDate = CASE @m
					WHEN 1
						THEN CAST(@m AS VARCHAR) + ' minute with '
					ELSE CAST(@m AS VARCHAR) + ' minutes with '
					END + CASE @s
					WHEN 1
						THEN CAST(@s AS VARCHAR) + ' second'
					ELSE CAST(@s AS VARCHAR) + ' seconds'
					END
		END
	END
	ELSE
	BEGIN
		SELECT @BuildDate = CASE @h
				WHEN 1
					THEN CAST(@h AS VARCHAR) + ' hour '
				ELSE CAST(@h AS VARCHAR) + ' hours '
				END + CASE @m
				WHEN 1
					THEN CAST(@m AS VARCHAR) + ' minute with '
				ELSE CAST(@m AS VARCHAR) + ' minutes with '
				END + CASE @s
				WHEN 1
					THEN CAST(@s AS VARCHAR) + ' second'
				ELSE CAST(@s AS VARCHAR) + ' seconds'
				END
	END

	RETURN CONVERT(VARCHAR(50), @BuildDate)
END
GO
