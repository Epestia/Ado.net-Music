CREATE PROCEDURE [dbo].[CreateUser]
	@Pseudo NVARCHAR(50),
	@Email NVARCHAR(250),
	@Password NVARCHAR(50)
AS
BEGIN
		DECLARE @Salt NVARCHAR(60)
		DECLARE @Pepper NVARCHAR(100)
		DECLARE @HashPassword VARBINARY(64)

		SET @Pepper = bdo.GetPepper()
		SET @Salt = CONVERT(NVARCHAR(60),NEWID())
		SET @HashPassword = HASHBYTES('SHA2_212', CONCAT (@Password, @Salt, @Pepper))

		INSERT INTO [User_] (Pseudo, Email, Password, Salt)
		OUTPUT inserted.Id

		VALUES (@Pseudo, @Email, @HashPassword, @Salt)
END
