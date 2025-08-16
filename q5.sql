DROP PROCEDURE IF EXISTS PrintAllSubscribersWatchHistory;
DELIMITER $$

CREATE PROCEDURE PrintAllSubscribersWatchHistory()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE sid INT;

    DECLARE cur CURSOR FOR
        SELECT SubscriberID FROM Subscribers ORDER BY SubscriberID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Temp table to collect all histories
    CREATE TEMPORARY TABLE IF NOT EXISTS FullReport (
        SubscriberID INT,
        SubscriberName VARCHAR(100),
        ShowTitle VARCHAR(100),
        WatchTime INT
    );
    TRUNCATE TABLE FullReport;

    OPEN cur;

    loop_all: LOOP
        FETCH cur INTO sid;
        IF done = 1 THEN
            LEAVE loop_all;
        END IF;

        -- Insert each subscriber’s watch history into report
        INSERT INTO FullReport (SubscriberID, SubscriberName, ShowTitle, WatchTime)
        SELECT s.SubscriberID, s.SubscriberName, sh.Title, wh.WatchTime
        FROM Subscribers s
        LEFT JOIN WatchHistory wh ON s.SubscriberID = wh.SubscriberID
        LEFT JOIN Shows sh ON sh.ShowID = wh.ShowID
        WHERE s.SubscriberID = sid;
    END LOOP;

    CLOSE cur;

    -- Final combined result
    SELECT * 
    FROM FullReport
    ORDER BY SubscriberID, ShowTitle;
END$$
DELIMITER ;