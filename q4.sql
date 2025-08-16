DROP PROCEDURE IF EXISTS SendWatchTimeReport;
DELIMITER $$

CREATE PROCEDURE SendWatchTimeReport()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE sid INT;

    DECLARE cur CURSOR FOR
        SELECT DISTINCT SubscriberID FROM WatchHistory ORDER BY SubscriberID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Create temp table to gather report
    CREATE TEMPORARY TABLE IF NOT EXISTS TempReport (
        SubscriberID INT,
        ShowTitle VARCHAR(100),
        WatchTime INT
    );
    TRUNCATE TABLE TempReport;

    OPEN cur;

    loop_subs: LOOP
        FETCH cur INTO sid;
        IF done = 1 THEN
            LEAVE loop_subs;
        END IF;

        -- Insert this subscriber’s history into the report
        INSERT INTO TempReport (SubscriberID, ShowTitle, WatchTime)
        SELECT sID.SubscriberID, sh.Title, wh.WatchTime
        FROM WatchHistory wh
        JOIN Shows sh ON sh.ShowID = wh.ShowID
        JOIN (SELECT sid AS SubscriberID) sID ON sID.SubscriberID = wh.SubscriberID;
    END LOOP;

    CLOSE cur;

    -- Final report: one big resultset
    SELECT * FROM TempReport ORDER BY SubscriberID, ShowTitle;
END$$
DELIMITER ;