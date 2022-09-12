CREATE TABLE [maestros].[NS_tblIncoterm] (
    [Pkid]                 INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]               VARCHAR (250) NULL,
    [DescripcionEspanol]   VARCHAR (250) NULL,
    [DescripcionPortugues] VARCHAR (250) NULL,
    CONSTRAINT [PK_NS_tblIncoterm] PRIMARY KEY CLUSTERED ([Pkid] ASC) ON [DATOSMAESTROS]
) ON [DATOSMAESTROS];


GO

