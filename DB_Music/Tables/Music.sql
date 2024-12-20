CREATE TABLE [dbo].[Music]
(
	[Id] INT IDENTITY NOT NULL PRIMARY KEY, 
    [Title] NVARCHAR(250) NOT NULL, 
    [RealiseDate] DATE NULL, 
    [Duration] TIME NULL, 
    [SpotifyLink] NVARCHAR(MAX) NULL,

    CONSTRAINT UK_Tile_RealiseDate UNIQUE ([Title], [RealiseDate])
)
