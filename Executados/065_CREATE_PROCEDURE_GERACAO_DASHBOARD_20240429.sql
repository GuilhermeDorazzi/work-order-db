DROP PROCEDURE IF EXISTS sp_geracao_automatica_dashboard;
--
DELIMITER //

CREATE PROCEDURE sp_geracao_automatica_dashboard()
BEGIN
--
SET SQL_SAFE_UPDATES  = 0;
--
DELETE FROM tb_dashboard_mes;
--
INSERT INTO tb_dashboard_mes
SELECT 
		OD.COD_EMPRESA, 
        OD.COD_FILIAL, 
		MONTH(OD.DATA_AGEND) AS MES,
        SUM((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) AS TOTAL_RECEBIDO,
        SUM(((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FID) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FDR) + ((ifnull(JO.QTD2, JO.QTD)) * (JO.VALOR_REP - JO.VALOR_DESC))) AS TOTAL_PAGO,
        SUM(CASE 
				WHEN TP.DESCRICAO = 'Debit' AND JO.VALOR_PAG < 0 AND JO.VALOR_REC = 0 THEN
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG * -1)
				WHEN JO.VALOR_PAG < 0 THEN
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) - ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG * -1)
				ELSE 
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) - (((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FID) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FDR) + ((ifnull(JO.QTD2, JO.QTD)) * (JO.VALOR_REP - JO.VALOR_DESC)))
				END
	    ) AS TOTAL_LUCRO        
 FROM tb_ordem AS OD
 JOIN tb_jobs_ordem AS JO
   ON JO.COD_EMPRESA = OD.COD_EMPRESA
  AND JO.ID_ORDEM = OD.ID_ORDEM
 JOIN tb_job AS JB
   ON JB.COD_EMPRESA = JO.COD_EMPRESA
  AND JB.COD_JOB = JO.COD_JOB
 JOIN TB_TIPO_ORDEM AS TP
   ON TP.COD_EMPRESA = OD.COD_EMPRESA
 AND TP.COD_TIPO_ORDEM = OD.COD_TIPO_ORDEM
WHERE STATUS = 'Finished' 
  AND DATA_AGEND >= DATE_SUB(CURRENT_DATE(), INTERVAL 12 MONTH)
  GROUP BY OD.COD_EMPRESA, OD.COD_FILIAL, MES;
--
DELETE FROM tb_dashboard_tech;
--
INSERT INTO tb_dashboard_tech
SELECT 
		OD.COD_EMPRESA, 
        OD.COD_FILIAL,
		OD.COD_USUARIO,
        concat(US.COD_TECH, '-', US.NOM_USUARIO) AS NOM_USUARIO,
		MONTH(OD.DATA_AGEND) AS MES,
        SUM((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) AS TOTAL_RECEBIDO,
        SUM(((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FID) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FDR) + ((ifnull(JO.QTD2, JO.QTD)) * (JO.VALOR_REP - JO.VALOR_DESC))) AS TOTAL_PAGO,
        SUM(CASE 
				WHEN TP.DESCRICAO = 'Debit' AND JO.VALOR_PAG < 0 AND JO.VALOR_REC = 0 THEN
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG * -1)
				WHEN JO.VALOR_PAG < 0 THEN
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) - ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG * -1)
				ELSE 
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) - (((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FID) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FDR) + ((ifnull(JO.QTD2, JO.QTD)) * (JO.VALOR_REP - JO.VALOR_DESC)))
				END
	    ) AS TOTAL_LUCRO        
 FROM tb_ordem AS OD
  JOIN tb_usuarios AS US
   ON US.COD_EMPRESA = OD.COD_EMPRESA
  AND US.COD_USUARIO = OD.COD_USUARIO
 JOIN tb_jobs_ordem AS JO
   ON JO.COD_EMPRESA = OD.COD_EMPRESA
  AND JO.ID_ORDEM = OD.ID_ORDEM
 JOIN tb_job AS JB
   ON JB.COD_EMPRESA = JO.COD_EMPRESA
  AND JB.COD_JOB = JO.COD_JOB
 JOIN TB_TIPO_ORDEM AS TP
   ON TP.COD_EMPRESA = OD.COD_EMPRESA
 AND TP.COD_TIPO_ORDEM = OD.COD_TIPO_ORDEM
