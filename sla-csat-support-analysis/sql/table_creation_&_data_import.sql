/* =========================================================
   STEP 1: CREATE DATABASE
========================================================= */

CREATE DATABASE SupportAnalytics;
GO

USE SupportAnalytics;


/* =========================================================
   STEP 2: CREATE RAW TABLE (ALL VARCHAR FOR SAFE IMPORT)
========================================================= */

CREATE TABLE support_tickets (
    Ticket_ID VARCHAR(50),
    Created_Date VARCHAR(50),
    Resolved_Date VARCHAR(50),
    Support_Team VARCHAR(100),
    Support_Engineer VARCHAR(100),
    Application_Module VARCHAR(100),
    Issue_Category VARCHAR(100),
    Priority VARCHAR(50),
    Ticket_Status VARCHAR(50),
    Resolution_Days VARCHAR(50),
    SLA_Target_Days VARCHAR(50),
    SLA_Status VARCHAR(50),
    CSAT_Score VARCHAR(50)
);


/* =========================================================
   STEP 3: IMPORT CSV FILE
========================================================= */

BULK INSERT support_tickets
FROM 'C:\Users\akash\Desktop\Data_Analyst\Projects\sla-csat-support-analysis\data\raw\support_ticket_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);


/* =========================================================
   STEP 4: VERIFY DATA IMPORT
========================================================= */

SELECT COUNT(*) AS Total_Rows
FROM support_tickets;

SELECT TOP 10 *
FROM support_tickets;


/* =========================================================
   STEP 5: CREATE STAGING TABLE
========================================================= */

SELECT *
INTO support_tickets_stg
FROM support_tickets;


/* =========================================================
   STEP 6: VERIFY STAGING TABLE
========================================================= */

SELECT COUNT(*) 
FROM support_tickets_stg;

SELECT TOP 10 *
FROM support_tickets_stg;


/* =========================================================
   STEP 7: CHECK DATA TYPES
========================================================= */

SELECT 
COLUMN_NAME,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'support_tickets_stg';


/* =========================================================
   STEP 8: DATA PROFILING – MISSING VALUES
========================================================= */

SELECT
COUNT(*) - COUNT(Ticket_ID) AS Missing_TicketID,
COUNT(*) - COUNT(Created_Date) AS Missing_CreatedDate,
COUNT(*) - COUNT(Resolved_Date) AS Missing_ResolvedDate,
COUNT(*) - COUNT(Support_Team) AS Missing_SupportTeam,
COUNT(*) - COUNT(Support_Engineer) AS Missing_Engineer,
COUNT(*) - COUNT(Application_Module) AS Missing_Module,
COUNT(*) - COUNT(Issue_Category) AS Missing_IssueCategory,
COUNT(*) - COUNT(Priority) AS Missing_Priority,
COUNT(*) - COUNT(Ticket_Status) AS Missing_Status,
COUNT(*) - COUNT(Resolution_Days) AS Missing_ResolutionDays,
COUNT(*) - COUNT(SLA_Target_Days) AS Missing_SLATarget,
COUNT(*) - COUNT(SLA_Status) AS Missing_SLAStatus,
COUNT(*) - COUNT(CSAT_Score) AS Missing_CSAT
FROM support_tickets_stg;


/* =========================================================
   STEP 9: CHECK DISTINCT VALUES
========================================================= */

SELECT DISTINCT Priority
FROM support_tickets_stg
ORDER BY Priority;

SELECT DISTINCT Ticket_Status
FROM support_tickets_stg
ORDER BY Ticket_Status;

SELECT DISTINCT Application_Module
FROM support_tickets_stg
ORDER BY Application_Module;

SELECT DISTINCT Issue_Category
FROM support_tickets_stg
ORDER BY Issue_Category;


/* =========================================================
   STEP 10: CLEAN TEXT COLUMNS
========================================================= */

UPDATE support_tickets_stg
SET Priority = LOWER(TRIM(Priority));

UPDATE support_tickets_stg
SET Ticket_Status = LOWER(TRIM(Ticket_Status));


/* =========================================================
   STEP 11: VERIFY CLEANED TEXT DATA
========================================================= */

SELECT DISTINCT Priority
FROM support_tickets_stg;

SELECT DISTINCT Ticket_Status
FROM support_tickets_stg;


/* =========================================================
   STEP 12: CHECK NUMERIC COLUMN ISSUES
========================================================= */

