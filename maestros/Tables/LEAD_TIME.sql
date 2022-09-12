CREATE TABLE [maestros].[LEAD_TIME] (
    [COMPAÑIA]          VARCHAR (50) NULL,
    [AÑO]               INT          NULL,
    [INI_VIGENCIA]      DATE         NULL,
    [FIN_VIGENCIA]      DATE         NULL,
    [IdCountry]         INT          NULL,
    [COUNTRY]           VARCHAR (50) NULL,
    [REGION]            VARCHAR (50) NULL,
    [IdOrigin_Country]  INT          NULL,
    [ORIGIN_COUNTRY]    VARCHAR (50) NULL,
    [OCEAN]             INT          NULL,
    [AIR]               INT          NULL,
    [ROAD]              INT          NULL,
    [META_CUMPLIMIENTO] FLOAT (53)   NULL,
    [META_FET_AEREO]    FLOAT (53)   NULL
) ON [DATOSMAESTROS];


GO

