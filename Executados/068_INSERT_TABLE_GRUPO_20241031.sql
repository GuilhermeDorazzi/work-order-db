INSERT INTO `work_order`.`tb_grupo` (`GRUTECH`, `NIVEL_ACESSO`) VALUES ('Seeker', '2');
-- TROCAR NA NAO O USUARIO QUE TEM ESSE FIELD_DIRECTOR PARA O SEEKER.
DELETE FROM `work_order`.`tb_grupo` WHERE (`GRUTECH` = 'Field Director');
--
UPDATE `work_order`.`tb_paginas` SET `NOME_PAGINA` = 'Seeker Analitico' WHERE (`COD_PAGINA` = '3022');

select * from tb_paginas;