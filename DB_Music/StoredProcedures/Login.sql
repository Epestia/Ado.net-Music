CREATE PROCEDURE [dbo].[Login]
	@Pseudo NVARCHAR(50), 
	@Password NVARCHAR(50)
	AS
		BEGIN 
			IF EXISTS(SELECT*FROM dbo.[User_] WHERE Pseudo = @Pseudo)
			BEGIN
				DECLARE @Pepper NVARCHAR(100)
				SET @Pepper = dbo.GetPepper()

				SELECT Pseudo, Email FROM dbo.[User_]
				WHERE Pseudo = @Pseudo AND Password = HASHBYTES ('SHA2_512', CONCAT(@Password, Salt, @Pepper))
			END
		END
