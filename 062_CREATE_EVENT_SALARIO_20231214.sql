--
-- 
SHOW VARIABLES LIKE 'event_scheduler';
-- 
-- Se precisar precisa ativar o evento
-- SET GLOBAL event_scheduler = ON;
--
--
DROP EVENT IF EXISTS `geracao_automatica_salario`;
--
DELIMITER //
--
CREATE EVENT IF NOT EXISTS `geracao_automatica_salario`
-- ON SCHEDULE EVERY 1 DAY
-- STARTS TIMESTAMP(CURDATE() + INTERVAL 23 HOUR)
-- ENDS TIMESTAMP(CURDATE() + INTERVAL 1 DAY + INTERVAL 23 HOUR)
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
DO
BEGIN
	CALL sp_geracao_automatica_salario();
END;
--
//
--
DELIMITER ;