WHERE STATUS = 'Finished' 
  AND DATA_AGEND >= DATE_SUB(CURRENT_DATE(), INTERVAL 12 MONTH)
  GROUP BY OD.COD_EMPRESA, OD.COD_FILIAL, COD_USUARIO, MES;
--
DELETE FROM tb_dashboard_filial;
--
INSERT INTO tb_dashboard_filial
SELECT 
		OD.COD_EMPRESA, 
        OD.COD_FILIAL,
		FL.NOM_FILIAL,
        SUM((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) AS TOTAL_RECEBIDO,
        SUM(((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FID) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FDR) + ((ifnull(JO.QTD2, JO.QTD)) * (JO.VALOR_REP - JO.VALOR_DESC))) AS TOTAL_PAGO,
        SUM(CASE 
				WHEN TP.DESCRICAO = 'Debit' AND JO.VALOR_PAG < 0 AND JO.VALOR_REC = 0 THEN
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG * -1)
				WHEN JO.VALOR_PAG < 0 THEN
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) - ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG * -1)
				ELSE 
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) - (((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FID) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FDR) + ((ifnull(JO.QTD2, JO.QTD)) * (JO.VALOR_REP - JO.VALOR_DESC)))
				END
	    ) AS TOTAL_LUCRO        
 FROM tb_ordem AS OD
  JOIN tb_filial AS FL
   ON FL.COD_EMPRESA = OD.COD_EMPRESA
  AND FL.COD_FILIAL = OD.COD_FILIAL
 JOIN tb_jobs_ordem AS JO
   ON JO.COD_EMPRESA = OD.COD_EMPRESA
  AND JO.ID_ORDEM = OD.ID_ORDEM
 JOIN tb_job AS JB
   ON JB.COD_EMPRESA = JO.COD_EMPRESA
  AND JB.COD_JOB = JO.COD_JOB
 JOIN TB_TIPO_ORDEM AS TP
   ON TP.COD_EMPRESA = OD.COD_EMPRESA
 AND TP.COD_TIPO_ORDEM = OD.COD_TIPO_ORDEM
WHERE STATUS = 'Finished' 
  AND DATA_AGEND >= DATE_SUB(CURRENT_DATE(), INTERVAL 12 MONTH)
  GROUP BY OD.COD_EMPRESA, OD.COD_FILIAL;
--
--
DELETE FROM tb_dashboard_job;
--
INSERT INTO tb_dashboard_job
SELECT 
		OD.COD_EMPRESA, 
        OD.COD_FILIAL,
		JO.COD_JOB,
        MONTH(OD.DATA_AGEND) AS MES,
        JB.CODE AS NOM_JOB,
		SUM(ifnull(JO.QTD2, JO.QTD)) AS QTD, 
        SUM((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) AS TOTAL_RECEBIDO,
        SUM(((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FID) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FDR) + ((ifnull(JO.QTD2, JO.QTD)) * (JO.VALOR_REP - JO.VALOR_DESC))) AS TOTAL_PAGO,
        SUM(CASE 
				WHEN TP.DESCRICAO = 'Debit' AND JO.VALOR_PAG < 0 AND JO.VALOR_REC = 0 THEN
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG * -1)
				WHEN JO.VALOR_PAG < 0 THEN
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) - ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG * -1)
				ELSE 
					((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_REC) - (((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_PAG) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FID) + ((ifnull(JO.QTD2, JO.QTD)) * JO.VALOR_FDR) + ((ifnull(JO.QTD2, JO.QTD)) * (JO.VALOR_REP - JO.VALOR_DESC)))
				END
	    ) AS TOTAL_LUCRO        
 FROM tb_ordem AS OD
 JOIN tb_jobs_ordem AS JO
   ON JO.COD_EMPRESA = OD.COD_EMPRESA
  AND JO.ID_ORDEM = OD.ID_ORDEM
 JOIN tb_job AS JB
   ON JB.COD_EMPRESA = JO.COD_EMPRESA
  AND JB.COD_JOB = JO.COD_JOB
 JOIN TB_TIPO_ORDEM AS TP
   ON TP.COD_EMPRESA = OD.COD_EMPRESA
 AND TP.COD_TIPO_ORDEM = OD.COD_TIPO_ORDEM
WHERE STATUS = 'Finished' 
  AND DATA_AGEND >= DATE_SUB(CURRENT_DATE(), INTERVAL 12 MONTH)
  GROUP BY OD.COD_EMPRESA, OD.COD_FILIAL, JO.COD_JOB, MES;
--
END //

DELIMITER ;