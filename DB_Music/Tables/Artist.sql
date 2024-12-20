CREATE TABLE [dbo].[Artist]
(
	[Id] INT IDENTITY NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(100) NOT NULL, 
    [CreationDate] DATE NOT NULL, 
    [RetirementDate] DATE  NULL, 
    [Country] NVARCHAR(56)NOT NULL,

    CONSTRAINT CK_RetirementDate CHECK ([RetirementDate] > [CreationDate])
)