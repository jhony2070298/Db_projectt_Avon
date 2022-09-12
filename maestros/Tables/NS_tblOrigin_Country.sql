CREATE TABLE [maestros].[NS_tblOrigin_Country] (
    [Pkid]                 INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]               VARCHAR (250) NULL,
    [DescripcionEspanol]   VARCHAR (250) NULL,
    [DescripcionPortugues] VARCHAR (250) NULL,
    [Homologacion1]        VARCHAR (250) NULL,
    [Homologacion2]        VARCHAR (250) NULL,
    [Homologacion3]        VARCHAR (250) NULL,
    [Homologacion4]        VARCHAR (250) NULL,
    [Homologacion5]        VARCHAR (250) NULL,
    [Region]               VARCHAR (250) NULL,
    CONSTRAINT [PK_NS_tblOrigin_Country] PRIMARY KEY CLUSTERED ([Pkid] ASC) ON [DATOSMAESTROS]
) ON [DATOSMAESTROS];


GO

