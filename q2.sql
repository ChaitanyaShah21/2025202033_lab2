-- q2.sql
USE assignment2;

DROP PROCEDURE IF EXISTS GetWatchHistoryBySubscriber;
DELIMITER $$

CREATE PROCEDURE GetWatchHistoryBySubscriber(IN sub_id INT)
BEGIN
    SELECT s.Title AS ShowTitle,
           w.WatchTime
    FROM WatchHistory AS w
    JOIN Shows AS s ON s.ShowID = w.ShowID
    WHERE w.SubscriberID = sub_id
    ORDER BY s.Title;
END$$
DELIMITER ;