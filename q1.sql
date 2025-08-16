DROP PROCEDURE IF EXISTS ListAllSubscribers;
DELIMITER $$

CREATE PROCEDURE ListAllSubscribers()
BEGIN
    -- 1. Declare all variables, cursors, handlers FIRST
    DECLARE done INT DEFAULT 0;
    DECLARE sub_name VARCHAR(100);

    DECLARE cur CURSOR FOR
        SELECT SubscriberName FROM Subscribers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- 2. Create/prepare the temp table AFTER declarations
    CREATE TEMPORARY TABLE IF NOT EXISTS TempSubs (
        SubscriberName VARCHAR(100)
    );
    TRUNCATE TABLE TempSubs;

    -- 3. Open and loop through cursor
    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO sub_name;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO TempSubs VALUES (sub_name);
    END LOOP;

    CLOSE cur;

    -- 4. Return all results in one grid
    SELECT * FROM TempSubs;
END$$

DELIMITER ;