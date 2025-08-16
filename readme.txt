**GITHUB REPO**
https://github.com/ChaitanyaShah21/2025202033_lab2

**Files**
q1.sql – ListAllSubscribers()  
q2.sql – GetWatchHistoryBySubscriber(IN sub_id INT)  
q3.sql – AddSubscriberIfNotExists(IN subName VARCHAR(100))  
q4.sql – SendWatchTimeReport()  
q5.sql – PrintAllSubscribersWatchHistory()  



**Setup**

->Open MySQL Workbench.

->Create schema (example: assignment2):

CREATE DATABASE assignment2;
USE assignment2;


->Create base tables and insert sample data:

CREATE TABLE Shows (
    ShowID INT PRIMARY KEY,
    Title VARCHAR(100),
    Genre VARCHAR(50),
    ReleaseYear INT
);

CREATE TABLE Subscribers (
    SubscriberID INT PRIMARY KEY,
    SubscriberName VARCHAR(100),
    SubscriptionDate DATE
);

CREATE TABLE WatchHistory (
    HistoryID INT PRIMARY KEY,
    ShowID INT,
    SubscriberID INT,
    WatchTime INT,
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID),
    FOREIGN KEY (SubscriberID) REFERENCES Subscribers(SubscriberID)
);

-- Insert sample data
INSERT INTO Shows (ShowID, Title, Genre, ReleaseYear) VALUES
(1, 'Stranger Things', 'Sci-Fi', 2016),
(2, 'The Crown', 'Drama', 2016),
(3, 'The Witcher', 'Fantasy', 2019);

INSERT INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate) VALUES
(1, 'Emily Clark', '2023-01-10'),
(2, 'Chris Adams', '2023-02-15'),
(3, 'Jordan Smith', '2023-03-05');

INSERT INTO WatchHistory (HistoryID, SubscriberID, ShowID, WatchTime) VALUES
(1, 1, 1, 100),
(2, 1, 2, 10),
(3, 2, 1, 20),
(4, 2, 2, 40),
(5, 2, 3, 10),
(6, 3, 2, 10),
(7, 3, 1, 10);


-> Run each .sql file to create stored procedures.



**Usage**

Q1 → CALL ListAllSubscribers();

Q2 → CALL GetWatchHistoryBySubscriber(2);

Q3 → CALL AddSubscriberIfNotExists('New Person');

Q4 → CALL SendWatchTimeReport();

Q5 → CALL PrintAllSubscribersWatchHistory();


