-- CREATE TABLE Students (
--     StudentID INT PRIMARY KEY,
--     Name NVARCHAR(50),
--     Marks INT
-- );
-- select * from students;

-- CREATE TABLE StudentLog (
--     LogID INT IDENTITY PRIMARY KEY,
--     StudentID INT,
--     Action NVARCHAR(20),
--     LogDate DATETIME
-- );


-- CREATE TABLE StudentLog (
--     LogID INT IDENTITY PRIMARY KEY,
--     StudentID INT,
--     Action NVARCHAR(20),
--     LogDate DATETIME
-- );


-- CREATE TRIGGER trg_AfterInsert_Students
-- ON Students
-- AFTER INSERT
-- AS
-- BEGIN
--     INSERT INTO StudentLog (StudentID, Action, LogDate)
--     SELECT StudentID, 'INSERT', GETDATE()
--     FROM inserted;
-- END;
-- select * from sys.objects where name like 'In%'
-- INSERT INTO Students (StudentID, Name, Marks)
-- VALUES (1, 'Amit', 85);

-- SELECT * FROM Students;
-- SELECT * FROM StudentLog;