SELECT Resolution_Days
FROM support_tickets_stg
WHERE TRY_CAST(Resolution_Days AS INT) IS NULL
AND Resolution_Days IS NOT NULL;

SELECT SLA_Target_Days
FROM support_tickets_stg
WHERE TRY_CAST(SLA_Target_Days AS INT) IS NULL
AND SLA_Target_Days IS NOT NULL;

SELECT CSAT_Score
FROM support_tickets_stg
WHERE TRY_CAST(CSAT_Score AS INT) IS NULL
AND CSAT_Score IS NOT NULL;


/* =========================================================
   STEP 13: CHECK DATE COLUMN ISSUES
========================================================= */

SELECT Created_Date
FROM support_tickets_stg
WHERE TRY_CAST(Created_Date AS DATE) IS NULL
AND Created_Date IS NOT NULL;

SELECT Resolved_Date
FROM support_tickets_stg
WHERE TRY_CAST(Resolved_Date AS DATE) IS NULL
AND Resolved_Date IS NOT NULL;


/* =========================================================
   STEP 14: CONVERT NUMERIC VALUES
========================================================= */

UPDATE support_tickets_stg
SET CSAT_Score = CAST(CAST(CSAT_Score AS FLOAT) AS INT)
WHERE CSAT_Score IS NOT NULL;

UPDATE support_tickets_stg
SET Resolution_Days = CAST(CAST(Resolution_Days AS FLOAT) AS INT)
WHERE Resolution_Days IS NOT NULL;


/* =========================================================
   STEP 15: CONVERT DATE COLUMNS
========================================================= */

UPDATE support_tickets_stg
SET Created_Date = TRY_CAST(Created_Date AS DATE);

UPDATE support_tickets_stg
SET Resolved_Date = TRY_CAST(Resolved_Date AS DATE);


/* =========================================================
   STEP 16: CHECK DUPLICATE TICKETS
========================================================= */

SELECT Ticket_ID, COUNT(*) 
FROM support_tickets_stg
GROUP BY Ticket_ID
HAVING COUNT(*) > 1;


/* =========================================================
   STEP 16: CHANGE COLUMN DATA TYPES (AFTER CLEANING)
========================================================= */

ALTER TABLE support_tickets_stg
ALTER COLUMN Created_Date DATE;

ALTER TABLE support_tickets_stg
ALTER COLUMN Resolved_Date DATE;

ALTER TABLE support_tickets_stg
ALTER COLUMN Resolution_Days INT;

ALTER TABLE support_tickets_stg
ALTER COLUMN SLA_Target_Days INT;

ALTER TABLE support_tickets_stg
ALTER COLUMN CSAT_Score INT;


/* =========================================================
   STEP 17: ADD PRIMARY KEY
========================================================= */

ALTER TABLE support_tickets_stg
ALTER COLUMN Ticket_ID VARCHAR(50) NOT NULL;

ALTER TABLE support_tickets_stg
ADD CONSTRAINT PK_support_ticket
PRIMARY KEY (Ticket_ID);


/* =========================================================
   STEP 18: ADD CHECK CONSTRAINTS
========================================================= */

ALTER TABLE support_tickets_stg
ADD CONSTRAINT chk_priority
CHECK (Priority IN ('critical','high','medium','low'));

ALTER TABLE support_tickets_stg
ADD CONSTRAINT chk_ticket_status
CHECK (Ticket_Status IN 
('open','in progress','pending client','resolved','closed'));

ALTER TABLE support_tickets_stg
ADD CONSTRAINT chk_csat
CHECK (CSAT_Score BETWEEN 1 AND 5 OR CSAT_Score IS NULL);

ALTER TABLE support_tickets_stg
ADD CONSTRAINT chk_resolution_days
CHECK (Resolution_Days >= 0 OR Resolution_Days IS NULL);

ALTER TABLE support_tickets_stg
ADD CONSTRAINT chk_sla_target
CHECK (SLA_Target_Days > 0);



/* =========================================================
   STEP 19: VERIFY CONSTRAINTS
========================================================= */

SELECT 
COLUMN_NAME,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'support_tickets_stg';

EXEC sp_helpconstraint 'support_tickets_stg';


/* =========================================================
   STEP 20: FINAL CLEAN DATASET
========================================================= */

SELECT *
FROM support_tickets_stg;