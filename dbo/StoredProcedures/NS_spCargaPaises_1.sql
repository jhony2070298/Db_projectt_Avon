-- =============================================
-- Author:		JHONY MARTÍNEZ Y VALENTINA
-- Create date: 13/11/2021
-- Description:	<Description,,>
-- EXEC NS_spCargaPaises
-- =============================================
CREATE PROCEDURE [dbo].[NS_spCargaPaises_1]
	
AS
BEGIN

	------------------------------------------------------------------------
	-- PASO 1: CARGAR EN ESQUEMA TEMP
	------------------------------------------------------------------------

	-- SE BORRAN LOS REGISTROS NULOS EN LA TEMPORAL
		DELETE [temp].[NS_tblColombia_Temp]
		WHERE Country IS NULL

	--SE LIMPIAN ALGUNOS CAMPOS EN LA TEMPORAL
	UPDATE [temp].[NS_tblColombia_Temp] SET [CNT_20_QTY]=REPLACE(REPLACE(REPLACE(REPLACE([CNT_20_QTY],'-',0),'$',0),'#N/A',0),'USD',0)
	UPDATE [temp].[NS_tblColombia_Temp] SET [CNT_40_QTY]=REPLACE(REPLACE(REPLACE(REPLACE([CNT_40_QTY],'-',0),'$',0),'#N/A',0),'USD',0)
	UPDATE [temp].[NS_tblColombia_Temp] SET [GROSS_WEIGHT]=REPLACE(REPLACE(REPLACE(REPLACE([GROSS_WEIGHT],'-',0),'$',0),'#N/A',0),'USD',0)
	UPDATE [temp].[NS_tblColombia_Temp] SET [M3]=REPLACE(REPLACE(REPLACE(REPLACE([M3],'-',0),'$',''),'#N/A',0),'USD',0)
	UPDATE [temp].[NS_tblColombia_Temp] SET [PRODUCT_COST]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([PRODUCT_COST],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)
	UPDATE [temp].[NS_tblColombia_Temp] SET [FREIGHT_VALUE]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([FREIGHT_VALUE],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)
	UPDATE [temp].[NS_tblColombia_Temp] SET [IMPORT_DUTY]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([IMPORT_DUTY],'-',0),'$',''),'#N/A',''),'USD',''),'COP',0)
	UPDATE [temp].[NS_tblColombia_Temp] SET [INTERNATIONAL_INSURANCE]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([INTERNATIONAL_INSURANCE],'-',0),'$',0),'#N/A',0),'USD',''),'COP',0)
	UPDATE [temp].[NS_tblColombia_Temp] SET [CUSTOM_EXPENSES]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([CUSTOM_EXPENSES],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)
	UPDATE [temp].[NS_tblColombia_Temp] SET [INLAND_FREIGHT_DESP]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([INLAND_FREIGHT_DESP],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)

	UPDATE [temp].[NS_tblColombia_Temp] SET [PICK_UP_DATE]=REPLACE(REPLACE([PICK_UP_DATE],'#N/D',''),'#N/A','')
	UPDATE [temp].[NS_tblColombia_Temp] SET [SHIP_DATE]=REPLACE(REPLACE([SHIP_DATE],'#N/D',''),'#N/A','')
	UPDATE [temp].[NS_tblColombia_Temp] SET [ARRIVAL_DATE]=REPLACE(REPLACE([ARRIVAL_DATE],'#N/D',''),'#N/A','')
	UPDATE [temp].[NS_tblColombia_Temp] SET [CUSTOM_CLEARANCE_DATE]=REPLACE(REPLACE([CUSTOM_CLEARANCE_DATE],'#N/D',''),'#N/A','')
	UPDATE [temp].[NS_tblColombia_Temp] SET [FECHA_RECEBTO]=REPLACE(REPLACE([FECHA_RECEBTO],'#N/D',''),'#N/A','')


	--SE INSERTA COLOMBIA EN EL CONSOLIDADO TEMP
		INSERT INTO [temp].[NS_tblConsolidado_Temp] (
		[AÑO],
		--[IMP_EXP],
		[MES], 
		[COMPAÑIA],
		[COUNTRY],
		[SHIPMENT_REFERENCE],
		[ORIGIN_REGION],
		[ORIGIN_COUNTRY],
		[ORIGIN_CITY_PICK_UP],
		[ORIGIN_PORT_AIRPORT_NAME],
		[DEST_COUNTRY],
		[DESTINATION_CITY], 
		[DEST_PORT_AIRPORT_NAME],
		[MODAL],
		[C_TYPE],
		[CNT_20_QTY], 
		[CNT_40_QTY],
		[GROSS_WEIGHT], 
		[M3],
		[FREIGHT_FORWARDER],
		[SUPPLIER],
		[INCOTERM], 
		[PRODUCT_COST],
		[FREIGHT_VALUE],
		[IMPORT_DUTY], 
		[PICK_UP_DATE],
		[SHIP_DATE], 
		[ARRIVAL_DATE],
		[CUSTOM_CLEARANCE_DATE],
		[AVON_RECEIPT],
		[QTY_PO], 
		[PRODUCT_CATEGORY],
		[DANGEROUS_GOOD],
		[SPOT_SHIPMENT],
		[INTERNATIONAL_INSURANCE],
		[CUSTOM_EXPENSES],
		[INLAND_FREIGHT_DESP],
		[INLAND_TRANSPORT_COMPANY],
		[LT_STD]
		)
		SELECT 
			col.[AÑO],
			col.[MONTH],
			col.[COMPAÑIA],
			col.[DEST_COUNTRY],
			CASE 
				WHEN col.[SHIPMENT_REFERENCE] IS NULL OR col.[SHIPMENT_REFERENCE] ='' THEN COL.BL ELSE COL.SHIPMENT_REFERENCE END,
			col.[ORIGIN_REGION],
			col.[ORIGIN_COUNTRY],
			col.[ORIGIN_CITY_PICK_UP],
			col.[ORIGIN_PORT_AIRPORT_NAME],
			col.[DEST_COUNTRY],
			col.[DESTINATION_CITY],
			col.[DEST_PORT_AIRPORT_NAME], 
			col.[MODAL],
			col.[C_TYPE], 
			col.[CNT_20_QTY], 
			col.[CNT_40_QTY],
			col.[GROSS_WEIGHT],
			col.[M3], 
			col.[FREIGHT_FORWARDER],
			col.[SUPPLIER], 
			col.[INCOTERM], 
			col.[PRODUCT_COST], 
			col.[FREIGHT_VALUE],
			col.[IMPORT_DUTY],
			CAST(CONVERT(DATETIME,col.[PICK_UP_DATE],103) AS DATE),
			CAST(CONVERT(DATETIME,col.[SHIP_DATE],103) AS DATE),
			CAST(CONVERT(DATETIME,col.[ARRIVAL_DATE],103) AS DATE),
			CAST(CONVERT(DATETIME,col.[CUSTOM_CLEARANCE_DATE],103) AS DATE),
			CAST(CONVERT(DATETIME,col.[AVON_RECEIPT],103) AS DATE),
			col.[QTY_PO],
			col.[PRODUCT_CATEGORY],
			col.[DANGEROUS_GOOD],
			col.[SPOT_SHIPMENT],
			col.[INTERNATIONAL_INSURANCE],
			col.[CUSTOM_EXPENSES],
			col.[INLAND_FREIGHT_DESP], 
			col.[INLAND_TRANSPORT_COMPANY],
			col.[LT_STD]
		FROM [temp].[NS_tblColombia_Temp] col 
		LEFT JOIN [temp].[NS_tblConsolidado_Temp] cons 
			ON col.SHIPMENT_REFERENCE = cons.SHIPMENT_REFERENCE AND col.[GROSS_WEIGHT] = cons.GROSS_WEIGHT
		WHERE cons.SHIPMENT_REFERENCE IS NULL

		
		-- SE BORRAN LOS REGISTROS NULOS EN LA TEMPORAL
		DELETE [temp].[NS_tblEcuador_Temp]
		WHERE Country IS NULL

		--SE LIMPIAN ALGUNOS CAMPOS EN LA TEMPORAL
		UPDATE [temp].[NS_tblEcuador_Temp] SET [CNT_20_QTY]=REPLACE(REPLACE(REPLACE(REPLACE([CNT_20_QTY],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblEcuador_Temp] SET [CNT_40_QTY]=REPLACE(REPLACE(REPLACE(REPLACE([CNT_40_QTY],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblEcuador_Temp] SET [GROSS_WEIGHT]=REPLACE(REPLACE(REPLACE(REPLACE([GROSS_WEIGHT],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblEcuador_Temp] SET [M3]=REPLACE(REPLACE(REPLACE(REPLACE([M3],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblEcuador_Temp] SET [PRODUCT_COST]=REPLACE(REPLACE(REPLACE(REPLACE([PRODUCT_COST],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblEcuador_Temp] SET [FREIGHT_VALUE]=REPLACE(REPLACE(REPLACE(REPLACE([FREIGHT_VALUE],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblEcuador_Temp] SET [IMPORT_DUTY]=REPLACE(REPLACE(REPLACE(REPLACE([IMPORT_DUTY],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblEcuador_Temp] SET [INTERNATIONAL_INSURANCE]=REPLACE(REPLACE(REPLACE(REPLACE([INTERNATIONAL_INSURANCE],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblEcuador_Temp] SET [Customs_expenses]=REPLACE(REPLACE(REPLACE(REPLACE([Customs_expenses],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblEcuador_Temp] SET [Inland_freight_dest]=REPLACE(REPLACE(REPLACE(REPLACE([Inland_freight_dest],'-',0),'$',0),'#N/A',0),'USD',0)

		--SE INSERTA ECUADOR EN EL CONSOLIDADO
		INSERT INTO [temp].[NS_tblConsolidado_Temp] (
		[AÑO],
		--[IMP_EXP],
		[MES], 
		[COMPAÑIA],
		[COUNTRY],
		[SHIPMENT_REFERENCE],
		[ORIGIN_REGION],
		[ORIGIN_COUNTRY],
		[ORIGIN_CITY_PICK_UP],
		[ORIGIN_PORT_AIRPORT_NAME],
		[DEST_COUNTRY],
		[DESTINATION_CITY], 
		[DEST_PORT_AIRPORT_NAME],
		[MODAL],
		[C_TYPE],
		[CNT_20_QTY], 
		[CNT_40_QTY],
		[GROSS_WEIGHT], 
		[M3],
		[FREIGHT_FORWARDER],
		[SUPPLIER],
		[INCOTERM], 
		[PRODUCT_COST],
		[FREIGHT_VALUE],
		[IMPORT_DUTY], 
		[PICK_UP_DATE],
		[SHIP_DATE], 
		[ARRIVAL_DATE],
		[CUSTOM_CLEARANCE_DATE],
		[AVON_RECEIPT],
		[QTY_PO], 
		[PRODUCT_CATEGORY],
		[DANGEROUS_GOOD],
		[SPOT_SHIPMENT],
		[INTERNATIONAL_INSURANCE],
		[CUSTOM_EXPENSES],
		[INLAND_FREIGHT_DESP],
		[INLAND_TRANSPORT_COMPANY],
		LT_STD
		)
		SELECT 
		ec.[AÑO],
		--IIF(LEN([Avon_receipt]) = 9,(SELECT SUBSTRING([Avon_receipt], 6 , 4)),(SELECT SUBSTRING([Avon_receipt], 7 , 4)))
		ec.[Month]
		,'AVON'
		,ec.Country
		,ec.Shipment_Reference
		,ec.OriginRegion
		,ec.Origin_Country
		,ec.Origin_City_Pick_Up
		,ec.Origin_port_airport_name
		,ec.Dest_Country
		,ec.Dest_city
		,ec.Dest_port_airport_name
		--,Descripción_Modal
		,ec.[MODE]
		,ec.[Type]
		,ec.Cnt_20_QTY
		,ec.Cnt_40_QTY
		,ec.GROSS_WEIGHT
		,ec.M3
		,ec.Freight_forwarder
		,ec.Supplier
		,ec.Incoterm
		,ec.Product_cost
		,ec.Freight_value
		,ec.Import_Duty
		,CAST(CONVERT(DATETIME,ec.Pick_up_date,103) AS DATE) 
		,CAST(CONVERT(DATETIME,ec.Ship_date,103) AS DATE) 
		,CAST(CONVERT(DATETIME,ec.Arrival_date,103) AS DATE) 
		,CAST(CONVERT(DATETIME,ec.Custom_clearance_date,103) AS DATE) 
		,CAST(CONVERT(DATETIME,ec.Avon_receipt,103) AS DATE) 
		,ec.Qty_PO
		,ec.Product_category
		,ec.Dangerous_goods
		,ec.Spot_shipment
		,ec.International_insurance
		,ec.Customs_expenses
		,ec.Inland_freight_dest
		,ec.Inland_transport_company
		,ec.LT_STD
		FROM [temp].[NS_tblEcuador_Temp] ec 
		LEFT JOIN [temp].[NS_tblConsolidado_Temp] cons 
			ON ec.SHIPMENT_REFERENCE = cons.SHIPMENT_REFERENCE AND ec.[GROSS_WEIGHT] = cons.GROSS_WEIGHT
		WHERE cons.SHIPMENT_REFERENCE IS NULL
		    
		
				
		-- SE BORRAN LOS REGISTROS NULOS EN LA TEMPORAL
		DELETE [temp].[NS_tblPeru_Temp]
		WHERE Country IS NULL

		--CALCULAR CAMPOS QUE NO VIENEN EN EL WM
		UPDATE [temp].[NS_tblPeru_Temp] SET AÑO=YEAR(CAST(CONVERT(DATETIME,Avon_receipt,103) AS DATE)) WHERE AÑO IS NULL OR AÑO=''
		UPDATE [temp].[NS_tblPeru_Temp] SET Country=Dest_Country WHERE Country<>Dest_Country

		--SE LIMPIAN ALGUNOS CAMPOS EN LA TEMPORAL
		UPDATE [temp].[NS_tblPeru_Temp] SET [CNT_20_QTY]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([CNT_20_QTY],'-',0),'$',0),'x',0),'X',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblPeru_Temp] SET [CNT_40_QTY]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([CNT_40_QTY],'-',0),'$',0),'x',0),'X',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblPeru_Temp] SET [KG]=REPLACE(REPLACE(REPLACE(REPLACE([KG],'-',0),'$',0),'#N/A',0),'USD',0)
		UPDATE [temp].[NS_tblPeru_Temp] SET [M3]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([M3],'-',0),'$',0),'#N/A',0),'USD',0),' ','')
		UPDATE [temp].[NS_tblPeru_Temp] SET [PRODUCT_COST]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([PRODUCT_COST],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)
		UPDATE [temp].[NS_tblPeru_Temp] SET [FREIGHT_VALUE]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([FREIGHT_VALUE],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)
		UPDATE [temp].[NS_tblPeru_Temp] SET [IMPORT_DUTY]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([IMPORT_DUTY],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)
		UPDATE [temp].[NS_tblPeru_Temp] SET [INTERNATIONAL_INSURANCE]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([INTERNATIONAL_INSURANCE],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)
		UPDATE [temp].[NS_tblPeru_Temp] SET [Customs_expenses]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([Customs_expenses],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)
		UPDATE [temp].[NS_tblPeru_Temp] SET [Inland_freight_dest]=REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([Inland_freight_dest],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)

		--SE INSERTA PERÚ EN EL CONSOLIDADO
		INSERT INTO [temp].[NS_tblConsolidado_Temp] (
		[AÑO],
		--[IMP_EXP],
		[MES],
		[COMPAÑIA],
		[COUNTRY],
        [SHIPMENT_REFERENCE],
		[ORIGIN_REGION],
		[ORIGIN_COUNTRY],
		[ORIGIN_CITY_PICK_UP],
		[ORIGIN_PORT_AIRPORT_NAME],
		[DEST_COUNTRY],
		[DESTINATION_CITY], 
		[DEST_PORT_AIRPORT_NAME],
		[MODAL],
		[C_TYPE],
		[CNT_20_QTY], 
		[CNT_40_QTY],
		[GROSS_WEIGHT], 
		[M3],
		[FREIGHT_FORWARDER],
		[SUPPLIER],
		[INCOTERM], 
		[PRODUCT_COST],
		[FREIGHT_VALUE],
		[IMPORT_DUTY], 
		[PICK_UP_DATE],
		[SHIP_DATE], 
		[ARRIVAL_DATE],
		[CUSTOM_CLEARANCE_DATE],
		[AVON_RECEIPT],
		[QTY_PO], 
		[PRODUCT_CATEGORY],
		[DANGEROUS_GOOD],
		[SPOT_SHIPMENT],
		[INTERNATIONAL_INSURANCE],
		[CUSTOM_EXPENSES],
		[INLAND_FREIGHT_DESP],
		[INLAND_TRANSPORT_COMPANY],
		LT_STD
		)
		SELECT
		peru.AÑO
		--IIF(LEN(Avon_receipt) = 9,(SELECT SUBSTRING(Avon_receipt, 6 , 4)),(SELECT SUBSTRING(Avon_receipt, 7 , 4)))
		,peru.MES 
		,peru.COMPAÑIA
		,peru.Country
		,CASE 
			WHEN peru.Shipment_Reference IS NULL OR peru.Shipment_Reference ='' THEN peru.Doc_Transporte ELSE peru.Shipment_Reference END
		,peru.OriginRegion
		,peru.Origin_Country
		,peru.Origin_City_Pick_Up
		,peru.Origin_port_airport_name
		,peru.Dest_Country
		,peru.Dest_city
		,peru.Dest_port_airport_name
		,peru.Descripción_Modal
		,peru.[Type]
		,peru.Cnt_20_QTY
		,peru.Cnt_40_QTY
		,peru.KG
		,peru.M3
		,peru.Freight_forwarder
		,peru.Supplier
		,peru.Incoterm
		,peru.Product_Cost
		,peru.Freight_value
		,peru.Import_Duty
		--,CONVERT(DATE, REPLACE(REPLACE(REPLACE(peru.Pick_up_date,CHAR (39),''),'-',''),'/',''), 105)
		--,CONVERT(DATE, REPLACE(REPLACE(REPLACE(peru.Ship_date,CHAR (39),''),'-',''),'/',''), 105)
		--,CONVERT(DATE, REPLACE(REPLACE(REPLACE(peru.Arrival_date,CHAR (39),''),'-',''),'/',''), 105)
		--,CONVERT(DATE, REPLACE(REPLACE(REPLACE(peru.Custom_clearance_date,CHAR (39),''),'-',''),'/',''), 105)
		--,CONVERT(DATE, REPLACE(REPLACE(REPLACE(peru.Avon_receipt,CHAR (39),''),'-',''),'/',''), 105)
		,CAST(CONVERT(DATETIME,peru.Pick_up_date,103) AS DATE) 
		,CAST(CONVERT(DATETIME,peru.Ship_date,103) AS DATE) 
		,CAST(CONVERT(DATETIME,peru.Arrival_date,103) AS DATE) 
		,CAST(CONVERT(DATETIME,peru.Custom_clearance_date,103) AS DATE) 
		,CAST(CONVERT(DATETIME,peru.Avon_receipt,103) AS DATE) 
		,peru.Qty_PO
		,peru.Product_category
		,peru.Dangerous_goods
		,peru.Spot_shipment
		,peru.International_insurance
		,peru.Customs_expenses
		,peru.Inland_freight_dest
		,peru.Inland_transport_company
		,peru.LT_STD
		--,[PALLETS]
		--,[FECHA_DISPONIBILIZACION]
		--,[FECHA_FACTURA]
		FROM [temp].[NS_tblPeru_Temp] peru 
		LEFT JOIN [temp].[NS_tblConsolidado_Temp] cons 
			ON peru.SHIPMENT_REFERENCE = cons.SHIPMENT_REFERENCE AND peru.[KG] = cons.GROSS_WEIGHT
		WHERE cons.SHIPMENT_REFERENCE IS NULL


		------NOLA

		--SE BORRAN LOS REGISTROS NULOS EN LA TEMPORAL
		DELETE [temp].[NS_tblMexico_Temp]
		WHERE [DESTINATION COUNTRY] IS NULL

		--SE LIMPIAN ALGUNOS CAMPOS EN LA TEMPORAL
		UPDATE [temp].[NS_tblMexico_Temp] SET [CNT 20 QTY]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([CNT 20 QTY],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [CNT 40 QTY]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([CNT 40 QTY],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [GROSS WEIGHT]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([GROSS WEIGHT],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [M3]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([M3],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [ PRODUCT COST ]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([ PRODUCT COST ],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [ FREIGHT VALUE ]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([ FREIGHT VALUE ],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [ IMPORT DUTY ]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([ IMPORT DUTY ],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [QTY PO]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([QTY PO],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [ INTERNATIONAL INSURANCE ]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([ INTERNATIONAL INSURANCE ],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [ CUSTOM EXPENSES ]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([ CUSTOM EXPENSES ],'-',0),'$',0),'#N/A',0)))
		UPDATE [temp].[NS_tblMexico_Temp] SET [ INLAND FREIGHT DESP ]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE([ INLAND FREIGHT DESP ],'-',0),'$',0),'#N/A',0)))

		UPDATE [temp].[NS_tblMexico_Temp] SET [PICK UP DATE]=REPLACE([PICK UP DATE],CHAR (39),'')
		UPDATE [temp].[NS_tblMexico_Temp] SET [SHIP DATE]=REPLACE([SHIP DATE],CHAR (39),'')
		UPDATE [temp].[NS_tblMexico_Temp] SET [ARRIVAL DATE]=REPLACE([ARRIVAL DATE],CHAR (39),'')
		UPDATE [temp].[NS_tblMexico_Temp] SET [CUSTOM CLEARANCE DATE]=REPLACE([CUSTOM CLEARANCE DATE],CHAR (39),'')
		UPDATE [temp].[NS_tblMexico_Temp] SET [FECHA RECEPTO]=REPLACE([FECHA RECEPTO],CHAR (39),'')

		UPDATE [temp].[NS_tblMexico_Temp] SET [PICK UP DATE]=REPLACE([PICK UP DATE],'#N/A','')
		UPDATE [temp].[NS_tblMexico_Temp] SET [SHIP DATE]=REPLACE([SHIP DATE],'#N/A','')
		UPDATE [temp].[NS_tblMexico_Temp] SET [ARRIVAL DATE]=REPLACE([ARRIVAL DATE],'#N/A','')
		UPDATE [temp].[NS_tblMexico_Temp] SET [CUSTOM CLEARANCE DATE]=REPLACE([CUSTOM CLEARANCE DATE],'#N/A','')
		UPDATE [temp].[NS_tblMexico_Temp] SET [FECHA RECEPTO]=REPLACE([FECHA RECEPTO],'#N/A','')

		--UPDATE [temp].[NS_tblMexico_Temp] SET [PICK UP DATE]=REPLACE([PICK UP DATE],'-','')
		--UPDATE [temp].[NS_tblMexico_Temp] SET [SHIP DATE]=REPLACE([SHIP DATE],'-','')

		UPDATE [temp].[NS_tblMexico_Temp] SET [PICK UP DATE]=CASE WHEN [PICK UP DATE] = '-' THEN null ELSE [PICK UP DATE] END
		UPDATE [temp].[NS_tblMexico_Temp] SET [SHIP DATE]=CASE WHEN [SHIP DATE] = '-' THEN null ELSE [SHIP DATE] END
		UPDATE [temp].[NS_tblMexico_Temp] SET [ARRIVAL DATE]=CASE WHEN [ARRIVAL DATE] = '-' THEN null ELSE [ARRIVAL DATE] END
		UPDATE [temp].[NS_tblMexico_Temp] SET [CUSTOM CLEARANCE DATE]=CASE WHEN [CUSTOM CLEARANCE DATE] = '-' THEN null ELSE [CUSTOM CLEARANCE DATE] END
		UPDATE [temp].[NS_tblMexico_Temp] SET [FECHA RECEPTO]=CASE WHEN [FECHA RECEPTO] = '-' THEN null ELSE [FECHA RECEPTO] END

		--SE INSERTA MEXICO EN EL CONSOLIDADO
		INSERT INTO [temp].[NS_tblConsolidado_Temp] (
		[AÑO],
		--[IMP_EXP],
		[MES],
		[COMPAÑIA],
		[COUNTRY],
        [SHIPMENT_REFERENCE],
		[ORIGIN_REGION],
		[ORIGIN_COUNTRY],
		[ORIGIN_CITY_PICK_UP],
		[ORIGIN_PORT_AIRPORT_NAME],
		[DEST_COUNTRY],
		[DESTINATION_CITY], 
		[DEST_PORT_AIRPORT_NAME],
		[MODAL],
		[C_TYPE],
		[CNT_20_QTY], 
		[CNT_40_QTY],
		[GROSS_WEIGHT], 
		[M3],
		[FREIGHT_FORWARDER],
		[SUPPLIER],
		[INCOTERM], 
		[PRODUCT_COST],
		[FREIGHT_VALUE],
		[IMPORT_DUTY], 
		[PICK_UP_DATE],
		[SHIP_DATE], 
		[ARRIVAL_DATE],
		[CUSTOM_CLEARANCE_DATE],
		[AVON_RECEIPT],
		[QTY_PO], 
		[PRODUCT_CATEGORY],
		[DANGEROUS_GOOD],
		[SPOT_SHIPMENT],
		[INTERNATIONAL_INSURANCE],
		[CUSTOM_EXPENSES],
		[INLAND_FREIGHT_DESP],
		[INLAND_TRANSPORT_COMPANY],
		LT_STD
		)
		SELECT 
		mex.[Año]
		--,[IMP/EXP]
		,mex.[MES]
		,mex.[COMPAÑÍA]
		--,[CLUSTER]
		,mex.[DESTINATION COUNTRY]
		,mex.[SHIPMENT REFERENCE]
		,mex.[ORIGIN REGION]
		,mex.[ORIGIN COUNTRY]
		,mex.[ORIGIN CITY PICK UP]
		,mex.[ORIGIN PORT AIRPORT NAME]
		,mex.[DESTINATION COUNTRY]
		,mex.[DESTINATION CITY]
		,mex.[DESTINATION PORT AIRPORT NAME]
		,mex.[MODAL]
		,mex.[C TYPE]
		,mex.[CNT 20 QTY]
		,mex.[CNT 40 QTY]
		,mex.[GROSS WEIGHT]
		,mex.[M3]
		,mex.[FREIGHT FORWARDER]
		,mex.[SUPPLIER]
		,mex.[INCOTERM]
		,mex.[ PRODUCT COST ]
		,mex.[ FREIGHT VALUE ]
		,mex.[ IMPORT DUTY ]
		,CAST(CONVERT(DATETIME,mex.[PICK UP DATE],103) AS DATE)  
		,CAST(CONVERT(DATETIME,mex.[SHIP DATE],103) AS DATE)  
		,CAST(CONVERT(DATETIME,mex.[ARRIVAL DATE],103) AS DATE)  
		,CAST(CONVERT(DATETIME,mex.[CUSTOM CLEARANCE DATE],103) AS DATE)  
		--,mex.[FECHA ACEPTACIÓN]
		,CAST(CONVERT(DATETIME,mex.[FECHA RECEPTO],103) AS DATE)   
		--,REPLACE(REPLACE(mex.[PICK UP DATE],'-',''),'#N/A','')
		--,REPLACE(REPLACE(mex.[SHIP DATE],'-',''),'#N/A','')
		--,REPLACE(REPLACE(mex.[ARRIVAL DATE],'-',''),'#N/A','')
		--,REPLACE(REPLACE(mex.[CUSTOM CLEARANCE DATE],'-',''),'#N/A','')
		--,REPLACE(REPLACE(mex.[FECHA RECEPTO],'-',''),'#N/A','')
		,mex.[QTY PO]
		,mex.[PRODUCT CATEGORY]
		,mex.[DANGEROUS GOOD]
		,mex.[SPOT SHIPMENT]
		,mex.[ INTERNATIONAL INSURANCE ]
		,mex.[ CUSTOM EXPENSES ]
		,mex.[ INLAND FREIGHT DESP ]
		,mex.[INLAND TRANSPORT COMPANY]
		,''
		--,[PEDIMENTO]
		--,[FACTURA]
		--,[COMENTARIOS]
		FROM [temp].[NS_tblMexico_Temp] mex
		LEFT JOIN [temp].[NS_tblConsolidado_Temp] cons 
			ON mex.[SHIPMENT REFERENCE] = cons.SHIPMENT_REFERENCE AND mex.[GROSS WEIGHT] = cons.GROSS_WEIGHT
		WHERE cons.SHIPMENT_REFERENCE IS NULL


		-- SE BORRAN LOS REGISTROS NULOS EN LA TEMPORAL
		DELETE [temp].[NS_tblGuatemala_Temp]
		WHERE [DEST COUNTRY] IS NULL

		--SE LIMPIAN ALGUNOS CAMPOS EN LA TEMPORAL
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [CNT 20 QTY]=REPLACE(REPLACE(REPLACE([CNT 20 QTY],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [CNT 40 QTY]=REPLACE(REPLACE(REPLACE([CNT 40 QTY],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [ KG ]=REPLACE(REPLACE(REPLACE([ KG ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [M3]=REPLACE(REPLACE(REPLACE([M3],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [ PRODUCT COST ]=REPLACE(REPLACE(REPLACE([ PRODUCT COST ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [ FREIGHT VALUE ]=REPLACE(REPLACE(REPLACE([ FREIGHT VALUE ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [ IMPORT DUTY ]=REPLACE(REPLACE(REPLACE([ IMPORT DUTY ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [ INTERNATIONAL INSURANCE ]=REPLACE(REPLACE(REPLACE([ INTERNATIONAL INSURANCE ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [ CUSTOMS EXPENSES ]=REPLACE(REPLACE(REPLACE([ CUSTOMS EXPENSES ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblGuatemala_Temp] SET [ INLAND FREIGH DEST ]=REPLACE(REPLACE(REPLACE([ INLAND FREIGH DEST ],'-',0),'$',0),'#N/A',0)

		--SE INSERTA GUATEMALA EN EL CONSOLIDADO
		INSERT INTO [temp].[NS_tblConsolidado_Temp] (
		[AÑO],
		--[IMP_EXP],
		[MES], 
		[COMPAÑIA],
		[COUNTRY],
        [SHIPMENT_REFERENCE],
		[ORIGIN_REGION],
		[ORIGIN_COUNTRY],
		[ORIGIN_CITY_PICK_UP],
		[ORIGIN_PORT_AIRPORT_NAME],
		[DEST_COUNTRY],
		[DESTINATION_CITY], 
		[DEST_PORT_AIRPORT_NAME],
		[MODAL],
		[C_TYPE],
		[CNT_20_QTY], 
		[CNT_40_QTY],
		[GROSS_WEIGHT], 
		[M3],
		[FREIGHT_FORWARDER],
		[SUPPLIER],
		[INCOTERM], 
		[PRODUCT_COST],
		[FREIGHT_VALUE],
		[IMPORT_DUTY], 
		[PICK_UP_DATE],
		[SHIP_DATE], 
		[ARRIVAL_DATE],
		[CUSTOM_CLEARANCE_DATE],
		[AVON_RECEIPT],
		[QTY_PO], 
		[PRODUCT_CATEGORY],
		[DANGEROUS_GOOD],
		[SPOT_SHIPMENT],
		[INTERNATIONAL_INSURANCE],
		[CUSTOM_EXPENSES],
		[INLAND_FREIGHT_DESP],
		[INLAND_TRANSPORT_COMPANY],
		LT_STD,
		UBICACION
		)
		SELECT 
		guat.[YEAR]
		,CASE WHEN guat.[MONTH]='' OR guat.[MONTH] IS NULL THEN DATENAME(MONTH,CONVERT(DATE, guat.[AVON RECEIPT], 105)) ELSE guat.[MONTH] END
		--,CASE WHEN guat.[MONTH]='' OR guat.[MONTH] IS NULL THEN DATENAME(MONTH,CAST(guat.[AVON RECEIPT] as date)) ELSE guat.[MONTH] END
		,'AVON'
		,guat.[DEST COUNTRY]
		,guat.[SHIPMENT REEFERENCE]
		,guat.[ORIGIN REGION]
		,guat.[ORIGIN COUNTRY]
		,guat.[ORIGIN CITY PICK UP]
		,guat.[ORIGIN PORT / AIRPORT NAME]
		,guat.[DEST COUNTRY]
		,guat.[DEST CITY]
		,guat.[DEST PORT / AIRPORT NAME]
		,guat.[MODE]
		,guat.[TYPE]
		,guat.[CNT 20 QTY]
		,guat.[CNT 40 QTY]
		,guat.[ KG ]
		,guat.[M3]
		,guat.[FREIGHT FORWARDER]
		,guat.[SUPPLIER]
		,guat.[INCOTERM]
		,guat.[ PRODUCT COST ]
		,guat.[ FREIGHT VALUE ]
		,guat.[ IMPORT DUTY ]
		,CAST(CONVERT(DATETIME,guat.[PICK UP DATE],103) AS DATE)  
		,CAST(CONVERT(DATETIME,guat.[SHIP DATE],103) AS DATE)  
		,CAST(CONVERT(DATETIME,guat.[ARRIVAL DATE],103) AS DATE)  
		,CAST(CONVERT(DATETIME,guat.[CUSTOM CLEARANCE DATE],103) AS DATE)  
		,CAST(CONVERT(DATETIME,guat.[AVON RECEIPT],103) AS DATE)  
		,guat.[QTY PO]
		,guat.[PRODUCT CATEGORY]
		,guat.[DANGEROUS GOODS]
		,guat.[SPOT SHIPMENT]
		,guat.[ INTERNATIONAL INSURANCE ]
		,guat.[ CUSTOMS EXPENSES ]
		,guat.[ INLAND FREIGH DEST ]
		,guat.[INLAND TRANSPORT COMPANY]
		--,guat.[FECHA DESPACHO]
		--,guat.[FECHA ARRIBO]
		,''
		,guat.[UBICACIÓN]
		FROM [temp].[NS_tblGuatemala_Temp] guat
		LEFT JOIN [temp].[NS_tblConsolidado_Temp] cons 
			ON CONCAT(guat.[SHIPMENT REEFERENCE],'-',guat.[ KG ]) = CONCAT(cons.SHIPMENT_REFERENCE,'-',cons.GROSS_WEIGHT)
		WHERE cons.SHIPMENT_REFERENCE IS NULL


		-- SE BORRAN LOS REGISTROS NULOS EN LA TEMPORAL
		DELETE [temp].[NS_tblBrasil_Temp]
		WHERE [DEST COUNTRY] IS NULL

		--SE LIMPIAN ALGUNOS CAMPOS EN LA TEMPORAL
		UPDATE [temp].[NS_tblBrasil_Temp] SET [CNT 20 QTY]=REPLACE(REPLACE(REPLACE([CNT 20 QTY],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblBrasil_Temp] SET [CNT 40 QTY]=REPLACE(REPLACE(REPLACE([CNT 40 QTY],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblBrasil_Temp] SET [ GROSS WEIGHT ]=REPLACE(REPLACE(REPLACE([ GROSS WEIGHT ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblBrasil_Temp] SET [ M3 ]=REPLACE(REPLACE(REPLACE([ M3 ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblBrasil_Temp] SET [ PRODUCT COST ]=REPLACE(REPLACE(REPLACE([ PRODUCT COST ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblBrasil_Temp] SET [ FREIGHT VALUE ]=REPLACE(REPLACE(REPLACE([ FREIGHT VALUE ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblBrasil_Temp] SET [ IMPORT DUTY ]=REPLACE(REPLACE(REPLACE([ IMPORT DUTY ],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblBrasil_Temp] SET [INTERNATIONAL INSURANCE]=REPLACE(REPLACE(REPLACE([INTERNATIONAL INSURANCE],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblBrasil_Temp] SET [CUSTOMS EXPENSES]=REPLACE(REPLACE(REPLACE([CUSTOMS EXPENSES],'-',0),'$',0),'#N/A',0)
		UPDATE [temp].[NS_tblBrasil_Temp] SET [INLAND FREIGH DEST]=REPLACE(REPLACE(REPLACE([INLAND FREIGH DEST],'-',0),'$',0),'#N/A',0)

		--SE INSERTA BRASIL EN EL CONSOLIDADO
		INSERT INTO [temp].[NS_tblConsolidado_Temp] (
		[AÑO],
		--[IMP_EXP],
		[MES], 
		[COMPAÑIA],
		[COUNTRY],
        [SHIPMENT_REFERENCE],
		[ORIGIN_REGION],
		[ORIGIN_COUNTRY],
		[ORIGIN_CITY_PICK_UP],
		[ORIGIN_PORT_AIRPORT_NAME],
		[DEST_COUNTRY],
		[DESTINATION_CITY], 
		[DEST_PORT_AIRPORT_NAME],
		[MODAL],
		[C_TYPE],
		[CNT_20_QTY], 
		[CNT_40_QTY],
		[GROSS_WEIGHT], 
		[M3],
		[FREIGHT_FORWARDER],
		[SUPPLIER],
		[INCOTERM], 
		[PRODUCT_COST],
		[FREIGHT_VALUE],
		[IMPORT_DUTY], 
		[PICK_UP_DATE],
		[SHIP_DATE], 
		[ARRIVAL_DATE],
		[CUSTOM_CLEARANCE_DATE],
		[AVON_RECEIPT],
		[QTY_PO], 
		[PRODUCT_CATEGORY],
		[DANGEROUS_GOOD],
		[SPOT_SHIPMENT],
		[INTERNATIONAL_INSURANCE],
		[CUSTOM_EXPENSES],
		[INLAND_FREIGHT_DESP],
		[INLAND_TRANSPORT_COMPANY],
		LT_STD,
		UBICACION
		)
		SELECT 
		   bra.[YEAR]
		  ,bra.[MONTH]
		  ,CASE WHEN [DEST CITY] LIKE '%NATURA%' THEN 'NATURA'
				WHEN [DEST CITY] LIKE '%CAJAMAR%' THEN 'NATURA'
				WHEN [DEST CITY] LIKE '%AVON%' THEN 'AVON'
				ELSE ''
		  END
		  ,bra.[DEST COUNTRY]
		  ,bra.[SHIPMENT REEFERENCE]
		  ,bra.[ORIGIN REGION]
		  ,bra.[ORIGIN COUNTRY]
		  ,bra.[ORIGIN CITY PICK UP]
		  ,bra.[ORIGIN PORT / AIRPORT NAME]
		  ,bra.[DEST COUNTRY]
		  ,bra.[DEST CITY]
		  ,bra.[DEST PORT / AIRPORT NAME]
		  ,bra.[MODE]
		  ,bra.[TYPE]
		  ,bra.[CNT 20 QTY]
		  ,bra.[CNT 40 QTY]
		  ,bra.[ GROSS WEIGHT ]
		  ,bra.[ M3 ]
		  ,bra.[FREIGHT FORWARDER]
		  ,bra.[SUPPLIER]
		  ,bra.[INCOTERM]
		  ,bra.[ PRODUCT COST ]
		  ,bra.[ FREIGHT VALUE ]
		  ,bra.[ IMPORT DUTY ]
		  --,REPLACE(bra.[PICK UP DATE],'-','')
		  --,REPLACE(bra.[SHIP DATE],'-','')
		  --,REPLACE(bra.[ARRIVAL DATE],'-','')
		  --,REPLACE(bra.[CUSTOM CLEARANCE DATE],'-','')
		  --,REPLACE(bra.[AVON RECEIPT],'-','')
		  ,CAST(CONVERT(DATETIME,bra.[PICK UP DATE],103) AS DATE)  
		  ,CAST(CONVERT(DATETIME,bra.[SHIP DATE],103) AS DATE)  
		  ,CAST(CONVERT(DATETIME,bra.[ARRIVAL DATE],103) AS DATE)  
		  ,CAST(CONVERT(DATETIME,bra.[CUSTOM CLEARANCE DATE],103) AS DATE)  
		  ,CAST(CONVERT(DATETIME,bra.[AVON RECEIPT],103) AS DATE)  
		  ,bra.[QTY PO]
		  ,bra.[PRODUCT CATEGORY]
		  ,bra.[DANGEROUS GOODS]
		  ,bra.[SPOT SHIPMENT]
		  ,bra.[INTERNATIONAL INSURANCE]
		  ,bra.[CUSTOMS EXPENSES]
		  ,bra.[INLAND FREIGH DEST]
		  ,bra.[INLAND TRANSPORT COMPANY]
		  ,''
		  ,''
		FROM [temp].[NS_tblBrasil_Temp] bra
		LEFT JOIN [temp].[NS_tblConsolidado_Temp] cons 
			ON CONCAT(bra.[SHIPMENT REEFERENCE],'-',bra.[ GROSS WEIGHT ]) = CONCAT(cons.SHIPMENT_REFERENCE,'-',cons.GROSS_WEIGHT)
		WHERE cons.SHIPMENT_REFERENCE IS NULL

		-----SMG
		--SE BORRAN LOS REGISTROS NULOS EN LA TEMPORAL
		DELETE [temp].[NS_tblChile_Temp]
		WHERE [DEST COUNTRY] IS NULL

		--SE LIMPIAN ALGUNOS CAMPOS EN LA TEMPORAL
		UPDATE [temp].[NS_tblChile_Temp] SET [CNT 20 QTY]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE([CNT 20 QTY],'-',0),'$',0),'#N/A',0),'USD',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [CNT 40 QTY]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE([CNT 40 QTY],'-',0),'$',0),'#N/A',0),'USD',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [GROSS WEIGHT]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE([GROSS WEIGHT],'-',0),'$',0),'#N/A',0),'USD',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [VOLUME]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE([VOLUME],'-',0),'$',0),'#N/A',0),'USD',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [Product Cost (USD)]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([Product Cost (USD)],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [FREIGHT VALUE]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([FREIGHT VALUE],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [IMPORT DUTY]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([IMPORT DUTY],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [QTY PO]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([QTY PO],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [INTERNATIONAL INSURANCE]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([INTERNATIONAL INSURANCE],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [CUSTOM EXPENSES]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([CUSTOM EXPENSES],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [INLAND FREIGHT DESP]=LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([INLAND FREIGHT DESP],'-',0),'$',0),'#N/A',0),'USD',0),'COP',0)))
		UPDATE [temp].[NS_tblChile_Temp] SET [QTY PO]=0 WHERE [QTY PO] LIKE '%e%'

		UPDATE [temp].[NS_tblChile_Temp] SET [PICK UP DATE]=REPLACE([PICK UP DATE],CHAR (39),'')
		UPDATE [temp].[NS_tblChile_Temp] SET [SHIP DATE]=REPLACE([SHIP DATE],CHAR (39),'')
		UPDATE [temp].[NS_tblChile_Temp] SET [ARRIVAL DATE]=REPLACE([ARRIVAL DATE],CHAR (39),'')
		UPDATE [temp].[NS_tblChile_Temp] SET [CUSTOM CLEARANCE DATE]=REPLACE([CUSTOM CLEARANCE DATE],CHAR (39),'')
		UPDATE [temp].[NS_tblChile_Temp] SET [AVON RECEIPT]=REPLACE([AVON RECEIPT],CHAR (39),'')


		--SE INSERTA CHILE EN EL CONSOLIDADO
		INSERT INTO [temp].[NS_tblConsolidado_Temp](
		[AÑO],
		--[IMP_EXP],
		[MES], 
		[COMPAÑIA],
		[COUNTRY],
        [SHIPMENT_REFERENCE],
		[ORIGIN_REGION],
		[ORIGIN_COUNTRY],
		[ORIGIN_CITY_PICK_UP],
		[ORIGIN_PORT_AIRPORT_NAME],
		[DEST_COUNTRY],
		[DESTINATION_CITY], 
		[DEST_PORT_AIRPORT_NAME],
		[MODAL],
		[C_TYPE],
		[CNT_20_QTY], 
		[CNT_40_QTY],
		[GROSS_WEIGHT], 
		[M3],
		[FREIGHT_FORWARDER],
		[SUPPLIER],
		[INCOTERM], 
		[PRODUCT_COST],
		[FREIGHT_VALUE],
		[IMPORT_DUTY], 
		[PICK_UP_DATE],
		[SHIP_DATE], 
		[ARRIVAL_DATE],
		[CUSTOM_CLEARANCE_DATE],
		[AVON_RECEIPT],
		[QTY_PO], 
		[PRODUCT_CATEGORY],
		[DANGEROUS_GOOD],
		[SPOT_SHIPMENT],
		[INTERNATIONAL_INSURANCE],
		[CUSTOM_EXPENSES],
		[INLAND_FREIGHT_DESP],
		[INLAND_TRANSPORT_COMPANY],
		LT_STD,
		UBICACION
		)
		SELECT 
		   chi.[Año]
		  ,chi.[MONTH]
		  ,chi.[Empresa]
		  ,chi.[Country]
		  ,chi.[SHIPMENT REFERENCE]
		  ,chi.[ORIGIN REGION]
		  ,chi.[ORIGIN COUNTRY]
		  ,chi.[ORIGIN CITY PICK UP]
		  ,chi.[ORIGIN PORT AIRPORT NAME]
		  ,chi.[DEST COUNTRY]
		  ,chi.[DESTINATION CITY]
		  ,chi.[DEST PORT AIRPORT NAME]
		  ,chi.[MODAL]
		  ,chi.[C TYPE]
		  ,chi.[CNT 20 QTY]
		  ,chi.[CNT 40 QTY]
		  ,chi.[GROSS WEIGHT]
		  ,chi.[VOLUME]
		  ,chi.[FREIGHT FORWARDER]
		  ,chi.[SUPPLIER]
		  ,chi.[INCOTERM]
		  ,chi.[Product Cost (USD)]
		  ,chi.[FREIGHT VALUE]
		  ,chi.[IMPORT DUTY]
		  --,CONVERT(DATE, REPLACE(REPLACE(chi.[PICK UP DATE],CHAR (39),''),'/',''), 105)
		  --,CONVERT(DATE, REPLACE(REPLACE(chi.[SHIP DATE],CHAR (39),''),'/',''), 105)
		  --,CONVERT(DATE, REPLACE(REPLACE(chi.[ARRIVAL DATE],CHAR (39),''),'/',''), 105)
		  --,CONVERT(DATE, REPLACE(REPLACE(chi.[CUSTOM CLEARANCE DATE],CHAR (39),''),'/',''), 105)
		  --,CONVERT(DATE, REPLACE(REPLACE(chi.[AVON RECEIPT],CHAR (39),''),'/',''), 105)
		  ,CAST(CONVERT(DATETIME,chi.[PICK UP DATE],103) AS DATE)  
		  ,CAST(CONVERT(DATETIME,chi.[SHIP DATE],103) AS DATE)  
		  ,CAST(CONVERT(DATETIME,chi.[ARRIVAL DATE],103) AS DATE)  
		  ,CAST(CONVERT(DATETIME,chi.[CUSTOM CLEARANCE DATE],103) AS DATE)  
		  ,CAST(CONVERT(DATETIME,chi.[AVON RECEIPT],103) AS DATE)
		  --,chi.[PICK UP DATE]
		  --,chi.[SHIP DATE]
		  --,chi.[ARRIVAL DATE]
		  --,chi.[CUSTOM CLEARANCE DATE]
		  --,chi.[AVON RECEIPT]
		  ,chi.[QTY PO]
		  ,chi.[PRODUCT CATEGORY]
		  ,chi.[DANGEROUS GOOD]
		  ,chi.[SPOT SHIPMENT]
		  ,chi.[INTERNATIONAL INSURANCE]
		  ,chi.[CUSTOM EXPENSES]
		  ,chi.[INLAND FREIGHT DESP]
		  ,chi.[INLAND TRANSPORT COMPANY]
		  ,''
		  ,''
		FROM [temp].[NS_tblChile_Temp] chi
		LEFT JOIN [temp].[NS_tblConsolidado_Temp] cons 
			ON CONCAT(chi.[SHIPMENT REFERENCE],'-',chi.[GROSS WEIGHT]) = CONCAT(cons.SHIPMENT_REFERENCE,'-',cons.GROSS_WEIGHT)
		--WHERE chi.[SHIPMENT REFERENCE] like '%1-1185/9%'
		WHERE cons.SHIPMENT_REFERENCE IS NULL 
--END

	------------------------------------------------------------------------
	-- PASO 2: CARGAR EN ESQUEMA MAESTROS
	------------------------------------------------------------------------

    -- Insertar registros nuevos en la tabla NS_tblColombia
	INSERT INTO maestros.NS_tblColombia (
			[AÑO]
		   ,[MONTH]
           ,[COUNTRY]
           ,[SHIPMENT_REFERENCE]
           ,[EMBARQUE]
           ,[BL]
           ,[ORIGIN_REGION]
           ,[ORIGIN_COUNTRY]
           ,[ORIGIN_CITY_PICK_UP]
           ,[ORIGIN_PORT_AIRPORT_NAME]
           ,[DEST_COUNTRY]
           ,[DESTINATION_CITY]
           ,[DEST_PORT_AIRPORT_NAME]
           ,[MODAL]
           ,[C_TYPE]
           ,[CNT_20_QTY]
           ,[CNT_40_QTY]
           ,[GROSS_WEIGHT]
           ,[M3]
           ,[FREIGHT_FORWARDER]
           ,[SUPPLIER]
           ,[INCOTERM]
           ,[PRODUCT_COST]
           ,[FREIGHT_VALUE]
           ,[IMPORT_DUTY]
           ,[PICK_UP_DATE]
           ,[SHIP_DATE]
           ,[ARRIVAL_DATE]
           ,[CUSTOM_CLEARANCE_DATE]
           ,[AVON_RECEIPT]
           ,[QTY_PO]
           ,[PRODUCT_CATEGORY]
           ,[DANGEROUS_GOOD]
           ,[SPOT_SHIPMENT]
           ,[INTERNATIONAL_INSURANCE]
           ,[CUSTOM_EXPENSES]
           ,[INLAND_FREIGHT_DESP]
           ,[INLAND_TRANSPORT_COMPANY]
           --,[FECHA_ACEPTACION]
           ,[FECHA_RECEBTO]
		   ,[LT_STD]
	)
	 SELECT 
			temp.[AÑO]
		   ,temp.[MONTH]
           ,temp.[COUNTRY]
           ,temp.[SHIPMENT_REFERENCE]
           ,temp.[EMBARQUE]
           ,temp.[BL]
           ,temp.[ORIGIN_REGION]
           ,temp.[ORIGIN_COUNTRY]
           ,temp.[ORIGIN_CITY_PICK_UP]
           ,temp.[ORIGIN_PORT_AIRPORT_NAME]
           ,temp.[DEST_COUNTRY]
           ,temp.[DESTINATION_CITY]
           ,temp.[DEST_PORT_AIRPORT_NAME]
           ,temp.[MODAL]
           ,temp.[C_TYPE]
           ,temp.[CNT_20_QTY]
           ,temp.[CNT_40_QTY]
           ,temp.[GROSS_WEIGHT]
           ,temp.[M3]
           ,temp.[FREIGHT_FORWARDER]
           ,temp.[SUPPLIER]
           ,temp.[INCOTERM]
           ,temp.[PRODUCT_COST]
           ,temp.[FREIGHT_VALUE]
           ,temp.[IMPORT_DUTY]
           ,temp.[PICK_UP_DATE]
           ,temp.[SHIP_DATE]
           ,temp.[ARRIVAL_DATE]
           ,temp.[CUSTOM_CLEARANCE_DATE]
           ,temp.[AVON_RECEIPT]
           ,temp.[QTY_PO]
           ,temp.[PRODUCT_CATEGORY]
           ,temp.[DANGEROUS_GOOD]
           ,temp.[SPOT_SHIPMENT]
           ,temp.[INTERNATIONAL_INSURANCE]
           ,temp.[CUSTOM_EXPENSES]
           ,temp.[INLAND_FREIGHT_DESP]
           ,temp.[INLAND_TRANSPORT_COMPANY]
           --,temp.[FECHA_ACEPTACION]
           ,temp.[FECHA_RECEBTO]
		   ,temp.[LT_STD]
	  FROM temp.NS_tblColombia_Temp temp
		LEFT JOIN maestros.NS_tblColombia col
			ON temp.SHIPMENT_REFERENCE = col.SHIPMENT_REFERENCE
	 WHERE pkid IS NULL


	INSERT INTO [maestros].[NS_tblEcuador]
           ([Country]
		   ,[AÑO]
           ,[Month]
           ,[Shipment_Reference]
           ,[Cnt_20_QTY]
           ,[Cnt_40_QTY]
           ,[Supplier]
           ,[Incoterm]
           ,[Product_cost]
           ,[OriginRegion]
           ,[Origin_Country]
           ,[Type]
           ,[Dest_port_airport_name]
           ,[Dest_city]
           ,[Dest_Country]
           ,[GROSS_WEIGHT]
           ,[M3]
           ,[Freight_forwarder]
           ,[Freight_value]
           ,[Import_Duty]
           ,[Pick_up_date]
           ,[Custom_clearance_date]
           ,[Avon_receipt]
           ,[PO]
           ,[Qty_PO]
           ,[Product_category]
           ,[Dangerous_goods]
           ,[Spot_shipment]
           ,[International_insurance]
           ,[Customs_expenses]
           ,[Inland_freight_dest]
           ,[Inland_transport_company]
           ,[Ship_date]
           ,[Arrival_date]
           ,[Origin_City_Pick_Up]
           ,[Origin_port_airport_name]
		   ,[MODE]
		   ,[LT_STD]
		   )
	SELECT 
			temp.[Country]
		   ,temp.[AÑO]
           ,temp.[Month]
           ,temp.[Shipment_Reference]
           ,temp.[Cnt_20_QTY]
           ,temp.[Cnt_40_QTY]
           ,temp.[Supplier]
           ,temp.[Incoterm]
           ,temp.[Product_cost]
           ,temp.[OriginRegion]
           ,temp.[Origin_Country]
           ,temp.[Type]
           ,temp.[Dest_port_airport_name]
           ,temp.[Dest_city]
           ,temp.[Dest_Country]
           ,temp.[GROSS_WEIGHT]
           ,temp.[M3]
           ,temp.[Freight_forwarder]
           ,temp.[Freight_value]
           ,temp.[Import_Duty]
           ,temp.[Pick_up_date]
           ,temp.[Custom_clearance_date]
           ,temp.[Avon_receipt]
           ,temp.[PO]
           ,temp.[Qty_PO]
           ,temp.[Product_category]
           ,temp.[Dangerous_goods]
           ,temp.[Spot_shipment]
           ,temp.[International_insurance]
           ,temp.[Customs_expenses]
           ,temp.[Inland_freight_dest]
           ,temp.[Inland_transport_company]
           ,temp.[Ship_date]
           ,temp.[Arrival_date]
           ,temp.[Origin_City_Pick_Up]
           ,temp.[Origin_port_airport_name]
		   ,temp.[MODE]
		   ,temp.[LT_STD]
	FROM temp.NS_tblEcuador_Temp temp
		LEFT JOIN maestros.NS_tblEcuador ecu
			ON temp.SHIPMENT_REFERENCE = ecu.SHIPMENT_REFERENCE
	 WHERE pkid IS NULL --AND TEMP.AÑO='2020'--AND TEMP.Shipment_Reference<>'13296'


	 INSERT INTO [maestros].[NS_tblPeru]
           ([AÑO]
		   ,[MES]
           ,[Country]
           ,[Shipment_Reference]
           ,[Supplier]
           ,[Incoterm]
           ,[Product_Cost]
           ,[Cnt_20_QTY]
           ,[Cnt_40_QTY]
           ,[OriginRegion]
           ,[Origin_Country]
           ,[Origin_City_Pick_Up]
           ,[Origin_port_airport_name]
           ,[Dest_Country]
           ,[M3]
           ,[Freight_forwarder]
           ,[Type]
           ,[Descripción_Modal]
           ,[Dest_port_airport_name]
           ,[Dest_city]
           ,[KG]
           ,[Freight_value]
           ,[Import_Duty]
           ,[Pick_up_date]
           ,[Ship_date]
           ,[Arrival_date]
           ,[Numeración]
           ,[Custom_clearance_date]
           ,[Avon_receipt]
           ,[PO]
           ,[Qty_PO]
           ,[Product_category]
           ,[Dangerous_goods]
           ,[Spot_shipment]
           ,[International_insurance]
           ,[Customs_expenses]
           ,[Inland_freight_dest]
           ,[Inland_transport_company]
           ,[Doc_Transporte]
           ,[Declaración]
           ,[Referencia]
           ,[ISD_Factura_Comercial]
           ,[ISD_Gastos_Logisticos]
           ,[Facturas]
           ,[Fecha_Liquidación]
           ,[Tasa_de_Cambio_Liquidación]
		   ,[LT_STD]
	)
	SELECT	temp.[AÑO]
		   ,temp.[MES]
           ,temp.[Country]
           ,temp.[Shipment_Reference]
           ,temp.[Supplier]
           ,temp.[Incoterm]
           ,temp.[Product_Cost]
           ,temp.[Cnt_20_QTY]
           ,temp.[Cnt_40_QTY]
           ,temp.[OriginRegion]
           ,temp.[Origin_Country]
           ,temp.[Origin_City_Pick_Up]
           ,temp.[Origin_port_airport_name]
           ,temp.[Dest_Country]
           ,temp.[M3]
           ,temp.[Freight_forwarder]
           ,temp.[Type]
           ,temp.[Descripción_Modal]
           ,temp.[Dest_port_airport_name]
           ,temp.[Dest_city]
           ,temp.[KG]
           ,temp.[Freight_value]
           ,temp.[Import_Duty]
           ,temp.[Pick_up_date]
           ,temp.[Ship_date]
           ,temp.[Arrival_date]
           ,temp.[Numeración]
           ,temp.[Custom_clearance_date]
           ,temp.[Avon_receipt]
           ,temp.[PO]
           ,temp.[Qty_PO]
           ,temp.[Product_category]
           ,temp.[Dangerous_goods]
           ,temp.[Spot_shipment]
           ,temp.[International_insurance]
           ,temp.[Customs_expenses]
           ,temp.[Inland_freight_dest]
           ,temp.[Inland_transport_company]
           ,temp.[Doc_Transporte]
           ,temp.[Declaración]
           ,temp.[Referencia]
           ,temp.[ISD_Factura_Comercial]
           ,temp.[ISD_Gastos_Logisticos]
           ,temp.[Facturas]
           ,temp.[Fecha_Liquidación]
           ,temp.[Tasa_de_Cambio_Liquidación]
		   ,temp.[LT_STD]
	FROM temp.NS_tblPeru_Temp temp
		LEFT JOIN maestros.NS_tblPeru peru
			ON temp.SHIPMENT_REFERENCE = peru.SHIPMENT_REFERENCE
	WHERE pkid IS NULL

	-- Insertar registros nuevos en la tabla NS_tblMexico
	INSERT INTO [maestros].[NS_tblMexico] 
			([Año]
           ,[IMP/EXP]
           ,[MES]
           ,[COMPAÑÍA]
           ,[CLUSTER]
           ,[SHIPMENT REFERENCE]
           ,[ORIGIN REGION]
           ,[ORIGIN COUNTRY]
           ,[ORIGIN CITY PICK UP]
           ,[ORIGIN PORT AIRPORT NAME]
           ,[DESTINATION COUNTRY]
           ,[DESTINATION CITY]
           ,[DESTINATION PORT AIRPORT NAME]
           ,[MODAL]
           ,[C TYPE]
           ,[CNT 20 QTY]
           ,[CNT 40 QTY]
           ,[GROSS WEIGHT]
           ,[M3]
           ,[FREIGHT FORWARDER]
           ,[SUPPLIER]
           ,[INCOTERM]
           ,[ PRODUCT COST ]
           ,[ FREIGHT VALUE ]
           ,[ IMPORT DUTY ]
           ,[PICK UP DATE]
           ,[SHIP DATE]
           ,[ARRIVAL DATE]
           ,[CUSTOM CLEARANCE DATE]
           ,[FECHA ACEPTACIÓN]
           ,[FECHA RECEPTO]
           ,[QTY PO]
           ,[PRODUCT CATEGORY]
           ,[DANGEROUS GOOD]
           ,[SPOT SHIPMENT]
           ,[ INTERNATIONAL INSURANCE ]
           ,[ CUSTOM EXPENSES ]
           ,[ INLAND FREIGHT DESP ]
           ,[INLAND TRANSPORT COMPANY]
           ,[PEDIMENTO]
           ,[FACTURA]
           ,[COMENTARIOS]
	)
	SELECT temp.[Año]
		  ,temp.[IMP/EXP]
		  ,temp.[MES]
		  ,temp.[COMPAÑÍA]
		  ,temp.[CLUSTER]
		  ,temp.[SHIPMENT REFERENCE]
		  ,temp.[ORIGIN REGION]
		  ,temp.[ORIGIN COUNTRY]
		  ,temp.[ORIGIN CITY PICK UP]
		  ,temp.[ORIGIN PORT AIRPORT NAME]
		  ,temp.[DESTINATION COUNTRY]
		  ,temp.[DESTINATION CITY]
		  ,temp.[DESTINATION PORT AIRPORT NAME]
		  ,temp.[MODAL]
		  ,temp.[C TYPE]
		  ,temp.[CNT 20 QTY]
		  ,temp.[CNT 40 QTY]
		  ,temp.[GROSS WEIGHT]
		  ,temp.[M3]
		  ,temp.[FREIGHT FORWARDER]
		  ,temp.[SUPPLIER]
		  ,temp.[INCOTERM]
		  ,temp.[ PRODUCT COST ]
		  ,temp.[ FREIGHT VALUE ]
		  ,temp.[ IMPORT DUTY ]
		  ,temp.[PICK UP DATE]
		  ,temp.[SHIP DATE]
		  ,temp.[ARRIVAL DATE]
		  ,temp.[CUSTOM CLEARANCE DATE]
		  ,temp.[FECHA ACEPTACIÓN]
		  ,temp.[FECHA RECEPTO]
		  ,temp.[QTY PO]
		  ,temp.[PRODUCT CATEGORY]
		  ,temp.[DANGEROUS GOOD]
		  ,temp.[SPOT SHIPMENT]
		  ,temp.[ INTERNATIONAL INSURANCE ]
		  ,temp.[ CUSTOM EXPENSES ]
		  ,temp.[ INLAND FREIGHT DESP ]
		  ,temp.[INLAND TRANSPORT COMPANY]
		  ,temp.[PEDIMENTO]
		  ,temp.[FACTURA]
		  ,temp.[COMENTARIOS]
	  FROM [temp].[NS_tblMexico_Temp] temp
		  LEFT JOIN maestros.NS_tblMexico mex
				ON temp.[SHIPMENT REFERENCE] = mex.[SHIPMENT REFERENCE]
		WHERE pkid IS NULL


	-- Insertar registros nuevos en la tabla NS_tblGuatemala
	INSERT INTO [maestros].[NS_tblGuatemala] 
		([YEAR]
        ,[MONTH]
        ,[SHIPMENT REEFERENCE]
        ,[ORIGIN REGION]
        ,[ORIGIN COUNTRY]
        ,[ORIGIN CITY PICK UP]
        ,[ORIGIN PORT / AIRPORT NAME]
        ,[DEST COUNTRY]
        ,[DEST CITY]
        ,[DEST PORT / AIRPORT NAME]
        ,[MODE]
        ,[TYPE]
        ,[CNT 20 QTY]
        ,[CNT 40 QTY]
        ,[ KG ]
        ,[M3]
        ,[FREIGHT FORWARDER]
        ,[SUPPLIER]
        ,[INCOTERM]
        ,[ PRODUCT COST ]
        ,[ FREIGHT VALUE ]
        ,[ IMPORT DUTY ]
        ,[PICK UP DATE]
        ,[SHIP DATE]
        ,[ARRIVAL DATE]
        ,[CUSTOM CLEARANCE DATE]
        ,[AVON RECEIPT]
        ,[QTY PO]
        ,[PRODUCT CATEGORY]
        ,[DANGEROUS GOODS]
        ,[SPOT SHIPMENT]
        ,[INTERNATIONAL INSURANCE ]
        ,[ CUSTOMS EXPENSES ]
        ,[ INLAND FREIGH DEST ]
        ,[INLAND TRANSPORT COMPANY]
        ,[FECHA DESPACHO]
        ,[FECHA ARRIBO]
        ,[UBICACIÓN])
	SELECT temp.[YEAR]
		  ,temp.[MONTH]
		  ,temp.[SHIPMENT REEFERENCE]
		  ,temp.[ORIGIN REGION]
		  ,temp.[ORIGIN COUNTRY]
		  ,temp.[ORIGIN CITY PICK UP]
		  ,temp.[ORIGIN PORT / AIRPORT NAME]
		  ,temp.[DEST COUNTRY]
		  ,temp.[DEST CITY]
		  ,temp.[DEST PORT / AIRPORT NAME]
		  ,temp.[MODE]
		  ,temp.[TYPE]
		  ,temp.[CNT 20 QTY]
		  ,temp.[CNT 40 QTY]
		  ,temp.[ KG ]
		  ,temp.[M3]
		  ,temp.[FREIGHT FORWARDER]
		  ,temp.[SUPPLIER]
		  ,temp.[INCOTERM]
		  ,temp.[ PRODUCT COST ]
		  ,temp.[ FREIGHT VALUE ]
		  ,temp.[ IMPORT DUTY ]
		  ,temp.[PICK UP DATE]
		  ,temp.[SHIP DATE]
		  ,temp.[ARRIVAL DATE]
		  ,temp.[CUSTOM CLEARANCE DATE]
		  ,temp.[AVON RECEIPT]
		  ,temp.[QTY PO]
		  ,temp.[PRODUCT CATEGORY]
		  ,temp.[DANGEROUS GOODS]
		  ,temp.[SPOT SHIPMENT]
		  ,temp.[ INTERNATIONAL INSURANCE ]
		  ,temp.[ CUSTOMS EXPENSES ]
		  ,temp.[ INLAND FREIGH DEST ]
		  ,temp.[INLAND TRANSPORT COMPANY]
		  ,temp.[FECHA DESPACHO]
		  ,temp.[FECHA ARRIBO]
		  ,temp.[UBICACIÓN]
	  FROM [temp].[NS_tblGuatemala_Temp] temp
			LEFT JOIN maestros.NS_tblGuatemala guat
				ON CONCAT(temp.[SHIPMENT REEFERENCE],'-',temp.[ KG ]) = CONCAT(guat.[SHIPMENT REEFERENCE],'-',guat.[ KG ])
				--ON temp.[SHIPMENT REEFERENCE] = guat.[SHIPMENT REEFERENCE]
		WHERE pkid IS NULL


	-- Insertar registros nuevos en la tabla NS_tblBrasil
	INSERT INTO [maestros].[NS_tblBrasil] 
		   ([YEAR]
           ,[MONTH]
           ,[SHIPMENT REEFERENCE]
           ,[ORIGIN REGION]
           ,[ORIGIN COUNTRY]
           ,[ORIGIN CITY PICK UP]
           ,[ORIGIN PORT / AIRPORT NAME]
           ,[DEST COUNTRY]
           ,[DEST CITY]
           ,[DEST PORT / AIRPORT NAME]
           ,[MODE]
           ,[TYPE]
           ,[CNT 20 QTY]
           ,[CNT 40 QTY]
           ,[ GROSS WEIGHT ]
           ,[ M3 ]
           ,[FREIGHT FORWARDER]
           ,[SUPPLIER]
           ,[INCOTERM]
           ,[ PRODUCT COST ]
           ,[ FREIGHT VALUE ]
           ,[ IMPORT DUTY ]
           ,[PICK UP DATE]
           ,[SHIP DATE]
           ,[ARRIVAL DATE]
           ,[CUSTOM CLEARANCE DATE]
           ,[AVON RECEIPT]
           ,[QTY PO]
           ,[PRODUCT CATEGORY]
           ,[DANGEROUS GOODS]
           ,[SPOT SHIPMENT]
           ,[INTERNATIONAL INSURANCE]
           ,[CUSTOMS EXPENSES]
           ,[INLAND FREIGH DEST]
           ,[INLAND TRANSPORT COMPANY]
		   ,[BL])
		SELECT 
			 temp.[YEAR]
			,temp.[MONTH]
			,temp.[SHIPMENT REEFERENCE]
			,temp.[ORIGIN REGION]
			,temp.[ORIGIN COUNTRY]
			,temp.[ORIGIN CITY PICK UP]
			,temp.[ORIGIN PORT / AIRPORT NAME]
			,temp.[DEST COUNTRY]
			,temp.[DEST CITY]
			,temp.[DEST PORT / AIRPORT NAME]
			,temp.[MODE]
			,temp.[TYPE]
			,temp.[CNT 20 QTY]
			,temp.[CNT 40 QTY]
			,temp.[ GROSS WEIGHT ]
			,temp.[ M3 ]
			,temp.[FREIGHT FORWARDER]
			,temp.[SUPPLIER]
			,temp.[INCOTERM]
			,temp.[ PRODUCT COST ]
			,temp.[ FREIGHT VALUE ]
			,temp.[ IMPORT DUTY ]
			,temp.[PICK UP DATE]
			,temp.[SHIP DATE]
			,temp.[ARRIVAL DATE]
			,temp.[CUSTOM CLEARANCE DATE]
			,temp.[AVON RECEIPT]
			,temp.[QTY PO]
			,temp.[PRODUCT CATEGORY]
			,temp.[DANGEROUS GOODS]
			,temp.[SPOT SHIPMENT]
			,temp.[INTERNATIONAL INSURANCE]
			,temp.[CUSTOMS EXPENSES]
			,temp.[INLAND FREIGH DEST]
			,temp.[INLAND TRANSPORT COMPANY]
			,temp.[BL]
	  FROM [temp].[NS_tblBrasil_Temp] temp
			LEFT JOIN maestros.NS_tblBrasil bra
				ON CONCAT(temp.[SHIPMENT REEFERENCE],'-',temp.[ GROSS WEIGHT ]) = CONCAT(bra.[SHIPMENT REEFERENCE],'-',bra.[ GROSS WEIGHT ])
				--ON temp.[SHIPMENT REEFERENCE] = guat.[SHIPMENT REEFERENCE]
		WHERE pkid IS NULL

---------------------------------------------------------------------------------------------------------------------------------

	---ACTUALIZAR CAMPOS NULL
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET CNT_20_QTY=0 WHERE CNT_20_QTY IS NULL OR CNT_20_QTY=''
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET CNT_40_QTY=0 WHERE CNT_40_QTY IS NULL OR CNT_40_QTY=''
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET GROSS_WEIGHT=0 WHERE GROSS_WEIGHT IS NULL OR GROSS_WEIGHT=''
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET M3=0 WHERE M3 IS NULL OR M3=''
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET PRODUCT_COST=0 WHERE PRODUCT_COST IS NULL OR PRODUCT_COST=''
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET FREIGHT_VALUE=0 WHERE FREIGHT_VALUE IS NULL OR FREIGHT_VALUE=''
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET IMPORT_DUTY=0 WHERE IMPORT_DUTY IS NULL OR IMPORT_DUTY=''

	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET QTY_PO=0 WHERE QTY_PO IS NULL OR QTY_PO=''
			
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET INTERNATIONAL_INSURANCE=0 WHERE INTERNATIONAL_INSURANCE IS NULL OR INTERNATIONAL_INSURANCE=''
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET CUSTOM_EXPENSES=0 WHERE CUSTOM_EXPENSES IS NULL OR CUSTOM_EXPENSES=''
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET INLAND_FREIGHT_DESP=0 WHERE INLAND_FREIGHT_DESP IS NULL OR INLAND_FREIGHT_DESP=''

	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET ORIGIN_COUNTRY='MEXICO' WHERE COUNTRY='GUATEMALA' AND UBICACION='NAC' AND ORIGIN_COUNTRY IS NULL
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET ORIGIN_CITY_PICK_UP='MEXICO' WHERE COUNTRY='GUATEMALA' AND UBICACION='NAC' AND ORIGIN_CITY_PICK_UP IS NULL
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET ORIGIN_PORT_AIRPORT_NAME='CD. HIDALGO' WHERE COUNTRY='GUATEMALA' AND UBICACION='NAC' AND ORIGIN_PORT_AIRPORT_NAME IS NULL
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET C_TYPE='LTL' WHERE COUNTRY='GUATEMALA' AND UBICACION='NAC' AND C_TYPE IS NULL
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET FREIGHT_FORWARDER='CEVA FREIGHT MANAGEMENT GUATEMALA LTDA' WHERE COUNTRY='GUATEMALA' AND UBICACION='NAC' AND FREIGHT_FORWARDER IS NULL

	---ACTUALIZAR CAMPOS QUE TIENEN ESPACIOS
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET CNT_20_QTY=REPLACE(CNT_20_QTY,' ','')
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET CNT_40_QTY=REPLACE(CNT_40_QTY,' ','')
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET GROSS_WEIGHT=REPLACE(GROSS_WEIGHT,' ','')
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET M3=REPLACE(M3,' ','')
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET PRODUCT_COST=REPLACE(PRODUCT_COST,' ','')
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET FREIGHT_VALUE=REPLACE(FREIGHT_VALUE,' ','')
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET IMPORT_DUTY=REPLACE(IMPORT_DUTY,' ','')

	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET QTY_PO=REPLACE(QTY_PO,' ','')
			
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET INTERNATIONAL_INSURANCE=REPLACE(INTERNATIONAL_INSURANCE,' ','')
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET CUSTOM_EXPENSES=REPLACE(CUSTOM_EXPENSES,' ','')
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET INLAND_FREIGHT_DESP=REPLACE(INLAND_FREIGHT_DESP,' ','')


	--SELECT * FROM [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] WHERE ORIGIN_PORT_AIRPORT_NAME LIKE '%XMJ%'
	UPDATE [AVON_STAGING].[temp].[NS_tblConsolidado_Temp] SET ORIGIN_PORT_AIRPORT_NAME='XMJ' WHERE ORIGIN_PORT_AIRPORT_NAME LIKE '%XMJ%'

	---pasar de la temporal consolidado a comex consolidado
	INSERT INTO [comex].[NS_tblConsolidado] 
			(AÑO
			,IMP_EXP
			,MES
			,COMPAÑIA
			,COUNTRY
			,ORIGIN_REGION
			,ORIGIN_COUNTRY
			,ORIGIN_CITY_PICK_UP
			,ORIGIN_PORT_AIRPORT_NAME
			,DEST_COUNTRY
			,DESTINATION_CITY
			,DEST_PORT_AIRPORT_NAME
			,MODAL
			,C_TYPE
			,CNT_20_QTY
			,CNT_40_QTY
			,GROSS_WEIGHT
			,M3
			,FREIGHT_FORWARDER
			,SUPPLIER
			,INCOTERM
			,PRODUCT_COST
			,FREIGHT_VALUE
			,IMPORT_DUTY
			,PICK_UP_DATE
			,SHIP_DATE
			,ARRIVAL_DATE
			,CUSTOM_CLEARANCE_DATE
			,AVON_RECEIPT
			,QTY_PO
			,PRODUCT_CATEGORY
			,DANGEROUS_GOOD
			,SPOT_SHIPMENT
			,INTERNATIONAL_INSURANCE
			,CUSTOM_EXPENSES
			,INLAND_FREIGHT_DESP
			,INLAND_TRANSPORT_COMPANY
			,SHIPMENT_REFERENCE
			,AÑOMES
			,LT_STD
			,UBICACION
	)
	SELECT  
			 temp.AÑO
			,temp.IMP_EXP
			,temp.MES
			,temp.COMPAÑIA
			,UPPER(temp.COUNTRY)
			,temp.ORIGIN_REGION
			,temp.ORIGIN_COUNTRY
			,temp.ORIGIN_CITY_PICK_UP
			,temp.ORIGIN_PORT_AIRPORT_NAME
			,temp.DEST_COUNTRY
			,temp.DESTINATION_CITY
			,temp.DEST_PORT_AIRPORT_NAME
			,temp.MODAL
			,temp.C_TYPE
			,temp.CNT_20_QTY
			,temp.CNT_40_QTY
			,temp.GROSS_WEIGHT
			,temp.M3
			,temp.FREIGHT_FORWARDER
			,temp.SUPPLIER
			,temp.INCOTERM
			,temp.PRODUCT_COST
			,temp.FREIGHT_VALUE
			,temp.IMPORT_DUTY 
			,temp.PICK_UP_DATE
			,temp.SHIP_DATE
			,temp.ARRIVAL_DATE
			,temp.CUSTOM_CLEARANCE_DATE
			,temp.AVON_RECEIPT
			,temp.QTY_PO
			,temp.PRODUCT_CATEGORY
			,temp.DANGEROUS_GOOD
			,temp.SPOT_SHIPMENT
			,temp.INTERNATIONAL_INSURANCE
			,temp.CUSTOM_EXPENSES
			,temp.INLAND_FREIGHT_DESP
			,temp.INLAND_TRANSPORT_COMPANY
			,temp.SHIPMENT_REFERENCE
			,CASE	WHEN temp.MES=LTRIM(RTRIM('ENERO')) THEN CONCAT(temp.AÑO,'01')
					WHEN temp.MES=LTRIM(RTRIM('ENE')) THEN CONCAT(temp.AÑO,'01')
					WHEN temp.MES=LTRIM(RTRIM('JANUARY')) THEN CONCAT(temp.AÑO,'01')
					WHEN temp.MES=LTRIM(RTRIM('Janeiro')) THEN CONCAT(temp.AÑO,'01')
					WHEN temp.MES=LTRIM(RTRIM('FEBRERO')) THEN CONCAT(temp.AÑO,'02')
					WHEN temp.MES=LTRIM(RTRIM('FEB')) THEN CONCAT(temp.AÑO,'02')
					WHEN temp.MES=LTRIM(RTRIM('FEBRUARY')) THEN CONCAT(temp.AÑO,'02')
					WHEN temp.MES=LTRIM(RTRIM('Fevereiro')) THEN CONCAT(temp.AÑO,'02')
					WHEN temp.MES=LTRIM(RTRIM('MARZO')) THEN CONCAT(temp.AÑO,'03')
					WHEN temp.MES=LTRIM(RTRIM('MAR')) THEN CONCAT(temp.AÑO,'03')
					WHEN temp.MES=LTRIM(RTRIM('MARCH')) THEN CONCAT(temp.AÑO,'03')
					WHEN temp.MES=LTRIM(RTRIM('Março')) THEN CONCAT(temp.AÑO,'03')
					WHEN temp.MES=LTRIM(RTRIM('ABRIL')) THEN CONCAT(temp.AÑO,'04')
					WHEN temp.MES=LTRIM(RTRIM('ABR')) THEN CONCAT(temp.AÑO,'04')
					WHEN temp.MES=LTRIM(RTRIM('APRIL')) THEN CONCAT(temp.AÑO,'04')
					WHEN temp.MES=LTRIM(RTRIM('Abril')) THEN CONCAT(temp.AÑO,'04')
					WHEN temp.MES=LTRIM(RTRIM('MAYO')) THEN CONCAT(temp.AÑO,'05')
					WHEN temp.MES=LTRIM(RTRIM('MAY')) THEN CONCAT(temp.AÑO,'05')
					WHEN temp.MES=LTRIM(RTRIM('Maio')) THEN CONCAT(temp.AÑO,'05')
					WHEN temp.MES=LTRIM(RTRIM('JUNIO')) THEN CONCAT(temp.AÑO,'06')
					WHEN temp.MES=LTRIM(RTRIM('JUN')) THEN CONCAT(temp.AÑO,'06')
					WHEN temp.MES=LTRIM(RTRIM('JUNE')) THEN CONCAT(temp.AÑO,'06')
					WHEN temp.MES=LTRIM(RTRIM('Junho')) THEN CONCAT(temp.AÑO,'06')
					WHEN temp.MES=LTRIM(RTRIM('JULIO')) THEN CONCAT(temp.AÑO,'07')
					WHEN temp.MES=LTRIM(RTRIM('JUL')) THEN CONCAT(temp.AÑO,'07')
					WHEN temp.MES=LTRIM(RTRIM('JULY')) THEN CONCAT(temp.AÑO,'07')
					WHEN temp.MES=LTRIM(RTRIM('Julho')) THEN CONCAT(temp.AÑO,'07')
					WHEN temp.MES=LTRIM(RTRIM('AGOSTO')) THEN CONCAT(temp.AÑO,'08')
					WHEN temp.MES=LTRIM(RTRIM('AGO')) THEN CONCAT(temp.AÑO,'08')
					WHEN temp.MES=LTRIM(RTRIM('AUGUST')) THEN CONCAT(temp.AÑO,'08')
					WHEN temp.MES=LTRIM(RTRIM('Agosto')) THEN CONCAT(temp.AÑO,'08')
					WHEN temp.MES=LTRIM(RTRIM('SEPTIEMBRE')) THEN CONCAT(temp.AÑO,'09')
					WHEN temp.MES=LTRIM(RTRIM('SEP')) THEN CONCAT(temp.AÑO,'09')
					WHEN temp.MES=LTRIM(RTRIM('SEPTEMBER')) THEN CONCAT(temp.AÑO,'09')
					WHEN temp.MES=LTRIM(RTRIM('Setembro')) THEN CONCAT(temp.AÑO,'09')
					WHEN temp.MES=LTRIM(RTRIM('OCTUBRE')) THEN CONCAT(temp.AÑO,'10')
					WHEN temp.MES=LTRIM(RTRIM('OCT')) THEN CONCAT(temp.AÑO,'10')
					WHEN temp.MES=LTRIM(RTRIM('OCTOBER')) THEN CONCAT(temp.AÑO,'10')
					WHEN temp.MES=LTRIM(RTRIM('Outubro')) THEN CONCAT(temp.AÑO,'10')
					WHEN temp.MES=LTRIM(RTRIM('NOVIEMBRE')) THEN CONCAT(temp.AÑO,'11')
					WHEN temp.MES=LTRIM(RTRIM('NOV')) THEN CONCAT(temp.AÑO,'11')
					WHEN temp.MES=LTRIM(RTRIM('NOVEMBER')) THEN CONCAT(temp.AÑO,'11')
					WHEN temp.MES=LTRIM(RTRIM('Novembro')) THEN CONCAT(temp.AÑO,'11')
					WHEN temp.MES=LTRIM(RTRIM('DICIEMBRE')) THEN CONCAT(temp.AÑO,'12')
					WHEN temp.MES=LTRIM(RTRIM('DIC')) THEN CONCAT(temp.AÑO,'12')
					WHEN temp.MES=LTRIM(RTRIM('DECEMBER')) THEN CONCAT(temp.AÑO,'12')
					WHEN temp.MES=LTRIM(RTRIM('Dezembro')) THEN CONCAT(temp.AÑO,'12')
					END as AÑOMES
				,'' ---temp.LT_STD
				,temp.UBICACION
	FROM [temp].[NS_tblConsolidado_Temp] temp
		LEFT JOIN [comex].[NS_tblConsolidado] cons
			ON CONCAT(temp.SHIPMENT_REFERENCE,'-',temp.GROSS_WEIGHT) = CONCAT(cons.SHIPMENT_REFERENCE,'-',cons.GROSS_WEIGHT)
			--ON temp.SHIPMENT_REFERENCE = cons.SHIPMENT_REFERENCE AND temp.GROSS_WEIGHT = cons.GROSS_WEIGHT
	WHERE Pkid IS NULL


-----REGLAS DE NEGOCIO

--UBICACIÓN:NAC SOLO SE UTILIZAR PARA COSTOS LOGISTICOS (PRODUCT CATEGORY, CUSTOM EXPENSES, IMPORT DUTY)
--GUATEMALA, BRASIL, SMG
UPDATE [comex].[NS_tblConsolidado] SET C_TYPE='AIR' WHERE (C_TYPE='' OR C_TYPE IS NULL OR C_TYPE='-') AND MODAL IN ('AIR','AEREO','AÉREO')
--PARA GUATEMALA 2020 SE HACE ESTA EXCLUSION
UPDATE [comex].[NS_tblConsolidado] SET CUSTOM_CLEARANCE_DATE=SHIP_DATE WHERE COUNTRY='GUATEMALA' AND UBICACION<>'NAC' AND (SHIP_DATE='' OR SHIP_DATE IS NULL) 

--COMPAÑIA   
UPDATE [comex].[NS_tblConsolidado] SET COMPAÑIA='AVON' WHERE COUNTRY IN ('GUATEMALA','ECUADOR') AND (COMPAÑIA IS NULL OR COMPAÑIA='')

UPDATE [comex].[NS_tblConsolidado] SET COMPAÑIA='NATURA' WHERE COUNTRY='BRAZIL' AND DESTINATION_CITY LIKE '%NATURA%' AND (COMPAÑIA IS NULL OR COMPAÑIA='')
UPDATE [comex].[NS_tblConsolidado] SET COMPAÑIA='AVON' WHERE COUNTRY='BRAZIL' AND DESTINATION_CITY LIKE '%AVON%' AND (COMPAÑIA IS NULL OR COMPAÑIA='')

--ORIGIN_REGION
--SELECT * FROM [comex].[NS_tblConsolidado] WHERE ORIGIN_COUNTRY IN ('BRAZIL','BRASIL')
UPDATE [comex].[NS_tblConsolidado] SET ORIGIN_REGION='BRASIL' WHERE ORIGIN_COUNTRY IN ('BRAZIL','BRASIL') AND ORIGIN_REGION <>'BRASIL'

--COUNTRY
--UPDATE [comex].[NS_tblConsolidado] SET COUNTRY=DEST_COUNTRY WHERE COMPAÑIA='NATURA' AND DEST_COUNTRY IN ('COLOMBIA','PERU')


---ACTUALIZAR CAMPOS 
UPDATE T1 SET T1.ORIGIN_REGION=T2.Region
FROM [comex].[NS_tblConsolidado] T1 LEFT JOIN [maestros].[NS_tblOrigin_Country] T2 
ON T1.COUNTRY=T2.DescripcionEspanol OR T1.COUNTRY=T2.DescripcionPortugues
WHERE ORIGIN_REGION NOT IN ('APAC','LA SOUTH','US','EMEA','LA NORTH','BRASIL')

UPDATE [comex].[NS_tblConsolidado] SET COUNTRY=
REPLACE(REPLACE( /*vocales ÃÕ*/
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ÄËÏÖÜ*/
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ÂÊÎÔÛ*/
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ÀÈÌÒÙ*/
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ÁÉÍÓÚ*/
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE( /*vocales ñÑçÇ  incluido espacio en blanco*/ COUNTRY 
		,'ñ','n'),'Ñ','N'),'ç','c'),'Ç','C'),' ','')
		,'Á','A'),'É','E'),'Í','I'),'Ó','O'),'Ú','U') 
		,'À','A'),'È','E'),'Ì','I'),'Ò','O'),'Ù','U') 
		,'Â','A'),'Ê','E'),'Î','I'),'Ô','O'),'Û','U')
		,'Ä','A'),'Ë','E'),'Ï','I'),'Ö','O'),'Ü','U') 
		,'Ã','A'),'Õ','O')  

/*
SELECT T1.COUNTRY,T1.ORIGIN_REGION,T2.Region
FROM [comex].[NS_tblConsolidado] T1 LEFT JOIN [maestros].[NS_tblOrigin_Country] T2 
ON T1.COUNTRY=T2.DescripcionEspanol OR T1.COUNTRY=T2.DescripcionPortugues
WHERE ORIGIN_REGION NOT IN ('APAC','LA SOUTH','US','EMEA','LA NORTH','BRASIL')
*/

--SELECT * FROM [comex].[NS_tblConsolidado] WHERE COUNTRY='BRAZIL'

--SELECT * FROM [AVON_STAGING].[comex].[NS_tblConsolidado] WHERE FREIGHT_VALUE LIKE '#%'
--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET FREIGHT_VALUE=282 WHERE SHIPMENT_REFERENCE='IE-00610/2021'

--SELECT * FROM [comex].[NS_tblConsolidado] WHERE (SHIP_DATE='' OR SHIP_DATE IS NULL) AND UBICACION<>'NAC'

---ACTUALIZAR CAMPOS NULL
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET CNT_20_QTY=0 WHERE CNT_20_QTY IS NULL
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET CNT_40_QTY=0 WHERE CNT_40_QTY IS NULL
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET GROSS_WEIGHT=0 WHERE GROSS_WEIGHT IS NULL
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET M3=0 WHERE M3 IS NULL
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET PRODUCT_COST=0 WHERE PRODUCT_COST IS NULL
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET FREIGHT_VALUE=0 WHERE FREIGHT_VALUE IS NULL
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET IMPORT_DUTY=0 WHERE IMPORT_DUTY IS NULL

	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET QTY_PO=0 WHERE QTY_PO IS NULL
			
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET INTERNATIONAL_INSURANCE=0 WHERE INTERNATIONAL_INSURANCE IS NULL
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET CUSTOM_EXPENSES=0 WHERE CUSTOM_EXPENSES IS NULL
	--UPDATE [AVON_STAGING].[comex].[NS_tblConsolidado] SET INLAND_FREIGHT_DESP=0 WHERE INLAND_FREIGHT_DESP IS NULL
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

	---- Insertar registros nuevos en la tabla NS_tblCountry
	--INSERT INTO maestros.NS_tblCountry (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.COUNTRY))
		--	,LTRIM(RTRIM(temp.COUNTRY))
		--	,LTRIM(RTRIM(temp.COUNTRY))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblCountry country
		--	ON LTRIM(RTRIM(temp.COUNTRY)) = country.Codigo
	 --WHERE country.pkid IS NULL --and country.codigo <> temp.COUNTRY



 --   -- Insertar registros nuevos en la tabla NS_tblOrigin_Region
	--INSERT INTO maestros.NS_tblOrigin_Region (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.ORIGIN_REGION))
		--	,LTRIM(RTRIM(temp.ORIGIN_REGION))
		--	,LTRIM(RTRIM(temp.ORIGIN_REGION))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblOrigin_Region or_reg
		--	ON LTRIM(RTRIM(temp.ORIGIN_REGION)) = LTRIM(RTRIM(or_reg.Codigo))
	 --WHERE or_reg.pkid IS NULL and temp.ORIGIN_REGION IS NOT NULL and temp.ORIGIN_REGION<>'' and temp.ORIGIN_REGION<>'NA'  --and or_reg.codigo <> temp.ORIGIN_REGION


	---- Insertar registros nuevos en la tabla NS_tblOrigin_Country
	--INSERT INTO maestros.NS_tblOrigin_Country (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.ORIGIN_COUNTRY))
		--	,LTRIM(RTRIM(temp.ORIGIN_COUNTRY))
		--	,LTRIM(RTRIM(temp.ORIGIN_COUNTRY))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblOrigin_Country or_coun
		--	ON LTRIM(RTRIM(temp.ORIGIN_COUNTRY)) = LTRIM(RTRIM(or_coun.Codigo)) or LTRIM(RTRIM(temp.ORIGIN_COUNTRY)) = LTRIM(RTRIM(or_coun.DescripcionEspanol)) or LTRIM(RTRIM(temp.ORIGIN_COUNTRY)) = LTRIM(RTRIM(or_coun.DescripcionPortugues)) or LTRIM(RTRIM(temp.ORIGIN_COUNTRY)) = LTRIM(RTRIM(or_coun.Homologacion1)) or LTRIM(RTRIM(temp.ORIGIN_COUNTRY)) = LTRIM(RTRIM(or_coun.Homologacion2)) or LTRIM(RTRIM(temp.ORIGIN_COUNTRY)) = LTRIM(RTRIM(or_coun.Homologacion3))
	 --WHERE or_coun.pkid IS NULL --and or_coun.codigo <> temp.ORIGIN_COUNTRY



	-- -- Insertar registros nuevos en la tabla NS_tblModal
	--INSERT INTO maestros.NS_tblModal (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.MODAL))
		--	,LTRIM(RTRIM(temp.MODAL))
		--	,LTRIM(RTRIM(temp.MODAL))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblModal modal
		--	ON LTRIM(RTRIM(temp.MODAL)) = modal.Codigo or LTRIM(RTRIM(temp.MODAL)) = modal.DescripcionEspanol or LTRIM(RTRIM(temp.MODAL)) = modal.Homologacion1 or LTRIM(RTRIM(temp.MODAL)) = modal.Homologacion2
	 --WHERE modal.pkid IS NULL --and modal.codigo <> temp.MODAL


	-- -- Insertar registros nuevos en la tabla NS_tblOrigin_Port_Airport_Name
	--INSERT INTO maestros.NS_tblOrigin_Port_Airport_Name (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.ORIGIN_PORT_AIRPORT_NAME))
		--	,LTRIM(RTRIM(temp.ORIGIN_PORT_AIRPORT_NAME))
		--	,LTRIM(RTRIM(temp.ORIGIN_PORT_AIRPORT_NAME))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblOrigin_Port_Airport_Name or_port
		--	ON LTRIM(RTRIM(temp.ORIGIN_PORT_AIRPORT_NAME)) = LTRIM(RTRIM(or_port.Codigo))
	 --WHERE or_port.pkid IS NULL and temp.ORIGIN_PORT_AIRPORT_NAME IS NOT NULL and temp.ORIGIN_PORT_AIRPORT_NAME<>'' and temp.ORIGIN_PORT_AIRPORT_NAME<>'NA'  --and or_port.codigo <> temp.ORIGIN_PORT_AIRPORT_NAME
	 

	---- Insertar registros nuevos en la tabla NS_tblC_Type
	--INSERT INTO maestros.NS_tblC_Type (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.C_TYPE))
		--	,LTRIM(RTRIM(temp.C_TYPE))
		--	,LTRIM(RTRIM(temp.C_TYPE))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblC_Type c_type
		--	ON LTRIM(RTRIM(temp.C_TYPE)) = LTRIM(RTRIM(c_type.Codigo))
	 --WHERE c_type.pkid IS NULL and temp.C_TYPE IS NOT NULL and temp.C_TYPE<>'' and temp.C_TYPE<>'NA' --and c_type.codigo <> temp.C_TYPE


	-- -- Insertar registros nuevos en la tabla NS_tblFreight_Forwarder
	--INSERT INTO maestros.NS_tblFreight_Forwarder (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.FREIGHT_FORWARDER))
		--	,LTRIM(RTRIM(temp.FREIGHT_FORWARDER))
		--	,LTRIM(RTRIM(temp.FREIGHT_FORWARDER))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblFreight_Forwarder forwar
		--	ON  LTRIM(RTRIM(temp.FREIGHT_FORWARDER)) = LTRIM(RTRIM(forwar.Codigo)) or LTRIM(RTRIM(temp.FREIGHT_FORWARDER)) = LTRIM(RTRIM(forwar.DescripcionEspanol))
	 --WHERE forwar.pkid IS NULL and temp.FREIGHT_FORWARDER IS NOT NULL and temp.FREIGHT_FORWARDER<>'' and temp.FREIGHT_FORWARDER<>'NA'--and forwar.codigo <> temp.FREIGHT_FORWARDER


	-- -- Insertar registros nuevos en la tabla NS_tblSupplier  490+388
	--INSERT INTO maestros.NS_tblSupplier (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.SUPPLIER))
		--	,LTRIM(RTRIM(temp.SUPPLIER))
		--	,LTRIM(RTRIM(temp.SUPPLIER))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblSupplier supp
		--	ON LTRIM(RTRIM(temp.SUPPLIER)) = LTRIM(RTRIM(supp.Codigo)) -- ORDER BY LTRIM(RTRIM(temp.SUPPLIER))
	 --WHERE supp.pkid IS NULL --AND supp.codigo <> temp.SUPPLIER


	-- -- Insertar registros nuevos en la tabla NS_tblIncoterm
	--INSERT INTO maestros.NS_tblIncoterm (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.INCOTERM))
		--	,LTRIM(RTRIM(temp.INCOTERM))
		--	,LTRIM(RTRIM(temp.INCOTERM))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblIncoterm inc
		--	ON  LTRIM(RTRIM(temp.INCOTERM)) = LTRIM(RTRIM(inc.Codigo))
	 --WHERE inc.pkid IS NULL --and inc.codigo <> temp.INCOTERM


	-- 	 -- Insertar registros nuevos en la tabla NS_tblCategory
	--INSERT INTO maestros.NS_tblCategory (
	--		Codigo,
	--		DescripcionEspanol,
	--		DescripcionPortugues
	--)
	 --SELECT DISTINCT 
		--	LTRIM(RTRIM(temp.PRODUCT_CATEGORY))
		--	,LTRIM(RTRIM(temp.PRODUCT_CATEGORY))
		--	,LTRIM(RTRIM(temp.PRODUCT_CATEGORY))
	 -- FROM comex.NS_tblConsolidado temp
		--LEFT JOIN maestros.NS_tblCategory inc
		--	ON  LTRIM(RTRIM(temp.PRODUCT_CATEGORY)) = LTRIM(RTRIM(inc.Codigo))
	 --WHERE inc.pkid IS NULL 

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

	-- Actualizar registros en la tabla NS_tblDivision que hayan cambiado en la fuente de datos(DIVISION)
	--UPDATE div
	--   SET div.Descripcion = temp.Descripcion
	--  FROM maestros.NS_tblDivision div
	--	INNER JOIN temp.NS_tblDivision_Temp temp
	--		ON div.Codigo = temp.Codigo
	-- WHERE ISNULL(div.Descripcion,' ') <> ISNULL(temp.Descripcion,' ')
	   
	------------------------------------------------------------------------
	-- PASO 3: CARGAR EN LA DIMENSION
	------------------------------------------------------------------------

	---- Insertar registros nuevos en la tabla DimCountry
	INSERT INTO AVON_DW.dimensiones.DimCountry(
			Pkid
			,Codigo
			,DescripcionEspanol
			,DescripcionPortugues
			,Cluster
	)
	  SELECT country.Pkid
			,country.Codigo
		    ,country.DescripcionEspanol
			,country.DescripcionPortugues
			,country.Cluster
	    FROM maestros.NS_tblCountry country
			LEFT JOIN AVON_DW.dimensiones.DimCountry dim
				ON country.Codigo = dim.Codigo
	   WHERE dim.Pkid IS NULL


	---- Insertar registros nuevos en la tabla DimOrigin_Region
	INSERT INTO AVON_DW.dimensiones.DimOrigin_Region(
			Pkid
			,Codigo
			,DescripcionEspanol
			,DescripcionPortugues
	)
	  SELECT or_reg.Pkid
			,or_reg.Codigo
		    ,or_reg.DescripcionEspanol
			,or_reg.DescripcionPortugues
	    FROM maestros.NS_tblOrigin_Region or_reg
			LEFT JOIN AVON_DW.dimensiones.DimOrigin_Region dim
				ON or_reg.Codigo = dim.Codigo
	   WHERE dim.Pkid IS NULL


	---- Insertar registros nuevos en la tabla DimOrigin_Country
	INSERT INTO AVON_DW.dimensiones.DimOrigin_Country(
			 Pkid
			,Codigo
			,DescripcionEspanol
			,DescripcionPortugues
			,Homologacion1
			,Homologacion2
			,Homologacion3
			,Homologacion4
			,Homologacion5
			,Region
	)
	  SELECT or_coun.Pkid
			,or_coun.Codigo
		    ,or_coun.DescripcionEspanol
			,or_coun.DescripcionPortugues
			,or_coun.Homologacion1
			,or_coun.Homologacion2
			,or_coun.Homologacion3
			,or_coun.Homologacion4
			,or_coun.Homologacion5
			,or_coun.Region
	    FROM maestros.NS_tblOrigin_Country or_coun
			LEFT JOIN AVON_DW.dimensiones.DimOrigin_Country dim
				ON or_coun.Codigo = dim.Codigo
	   WHERE dim.Pkid IS NULL


	---- Insertar registros nuevos en la tabla DimModal
	INSERT INTO AVON_DW.dimensiones.DimModal(
			 Pkid
			,Codigo
			,DescripcionEspanol
			,DescripcionPortugues
			,Homologacion1
			,Homologacion2
	)
	  SELECT modal.Pkid
			,modal.Codigo
		    ,modal.DescripcionEspanol
			,modal.DescripcionPortugues
			,modal.Homologacion1
			,modal.Homologacion2
	    FROM maestros.NS_tblModal modal
			LEFT JOIN AVON_DW.dimensiones.DimModal dim
				ON modal.Codigo = dim.Codigo
	   WHERE dim.Pkid IS NULL


	---- Insertar registros nuevos en la tabla DimOrigin_Port_Airport_Name
	INSERT INTO AVON_DW.dimensiones.DimOrigin_Port_Airport_Name (
			 Pkid
			,Codigo
			,DescripcionEspanol
			,DescripcionPortugues
	)
	 SELECT  or_port.Pkid
			,or_port.Codigo
			,or_port.DescripcionEspanol
			,or_port.DescripcionPortugues
	  FROM maestros.NS_tblOrigin_Port_Airport_Name or_port
		LEFT JOIN AVON_DW.dimensiones.DimOrigin_Port_Airport_Name dim
			ON or_port.Codigo = dim.Codigo
	 WHERE dim.pkid IS NULL
	 

	---- Insertar registros nuevos en la tabla DimC_Type
	INSERT INTO AVON_DW.dimensiones.DimC_Type (
			 Pkid
			,Codigo
			,DescripcionEspanol
			,DescripcionPortugues
	)
	 SELECT	 c_type.Pkid
			,c_type.Codigo
			,c_type.DescripcionEspanol
			,c_type.DescripcionPortugues
	  FROM maestros.NS_tblC_Type c_type
		LEFT JOIN AVON_DW.dimensiones.DimC_Type dim 
			ON c_type.Codigo = dim.Codigo
	 WHERE dim.pkid IS NULL


	-- -- Insertar registros nuevos en la tabla DimFreight_Forwarder
	INSERT INTO AVON_DW.dimensiones.DimFreight_Forwarder (
			 Pkid
			,Codigo
			,DescripcionEspanol
			,DescripcionPortugues
	)
	 SELECT	 forwar.Pkid
			,forwar.Codigo
			,forwar.DescripcionEspanol
			,forwar.DescripcionPortugues
	  FROM maestros.NS_tblFreight_Forwarder forwar
		LEFT JOIN AVON_DW.dimensiones.DimFreight_Forwarder dim
			ON forwar.Codigo = dim.Codigo
	 WHERE dim.pkid IS NULL


	-- -- Insertar registros nuevos en la tabla DimSupplier
	INSERT INTO AVON_DW.dimensiones.DimSupplier (
			 Pkid
			,Codigo
			,DescripcionEspanol
			,DescripcionPortugues
	)
	 SELECT  supp.Pkid
			,supp.Codigo
			,supp.DescripcionEspanol
			,supp.DescripcionPortugues
	  FROM maestros.NS_tblSupplier supp
		LEFT JOIN AVON_DW.dimensiones.DimSupplier dim
			ON supp.Codigo = dim.Codigo
	 WHERE dim.pkid IS NULL


	-- -- Insertar registros nuevos en la tabla DimIncoterm
	INSERT INTO AVON_DW.dimensiones.DimIncoterm (
			 Pkid
			,Codigo
			,DescripcionEspanol
			,DescripcionPortugues
	)
	 SELECT  inc.Pkid
			,inc.Codigo
			,inc.DescripcionEspanol
			,inc.DescripcionPortugues
	  FROM maestros.NS_tblIncoterm inc
		LEFT JOIN AVON_DW.dimensiones.DimIncoterm dim
			ON inc.Codigo = dim.Codigo
	 WHERE dim.pkid IS NULL

	-- -- Insertar registros nuevos en la tabla DimCategory
	INSERT INTO AVON_DW.dimensiones.DimCategory (
			Pkid,
			Codigo,
			DescripcionEspanol,
			DescripcionPortugues
	)
	 SELECT  cat.Pkid
			,cat.Codigo
			,cat.DescripcionEspanol
			,cat.DescripcionPortugues
	  FROM maestros.NS_tblCategory cat
		LEFT JOIN AVON_DW.dimensiones.DimCategory dim
			ON cat.Codigo = dim.Codigo
	 WHERE dim.pkid IS NULL


----------------------------------------------------
-----------------------------------------------------

	-- Insertar registros nuevos en la tabla DimCol
	--INSERT INTO AVON_DW.dimensiones.DimCol(
	--		 Codigo
	--		,DescripcionEsp
	--		,DescripcionIng
	--)
	--  SELECT or_reg.Codigo
	--	    ,or_reg.DescripcionEsp
	--		,or_reg.DescripcionIng
	--    FROM maestros.NS_tblOrigin_Region or_reg
	--		LEFT JOIN AVON_DW.dimensiones.DimOrigin_Region dim
	--			ON or_reg.Codigo = dim.Codigo
	--   WHERE dim.Pkid IS NULL


	-- Actualizar registros en DimDivision que hayan cambiado en la fuente de datos(NS_tblDivision)
	--UPDATE dim
	--   SET dim.Descripcion = div.Descripcion
	--  FROM PROTELA_DW.dimensiones.DimDivision dim 
	--	INNER JOIN maestros.NS_tblDivision div
	--		ON dim.Codigo = div.Codigo
	-- WHERE ISNULL(dim.Descripcion,' ') <> ISNULL(div.Descripcion,' ')



END

GO

