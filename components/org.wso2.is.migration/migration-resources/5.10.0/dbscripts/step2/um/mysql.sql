DROP PROCEDURE IF EXISTS ALTER_UM_USER;

DELIMITER $$
CREATE PROCEDURE ALTER_UM_USER()
BEGIN
    IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='UM_USER') THEN
        IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='UM_USER' AND COLUMN_NAME='UM_USER_ID') THEN
            ALTER TABLE `UM_USER` ADD COLUMN `UM_USER_ID` CHAR(36) NOT NULL DEFAULT 'NONE', ADD UNIQUE(UM_USER_ID, UM_TENANT_ID);
            UPDATE UM_USER SET UM_USER_ID = UUID();
        END IF;
    END IF;
END $$
DELIMITER ;

CALL ALTER_UM_USER();

