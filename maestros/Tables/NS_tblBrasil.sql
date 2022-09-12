CREATE TABLE [maestros].[NS_tblBrasil] (
    [Pkid]                       INT           IDENTITY (1, 1) NOT NULL,
    [YEAR]                       VARCHAR (250) NULL,
    [MONTH]                      VARCHAR (250) NULL,
    [SHIPMENT REEFERENCE]        VARCHAR (250) NULL,
    [ORIGIN REGION]              VARCHAR (250) NULL,
    [ORIGIN COUNTRY]             VARCHAR (250) NULL,
    [ORIGIN CITY PICK UP]        VARCHAR (250) NULL,
    [ORIGIN PORT / AIRPORT NAME] VARCHAR (250) NULL,
    [DEST COUNTRY]               VARCHAR (250) NULL,
    [DEST CITY]                  VARCHAR (250) NULL,
    [DEST PORT / AIRPORT NAME]   VARCHAR (250) NULL,
    [MODE]                       VARCHAR (250) NULL,
    [TYPE]                       VARCHAR (250) NULL,
    [CNT 20 QTY]                 VARCHAR (250) NULL,
    [CNT 40 QTY]                 VARCHAR (250) NULL,
    [ GROSS WEIGHT ]             VARCHAR (250) NULL,
    [ M3 ]                       VARCHAR (250) NULL,
    [FREIGHT FORWARDER]          VARCHAR (250) NULL,
    [SUPPLIER]                   VARCHAR (250) NULL,
    [INCOTERM]                   VARCHAR (250) NULL,
    [ PRODUCT COST ]             VARCHAR (250) NULL,
    [ FREIGHT VALUE ]            VARCHAR (250) NULL,
    [ IMPORT DUTY ]              VARCHAR (250) NULL,
    [PICK UP DATE]               VARCHAR (250) NULL,
    [SHIP DATE]                  VARCHAR (250) NULL,
    [ARRIVAL DATE]               VARCHAR (250) NULL,
    [CUSTOM CLEARANCE DATE]      VARCHAR (250) NULL,
    [AVON RECEIPT]               VARCHAR (250) NULL,
    [QTY PO]                     VARCHAR (250) NULL,
    [PRODUCT CATEGORY]           VARCHAR (250) NULL,
    [DANGEROUS GOODS]            VARCHAR (250) NULL,
    [SPOT SHIPMENT]              VARCHAR (250) NULL,
    [INTERNATIONAL INSURANCE]    VARCHAR (250) NULL,
    [CUSTOMS EXPENSES]           VARCHAR (250) NULL,
    [INLAND FREIGH DEST]         VARCHAR (250) NULL,
    [INLAND TRANSPORT COMPANY]   VARCHAR (250) NULL,
    [BL]                         VARCHAR (250) NULL
) ON [DATOSMAESTROS];


GO
