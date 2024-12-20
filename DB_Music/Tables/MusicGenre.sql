﻿CREATE TABLE [dbo].[MusicGenre]
(
	[Id] INT IDENTITY NOT NULL PRIMARY KEY,
	[MusicId] INT NOT NULL,
	[GenreID] INT NOT NULL,

	CONSTRAINT FK_GENRE_MUSIC_ID FOREIGN KEY(MusicID)REFERENCES dbo.[Music](id),
	CONSTRAINT FK_MUSIC_GENRE_ID FOREIGN KEY(GenreID)REFERENCES dbo.[Genre](id),
)
