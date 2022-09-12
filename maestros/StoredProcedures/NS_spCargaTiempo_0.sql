
-- =========================================================================
-- Proyecto:	PROTELA (Cubos BI)
-- Autor:		Jhony Martinez y Valentina Molina - Newsoft S.A.S.
-- Fecha:		2021/12/03
-- Descripcion:	Procedimiento para la carga de tabla NS_tblTiempo y DimTiempo
-- USO:			EXEC maestros.NS_spCargaTiempo '2022-01-01', '2022-12-31'
-- =========================================================================
-- Historial de cambios realizados
-- <aaaa/mm/dd> - <nombre consultor>
-- <descripcion del cambio>
-- =========================================================================
CREATE PROCEDURE [maestros].[NS_spCargaTiempo_0]  
	@FechaI date, 
	@FechaF date 
AS
BEGIN

	DECLARE @fechaaux datetime

	--select getdate(), '1'+ RIGHT(CAST(year(getdate()) AS VARCHAR),2) + CAST(DATEPART(dayofyear,getdate()) AS VARCHAR)

	DELETE maestros.NS_tblTiempo
	WHERE fechacompleta BETWEEN @FechaI AND @FechaF

	DELETE AVON_DW.dimensiones.DimTiempo
	WHERE fechacompleta BETWEEN @FechaI AND @FechaF

	SET @fechaaux=CONVERT(DATETIME,@FechaI,108)

	-- Para que el nombre del mes se recupere en idioma Español
	SET LANGUAGE Spanish;

	WHILE @fechaaux <= @fechaF BEGIN
		PRINT 'inicio'
		--
		INSERT INTO maestros.NS_tblTiempo (IdFecha
											  ,FechaCompleta
											  ,Semana
											  ,Mes
											  ,Bimestre
											  ,Trimestre
											  ,Semestre
											  ,Año
											  ,Dia
											  ,NMes
											  ,NSemestre
											  ,NTrimestre
											  )
		SELECT CONVERT(varchar,@fechaaux,112) as IdFecha
			  ,@fechaaux as FechaCompleta
			  ,DATEPART(WEEK,@fechaaux) as Semana
			  ,MONTH(@fechaaux) as Mes
			  ,CASE month(@fechaaux) WHEN 1 THEN 1
									 WHEN 2 THEN 1
									 WHEN 3 THEN 2
									 WHEN 4 THEN 2
									 WHEN 5 THEN 3
									 WHEN 6 THEN 3
									 WHEN 7 THEN 4
									 WHEN 8 THEN 4
									 WHEN 9 THEN 5
									 WHEN 10 THEN 5
									 WHEN 11 THEN 6 
									 WHEN 12 THEN 6
									 END as Bimestre
			  ,CASE WHEN MONTH(@fechaaux)<=3 THEN 1
					WHEN MONTH(@fechaaux)>=4 AND MONTH(@fechaaux)<=6 THEN 2
					WHEN MONTH(@fechaaux)>=7 AND MONTH(@fechaaux)<=9 THEN 3
					ELSE 4 END as Trimestre
			  ,CASE WHEN MONTH(@fechaaux)<=6 THEN 1
					ELSE 2 END as Semestre
			  ,YEAR(@fechaaux) as Año
			  ,DAY(@fechaaux) as Dia
			  ,DATENAME(MONTH,@fechaaux) as NMes
			  ,CASE WHEN MONTH(@fechaaux)<=6 THEN 'Semestre 1 de ' + cast(YEAR(@fechaaux) AS varchar)
					ELSE 'Semestre 2 de ' + cast(YEAR(@fechaaux) AS varchar) END as NSemestre
			  ,CASE WHEN MONTH(@fechaaux)<=3 THEN 'Trimestre 1 de ' + cast(YEAR(@fechaaux) AS varchar)
					WHEN MONTH(@fechaaux)>=4 AND MONTH(@fechaaux)<=6 THEN 'Trimestre 2 de ' + cast(YEAR(@fechaaux) AS varchar)
					WHEN MONTH(@fechaaux)>=7 AND MONTH(@fechaaux)<=9 THEN 'Trimestre 3 de ' + cast(YEAR(@fechaaux) AS varchar)
					ELSE 'Trimestre 4 de ' + cast(YEAR(@fechaaux) AS varchar) END as NTrimestre

		--Incrementa la fecha en 1 día			                
		SET @fechaaux = DATEADD(day,1,@fechaaux)

	END -- Fin WHILE
 
	INSERT INTO AVON_DW.dimensiones.DimTiempo
		(  IdFecha
		  ,FechaCompleta
		  ,Semana
		  ,Mes
		  ,Bimestre
		  ,Trimestre
		  ,Semestre
		  ,Año
		  ,Dia
		  ,NMes
		  ,NMesCorto    ---para la visualizacion en Dashboard
		  ,NSemestre
		  ,NTrimestre
		  ,AñoMes)
	SELECT IdFecha
		  ,FechaCompleta
		  ,Semana
		  ,Mes
		  ,Bimestre
		  ,Trimestre
		  ,Semestre
		  ,Año
		  ,Dia
		  ,NMes
		  ,UPPER(SUBSTRING(NMes,1,3))
		  ,NSemestre
		  ,NTrimestre
		  ,CONCAT(Año,Mes)
	FROM maestros.NS_tblTiempo
	WHERE fechacompleta BETWEEN @FechaI AND @FechaF

	--TRUNCATE TABLE AVON_STAGING.maestros.NS_tblTiempo
	--TRUNCATE TABLE AVON_DW.dimensiones.DimTiempo

	 -- Insertar registros nuevos en la tabla DimAñoMes
	INSERT INTO AVON_DW.dimensiones.DimAñoMes (
			 Pkid
			,AñoMes
	)
	 SELECT  añomes.Pkid
			,añomes.AñoMes
	  FROM maestros.NS_tblAñoMes añomes
		LEFT JOIN AVON_DW.dimensiones.DimAñoMes dim
			ON añomes.Pkid = dim.Pkid
	 WHERE dim.pkid IS NULL

END

GO

