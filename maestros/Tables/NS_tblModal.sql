CREATE TABLE [maestros].[NS_tblModal] (
    [Pkid]                 INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]               VARCHAR (250) NULL,
    [DescripcionEspanol]   VARCHAR (250) NULL,
    [DescripcionPortugues] VARCHAR (250) NULL,
    [Homologacion1]        VARCHAR (250) NULL,
    [Homologacion2]        VARCHAR (250) NULL,
    CONSTRAINT [PK_NS_tblModal] PRIMARY KEY CLUSTERED ([Pkid] ASC) ON [DATOSMAESTROS]
) ON [DATOSMAESTROS];


GO

