-- q3.sql
USE assignment2;

DROP PROCEDURE IF EXISTS AddSubscriberIfNotExists;
DELIMITER $$

CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
    DECLARE cnt INT DEFAULT 0;
    DECLARE next_id INT;

    SELECT COUNT(*) INTO cnt
    FROM Subscribers
    WHERE SubscriberName = subName;

    IF cnt = 0 THEN
        SELECT IFNULL(MAX(SubscriberID), 0) + 1 INTO next_id FROM Subscribers;

        INSERT INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate)
        VALUES (next_id, subName, CURDATE());

        SELECT CONCAT('Inserted new subscriber with ID ', next_id) AS Message;
    ELSE
        SELECT 'Subscriber already exists' AS Message;
    END IF;
END$$
DELIMITER ;