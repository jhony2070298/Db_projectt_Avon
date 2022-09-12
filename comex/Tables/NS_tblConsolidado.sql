CREATE TABLE [comex].[NS_tblConsolidado] (
    [Pkid]                     INT           IDENTITY (1, 1) NOT NULL,
    [AÑO]                      VARCHAR (250) NULL,
    [IMP_EXP]                  VARCHAR (250) NULL,
    [MES]                      VARCHAR (250) NULL,
    [COMPAÑIA]                 VARCHAR (250) NULL,
    [COUNTRY]                  VARCHAR (250) NULL,
    [ORIGIN_REGION]            VARCHAR (250) NULL,
    [ORIGIN_COUNTRY]           VARCHAR (250) NULL,
    [ORIGIN_CITY_PICK_UP]      VARCHAR (250) NULL,
    [ORIGIN_PORT_AIRPORT_NAME] VARCHAR (250) NULL,
    [DEST_COUNTRY]             VARCHAR (250) NULL,
    [DESTINATION_CITY]         VARCHAR (250) NULL,
    [DEST_PORT_AIRPORT_NAME]   VARCHAR (250) NULL,
    [MODAL]                    VARCHAR (250) NULL,
    [C_TYPE]                   VARCHAR (250) NULL,
    [CNT_20_QTY]               VARCHAR (250) NULL,
    [CNT_40_QTY]               VARCHAR (250) NULL,
    [GROSS_WEIGHT]             VARCHAR (250) NULL,
    [M3]                       VARCHAR (250) NULL,
    [FREIGHT_FORWARDER]        VARCHAR (250) NULL,
    [SUPPLIER]                 VARCHAR (350) NULL,
    [INCOTERM]                 VARCHAR (250) NULL,
    [PRODUCT_COST]             VARCHAR (250) NULL,
    [FREIGHT_VALUE]            VARCHAR (250) NULL,
    [IMPORT_DUTY]              VARCHAR (250) NULL,
    [PICK_UP_DATE]             VARCHAR (250) NULL,
    [SHIP_DATE]                VARCHAR (250) NULL,
    [ARRIVAL_DATE]             VARCHAR (250) NULL,
    [CUSTOM_CLEARANCE_DATE]    VARCHAR (250) NULL,
    [AVON_RECEIPT]             VARCHAR (250) NULL,
    [QTY_PO]                   VARCHAR (250) NULL,
    [PRODUCT_CATEGORY]         VARCHAR (250) NULL,
    [DANGEROUS_GOOD]           VARCHAR (250) NULL,
    [SPOT_SHIPMENT]            VARCHAR (250) NULL,
    [INTERNATIONAL_INSURANCE]  VARCHAR (250) NULL,
    [CUSTOM_EXPENSES]          VARCHAR (250) NULL,
    [INLAND_FREIGHT_DESP]      VARCHAR (250) NULL,
    [INLAND_TRANSPORT_COMPANY] VARCHAR (250) NULL,
    [SHIPMENT_REFERENCE]       VARCHAR (250) NULL,
    [AÑOMES]                   INT           NULL,
    [LT_STD]                   VARCHAR (250) NULL,
    [UBICACION]                VARCHAR (250) NULL
) ON [DATOSMAESTROS];


GO
