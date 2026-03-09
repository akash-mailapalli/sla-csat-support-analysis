/* =========================================================
   STEP 1: USE PROJECT DATABASE
========================================================= */

USE SupportAnalytics;
GO


/* =========================================================
   STEP 2: TOTAL UNIQUE TICKETS
========================================================= */

SELECT COUNT(Distinct Ticket_ID) as Total_tickets
FROM support_tickets_stg;


/* =========================================================
   STEP 3: TICKET DISTRIBUTION BY STATUS
========================================================= */

SELECT Ticket_Status,
COUNT(*) as Total_tickets
FROM support_tickets_stg
GROUP BY Ticket_Status
ORDER BY Total_tickets DESC;


/* =========================================================
   STEP 4: TICKET DISTRIBUTION BY PRIORITY
========================================================= */

SELECT Priority,
count(*) as Total_tickets
FROM support_tickets_stg
GROUP BY Priority
ORDER BY Total_tickets Desc


/* =========================================================
   STEP 5: TICKETS BY SUPPORT TEAM
========================================================= */

SELECT Support_Team,
COUNT(*) as Total_tickets
FROM support_tickets_stg
GROUP BY Support_Team
Order By Total_tickets desc;


/* =========================================================
   STEP 6: TICKETS BY APPLICATION MODULE
========================================================= */

SELECT Application_Module,
COUNT(*) as Total_tickets
FROM support_tickets_stg
GROUP BY Application_Module
Order By Total_tickets desc;


/* =========================================================
   STEP 7: AVERAGE RESOLUTION TIME
========================================================= */

SELECT AVG(Resolution_Days) as avg_resolution_days
FROM support_tickets_stg
WHERE Resolution_Days IS NOT NULL


/* =========================================================
   STEP 8: AVERAGE RESOLUTION TIME BY PRIORITY
========================================================= */

SELECT 
Priority,
AVG(Resolution_Days) AS Avg_Resolution_Days
FROM support_tickets_stg
WHERE Resolution_Days IS NOT NULL
GROUP BY Priority
ORDER BY Avg_Resolution_Days;


/* =========================================================
   STEP 9: SLA PERFORMANCE DISTRIBUTION
========================================================= */

SELECT 
SLA_Status,
COUNT(*) AS Ticket_Count
FROM support_tickets_stg
GROUP BY SLA_Status;


/* =========================================================
   STEP 10: SLA COMPLIANCE RATE
========================================================= */

SELECT 
COUNT(CASE WHEN SLA_Status = 'Met' THEN 1 END) * 100.0 / COUNT(*) 
AS SLA_Compliance_Percentage
FROM support_tickets_stg
WHERE SLA_Status IS NOT NULL;


/* =========================================================
   STEP 11: OVERALL CUSTOMER SATISFACTION SCORE
========================================================= */

SELECT 
AVG(CSAT_Score) AS Avg_CSAT
FROM support_tickets_stg
WHERE CSAT_Score IS NOT NULL;


/* =========================================================
   STEP 12: CUSTOMER SATISFACTION BY SUPPORT ENGINEER
========================================================= */

SELECT 
Support_Engineer,
AVG(CSAT_Score) AS Avg_CSAT
FROM support_tickets_stg
WHERE CSAT_Score IS NOT NULL
GROUP BY Support_Engineer
ORDER BY Avg_CSAT DESC;


/* =========================================================
   STEP 13: SUPPORT ENGINEER PERFORMANCE
========================================================= */

SELECT 
Support_Engineer,
COUNT(*) AS Tickets_Handled,
AVG(Resolution_Days) AS Avg_Resolution_Time
FROM support_tickets_stg
GROUP BY Support_Engineer
ORDER BY Tickets_Handled DESC;


/* =========================================================
   STEP 14: MONTHLY TICKET TREND
========================================================= */

SELECT 
YEAR(Created_Date) AS Year,
MONTH(Created_Date) AS Month,
COUNT(*) AS Ticket_Count
FROM support_tickets_stg
GROUP BY YEAR(Created_Date), MONTH(Created_Date)
ORDER BY Year, Month;