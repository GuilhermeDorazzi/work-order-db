DROP PROCEDURE IF EXISTS sp_geracao_automatica_salario;
--
DELIMITER //

CREATE PROCEDURE sp_geracao_automatica_salario()
BEGIN
    DECLARE v_id_salario INT;
    DECLARE v_cod_empresa INT;
    DECLARE v_cod_usuario INT;
    DECLARE v_cod_filial INT;
    DECLARE v_titulo VARCHAR(100);
    DECLARE v_tipo_salario VARCHAR(20);
    DECLARE v_data_vencimento DATE;
    DECLARE v_valor_salario DECIMAL(10,2);
    
    -- Seleciona os salários que precisam ser processados
    DECLARE cur_salario CURSOR FOR
        SELECT ID_SALARIO, COD_EMPRESA, COD_USUARIO, COD_FILIAL, TITULO, TIPO_SALARIO, DATA_VENCIMENTO, VALOR_SALARIO
        FROM tb_salario
        WHERE FLG_ATIVO = 'S';

    OPEN cur_salario;

    salario_loop: LOOP
        FETCH cur_salario INTO v_id_salario, v_cod_empresa, v_cod_usuario, v_cod_filial, v_titulo, v_tipo_salario, v_data_vencimento, v_valor_salario;
        -- Caso não tenha mais itens para serem processados ele vai acabar aqui 
		IF v_id_salario IS NULL THEN
            LEAVE salario_loop;
        END IF;
		--
        -- Quando a rotina precisar rodar de semana em semana
		IF v_tipo_salario = 'Weekly' 
		   AND v_data_vencimento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY) 
		   AND NOT EXISTS ( SELECT 1
							  FROM tb_salario_lancado
							 WHERE ID_SALARIO = v_id_salario
							   AND COD_EMPRESA = v_cod_empresa
							   AND DATA_LANCAMENTO BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
						   ) THEN
			 -- Gera o lançamento na tabela tb_salario_lancado
			INSERT INTO tb_salario_lancado (COD_EMPRESA, COD_USUARIO, COD_FILIAL, ID_SALARIO, TITULO, TIPO_SALARIO, DATA_LANCAMENTO, VALOR_SALARIO)
									VALUES (v_cod_empresa, v_cod_usuario, v_cod_filial, v_id_salario, v_titulo, v_tipo_salario, v_data_vencimento, v_valor_salario);
			--
			-- Atualiza a DATA_VENCIMENTO na tabela tb_salario
			UPDATE tb_salario
			   SET DATA_VENCIMENTO = DATE_ADD(v_data_vencimento, INTERVAL 7 DAY)
			 WHERE ID_SALARIO = v_id_salario;
			--
		END IF;
    END LOOP;
	--
    CLOSE cur_salario;
END //

DELIMITER ;