-- =============================================
-- Author:		JHONY MARTÍNEZ Y VALENTINA
-- Create date: 02/12/2021
-- Description:	Procedimiento almacenado utilizado para la carga incremental del 
--				consolidado de CPE en la tabla de hechos.
--				La fuente de datos de esta carga es la vista XXX
--EXEC NS_spCargaConsolidado
-- =============================================
CREATE PROCEDURE [dbo].[NS_spCargaConsolidado_3]
	
AS
BEGIN


		-- Insertar registros nuevos en la tabla FactVentas
		-- El PkId en la tabla de hechos será el mismo de la tabla ventas.NS_tblVentas

		-- La información del presupuesto solo tiene Calidad 1 y 2, por ese motivo
		-- se realiza la equivalencia contra ventas:
		-- Presupuesto Calidad 1 es igual a Calidad 1 en NOW (Ventas)
		-- Presupuesto Calidad 2 es igual a Calidad 0, 2 y 3 en NOW (Ventas) --4.298  

		----DELETE FROM AVON_DW.hechos.Consolidado

		--FALTA ORGANIZAR LA FECHA CON EL DIA 01

		INSERT INTO AVON_DW.hechos.Consolidado (
			Pkid
			,COMPAÑIA
			--,AÑO
			--,IMP_EXP
			--,MES
			,SHIPMENT_REFERENCE
			,idCountry
			--,COUNTRY
			,idOriginRegion
			--,ORIGIN_REGION
			,idOriginCountry
			--,ORIGIN_COUNTRY
			--,ORIGIN_CITY_PICK_UP
			,idOriginPort
			--,ORIGIN_PORT_AIRPORT_NAME
			--,DEST_COUNTRY
			--,DESTINATION_CITY
			--,DEST_PORT_AIRPORT_NAME
			,idModal
			--,MODAL
			,idType
			--,C_TYPE
			,idFreight
			--,FREIGHT_FORWARDER
			,idSupplier
			--,SUPPLIER
			,IdIncoterm
			--,INCOTERM
			,IdCategory
			,idFechaPick
			,idFechaShip
			,idFechaArri
			,idFechaCust
			,idFechaRece

			,CNT_20_QTY
			,CNT_40_QTY
			,GROSS_WEIGHT
			,M3
	
			,PRODUCT_COST
			,FREIGHT_VALUE
			,IMPORT_DUTY

			,QTY_PO
			--,PRODUCT_CATEGORY
			,INTERNATIONAL_INSURANCE
			,CUSTOM_EXPENSES
			,INLAND_FREIGHT_DESP
			--,INLAND_TRANSPORT_COMPANY
			,DANGEROUS_GOOD
			,SPOT_SHIPMENT
			,AÑOMES
			,FECHA
			,LT_STD
			,LT_REAL
			,UBICACION
			)
		SELECT 
			 cons.Pkid
			 ,cons.COMPAÑIA
			--,cons.AÑO
			--,cons.IMP_EXP
			--,cons.MES
			,cons.SHIPMENT_REFERENCE
			,country.Pkid
			--,country.Codigo
			--,cons.COUNTRY
			,reg.Pkid
			--,reg.Codigo
			--,cons.ORIGIN_REGION
			,coun.Pkid
			--,coun.Codigo
			--,cons.ORIGIN_COUNTRY
			--,cons.ORIGIN_CITY_PICK_UP
			,airport.Pkid
			--,airport.Codigo
			--,cons.ORIGIN_PORT_AIRPORT_NAME
			--,cons.DEST_COUNTRY------------------------COUNTRY
 			--,cons.DESTINATION_CITY
			--,cons.DEST_PORT_AIRPORT_NAME
			,modal.Pkid
			--,modal.Codigo
			--,cons.MODAL
			,c_type.Pkid
			--,c_type.Codigo
			--,cons.C_TYPE

			,forw.Pkid
			--,forw.Codigo
			--,cons.FREIGHT_FORWARDER
			,supp.Pkid
			--,supp.Codigo
			--,cons.SUPPLIER
			,inc.Pkid
			--,inc.Codigo
			--,cons.INCOTERM
			,cat.Pkid
			--,cons.PRODUCT_CATEGORY

			,tiempo_pick.idfecha
			--,cons.PICK_UP_DATE
			,tiempo_ship.idfecha
			--,cons.SHIP_DATE
			,tiempo_arri.idfecha
			--,cons.ARRIVAL_DATE
			,tiempo_cust.idfecha
			--,cons.CUSTOM_CLEARANCE_DATE
			,tiempo_rece.idfecha
			--,cons.AVON_RECEIPT

			,CAST(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.CNT_20_QTY)),'.',''),',','.'),'-','') AS FLOAT)
			,CAST(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.CNT_40_QTY)),'.',''),',','.'),'-','') AS FLOAT)
			,CAST(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.GROSS_WEIGHT)),'.',''),',','.'),'-','') AS FLOAT) AS GROSS_WEIGHT
			,CAST(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.M3)),'.',''),',','.'),'-','') AS FLOAT)
			,CAST(REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.PRODUCT_COST)),'$',''),'.',''),',','.'),'-','') AS FLOAT)
			,CAST(REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.FREIGHT_VALUE)),'$',''),'.',''),',','.'),'-','') AS FLOAT)
			,CAST(REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.IMPORT_DUTY)),'$',''),'.',''),',','.'),'-','') AS FLOAT)

			,CAST(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.QTY_PO)),'.',''),',','.'),'-','') AS FLOAT)
			
			--,cons.PRODUCT_CATEGORY
			
			,CAST(REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.INTERNATIONAL_INSURANCE)),'$',''),'.',''),',','.'),'-','') AS FLOAT)
			,CAST(REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.CUSTOM_EXPENSES)),'$',''),'.',''),',','.'),'-','') AS FLOAT)
			,CAST(REPLACE(REPLACE(REPLACE(REPLACE(RTRIM(LTRIM(cons.INLAND_FREIGHT_DESP)),'$',''),'.',''),',','.'),'-','') AS FLOAT)
			
			--,cons.INLAND_TRANSPORT_COMPANY

			,cons.DANGEROUS_GOOD
			,cons.SPOT_SHIPMENT
			,cons.AñoMes
			,CONCAT(cons.AñoMes,'01') AS FECHA
			--,LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(cons.LT_STD,'NO APLICA',''),'#N/A',''),'#NAME?',''))) AS LT_STD
			,cons.LT_STD
			,DATEDIFF(day, cast(cons.PICK_UP_DATE as date) , cast(AVON_RECEIPT as date)) as LT_REAL
			,cons.UBICACION
		FROM [comex].[NS_tblConsolidado] cons
			LEFT JOIN AVON_DW.hechos.Consolidado hechos
				ON cons.Pkid = hechos.Pkid
				--ON LTRIM(RTRIM(CONCAT(cons.SHIPMENT_REFERENCE,'-',cons.GROSS_WEIGHT))) = LTRIM(RTRIM(CONCAT(hechos.SHIPMENT_REFERENCE,'-',hechos.GROSS_WEIGHT))) --OR LTRIM(RTRIM(cons.M3)) = LTRIM(RTRIM(hechos.M3))
			LEFT JOIN AVON_DW.dimensiones.DimCountry country
				ON LTRIM(RTRIM(cons.COUNTRY)) = LTRIM(RTRIM(country.Codigo)) OR LTRIM(RTRIM(cons.COUNTRY)) = LTRIM(RTRIM(country.DescripcionEspanol)) OR LTRIM(RTRIM(cons.COUNTRY)) = LTRIM(RTRIM(country.DescripcionPortugues))
			LEFT JOIN AVON_DW.dimensiones.DimOrigin_Region reg
				ON LTRIM(RTRIM(cons.ORIGIN_REGION)) = LTRIM(RTRIM(Reg.Codigo)) 
			LEFT JOIN AVON_DW.dimensiones.DimOrigin_Country coun
				ON LTRIM(RTRIM(cons.ORIGIN_COUNTRY)) = LTRIM(RTRIM(coun.Codigo)) OR LTRIM(RTRIM(cons.ORIGIN_COUNTRY)) = LTRIM(RTRIM(coun.DescripcionEspanol)) OR LTRIM(RTRIM(cons.ORIGIN_COUNTRY)) = LTRIM(RTRIM(coun.DescripcionPortugues)) OR LTRIM(RTRIM(cons.ORIGIN_COUNTRY)) = LTRIM(RTRIM(coun.Homologacion1))  OR LTRIM(RTRIM(cons.ORIGIN_COUNTRY)) = LTRIM(RTRIM(coun.Homologacion2)) OR LTRIM(RTRIM(cons.ORIGIN_COUNTRY)) = LTRIM(RTRIM(coun.Homologacion3))
			LEFT JOIN AVON_DW.dimensiones.DimOrigin_Port_Airport_Name airport
				ON LTRIM(RTRIM(cons.ORIGIN_PORT_AIRPORT_NAME)) = LTRIM(RTRIM(airport.Codigo))
			LEFT JOIN AVON_DW.dimensiones.DimModal modal
				ON LTRIM(RTRIM(cons.MODAL)) = LTRIM(RTRIM(modal.Codigo)) or LTRIM(RTRIM(cons.MODAL)) = LTRIM(RTRIM(modal.DescripcionEspanol)) or LTRIM(RTRIM(cons.MODAL)) = LTRIM(RTRIM(modal.Homologacion1)) or LTRIM(RTRIM(cons.MODAL)) = LTRIM(RTRIM(modal.Homologacion2))
			LEFT JOIN AVON_DW.dimensiones.DimC_Type c_type
				ON LTRIM(RTRIM(cons.C_TYPE)) = LTRIM(RTRIM(c_type.Codigo))
			LEFT JOIN AVON_DW.dimensiones.DimFreight_Forwarder forw
				ON LTRIM(RTRIM(cons.FREIGHT_FORWARDER)) = LTRIM(RTRIM(forw.Codigo)) --OR LTRIM(RTRIM(cons.FREIGHT_FORWARDER)) = LTRIM(RTRIM(forw.DescripcionEspanol))
			LEFT JOIN AVON_DW.dimensiones.DimSupplier supp
				ON LTRIM(RTRIM(cons.SUPPLIER)) = LTRIM(RTRIM(supp.Codigo))
			LEFT JOIN AVON_DW.dimensiones.DimIncoterm inc
				ON LTRIM(RTRIM(cons.INCOTERM)) = LTRIM(RTRIM(inc.Codigo))
			LEFT JOIN AVON_DW.dimensiones.DimCategory cat
				ON LTRIM(RTRIM(cons.PRODUCT_CATEGORY)) = LTRIM(RTRIM(cat.Codigo))
			LEFT JOIN AVON_DW.dimensiones.DimTiempo tiempo_pick
				ON cons.PICK_UP_DATE = tiempo_pick.fechacompleta
			LEFT JOIN AVON_DW.dimensiones.DimTiempo tiempo_ship
				ON cons.SHIP_DATE = tiempo_ship.fechacompleta
			LEFT JOIN AVON_DW.dimensiones.DimTiempo tiempo_arri
				ON cons.ARRIVAL_DATE = tiempo_arri.fechacompleta
			LEFT JOIN AVON_DW.dimensiones.DimTiempo tiempo_cust
				ON cons.CUSTOM_CLEARANCE_DATE = tiempo_cust.fechacompleta
			LEFT JOIN AVON_DW.dimensiones.DimTiempo tiempo_rece
				ON cons.AVON_RECEIPT = tiempo_rece.fechacompleta --WHERE cons.pkid='1587' ORDER BY cons.PKID 
		WHERE hechos.Pkid is null --AND cons.Pkid<>'12303'
		--AND cons.COUNTRY NOT IN ('MÉXICO','MEXICO','GUATEMALA')       --NOLA   13973   X
		--AND cons.DEST_COUNTRY IN ('PERU','COLOMBIA','ECUADOR')      --CPE    14742
		--AND cons.DEST_COUNTRY IN ('BRASIL','BRAZIL')                --BRASIL  3641
		--AND cons.DEST_COUNTRY IN ('ARGENTINA','CHILE','URUGUAY')    --SMG     8546
		--AND cons.DEST_COUNTRY IN ('ARGENTINA','CHILE','URUGUAY') --8203  INLAND NO PASA
		--AND cons.DEST_COUNTRY IN ('PERU','COLOMBIA','ECUADOR','GUATEMALA','MEXICO','MÉXICO','BRASIL','BRAZIL','ARGENTINA','CHILE','URUGUAY') --39313
		
		--PKID 31069 BRAZIL 2020 JANEIRO DOBLE, 31098 BRAZIL 2020 SETEMBRO  --> REPETIDOS


		--WHERE LTRIM(RTRIM(CONCAT(hechos.SHIPMENT_REFERENCE,'-',hechos.GROSS_WEIGHT))) is null AND cons.Pkid<>'12303'
		--AND cons.COUNTRY IN ('MEXICO','GUATEMALA') AND cons.Pkid<>'12303'

--		TRUNCATE TABLE AVON_DW.[hechos].[Consolidado]

	
END

GO

