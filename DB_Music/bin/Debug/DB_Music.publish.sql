/*
Script de déploiement pour DB_Music

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DB_Music"
:setvar DefaultFilePrefix "DB_Music"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.TFTIC\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.TFTIC\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de la base de données $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de Table [dbo].[Artist]...';


GO
CREATE TABLE [dbo].[Artist] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (100) NOT NULL,
    [CreationDate]   DATE           NOT NULL,
    [RetirementDate] DATE           NULL,
    [Country]        NVARCHAR (56)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[ArtistMusic]...';


GO
CREATE TABLE [dbo].[ArtistMusic] (
    [Id]       INT IDENTITY (1, 1) NOT NULL,
    [MusicId]  INT NOT NULL,
    [ArtistID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Genre]...';


GO
CREATE TABLE [dbo].[Genre] (
    [Id]   INT            IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);


GO
PRINT N'Création de Table [dbo].[Music]...';


GO
CREATE TABLE [dbo].[Music] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Title]       NVARCHAR (250) NOT NULL,
    [RealiseDate] DATE           NULL,
    [Duration]    TIME (7)       NULL,
    [SpotifyLink] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_Tile_RealiseDate] UNIQUE NONCLUSTERED ([Title] ASC, [RealiseDate] ASC)
);


GO
PRINT N'Création de Table [dbo].[MusicGenre]...';


GO
CREATE TABLE [dbo].[MusicGenre] (
    [Id]      INT IDENTITY (1, 1) NOT NULL,
    [MusicId] INT NOT NULL,
    [GenreID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[User_]...';


GO
CREATE TABLE [dbo].[User_] (
    [Id]       INT            IDENTITY (1, 1) NOT NULL,
    [Pseudo]   NVARCHAR (50)  NOT NULL,
    [Email]    NVARCHAR (250) NOT NULL,
    [Password] VARBINARY (64) NOT NULL,
    [Salt]     VARCHAR (50)   NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UK_EMAIL] UNIQUE NONCLUSTERED ([Email] ASC),
    CONSTRAINT [UK_PSEUDO] UNIQUE NONCLUSTERED ([Pseudo] ASC)
);


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Genre]...';


GO
ALTER TABLE [dbo].[Genre]
    ADD DEFAULT ('Unknown') FOR [Name];


GO
PRINT N'Création de Clé étrangère [dbo].[FK_ARTIST_MUSIC_ID]...';


GO
ALTER TABLE [dbo].[ArtistMusic]
    ADD CONSTRAINT [FK_ARTIST_MUSIC_ID] FOREIGN KEY ([MusicId]) REFERENCES [dbo].[Music] ([Id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_MUSIC_ARTIST_ID]...';


GO
ALTER TABLE [dbo].[ArtistMusic]
    ADD CONSTRAINT [FK_MUSIC_ARTIST_ID] FOREIGN KEY ([ArtistID]) REFERENCES [dbo].[Artist] ([Id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_GENRE_MUSIC_ID]...';


GO
ALTER TABLE [dbo].[MusicGenre]
    ADD CONSTRAINT [FK_GENRE_MUSIC_ID] FOREIGN KEY ([MusicId]) REFERENCES [dbo].[Music] ([Id]);


GO
PRINT N'Création de Clé étrangère [dbo].[FK_MUSIC_GENRE_ID]...';


GO
ALTER TABLE [dbo].[MusicGenre]
    ADD CONSTRAINT [FK_MUSIC_GENRE_ID] FOREIGN KEY ([GenreID]) REFERENCES [dbo].[Genre] ([Id]);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_RetirementDate]...';


GO
ALTER TABLE [dbo].[Artist]
    ADD CONSTRAINT [CK_RetirementDate] CHECK ([RetirementDate] > [CreationDate]);


GO
PRINT N'Création de Contrainte de validation [dbo].[CK_EMAIL]...';


GO
ALTER TABLE [dbo].[User_]
    ADD CONSTRAINT [CK_EMAIL] CHECK ([Email] LIKE '%@%.%');


GO
PRINT N'Création de Fonction [dbo].[GetPepper]...';


GO
CREATE FUNCTION [dbo].[GetPepper]
(
	@param1 int,
	@param2 char(5)
)
RETURNS NVARCHAR(100)

AS
BEGIN
	RETURN 'pepper-16zeff-zfdvzfz-zf<wsdezf-zf<wcze'
END
GO
PRINT N'Création de Procédure [dbo].[CreateUser]...';


GO
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
GO
PRINT N'Création de Procédure [dbo].[Login]...';


GO
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
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
