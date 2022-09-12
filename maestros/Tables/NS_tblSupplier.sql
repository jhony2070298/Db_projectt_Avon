CREATE TABLE [maestros].[NS_tblSupplier] (
    [Pkid]                 INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]               VARCHAR (350) NULL,
    [DescripcionEspanol]   VARCHAR (350) NULL,
    [DescripcionPortugues] VARCHAR (350) NULL,
    CONSTRAINT [PK_NS_tblSupplier] PRIMARY KEY CLUSTERED ([Pkid] ASC) ON [DATOSMAESTROS]
) ON [DATOSMAESTROS];


GO

