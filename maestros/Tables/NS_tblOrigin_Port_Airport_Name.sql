CREATE TABLE [maestros].[NS_tblOrigin_Port_Airport_Name] (
    [Pkid]                 INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]               VARCHAR (250) NULL,
    [DescripcionEspanol]   VARCHAR (250) NULL,
    [DescripcionPortugues] VARCHAR (250) NULL,
    CONSTRAINT [PK_NS_tblOrigin_Port_Airport_Name] PRIMARY KEY CLUSTERED ([Pkid] ASC) ON [DATOSMAESTROS]
) ON [DATOSMAESTROS];


GO

