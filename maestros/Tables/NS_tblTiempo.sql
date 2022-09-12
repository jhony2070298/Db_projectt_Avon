CREATE TABLE [maestros].[NS_tblTiempo] (
    [IdFecha]       INT          NOT NULL,
    [FechaCompleta] DATE         NOT NULL,
    [Semana]        INT          NOT NULL,
    [Mes]           INT          NOT NULL,
    [Bimestre]      INT          NOT NULL,
    [Trimestre]     INT          NOT NULL,
    [Semestre]      INT          NOT NULL,
    [Año]           INT          NOT NULL,
    [Dia]           INT          NOT NULL,
    [NMes]          VARCHAR (50) NOT NULL,
    [NMesCorto]     VARCHAR (10) NULL,
    [NSemestre]     VARCHAR (50) NOT NULL,
    [NTrimestre]    VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_NS_tblTiempo] PRIMARY KEY CLUSTERED ([IdFecha] ASC) ON [DATOSMAESTROS]
) ON [DATOSMAESTROS];


GO

