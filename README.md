# Application Support SLA & CSAT Performance Analysis

https://github.com/akash-mailapalli/sla-csat-support-analysis

## Overview

This project analyzes application support ticket data to evaluate **SLA compliance, resolution performance, support team workload, and customer satisfaction**.

The goal is to help support managers understand operational performance, identify bottlenecks, and improve the customer support experience.

---

## Company Context (Fictional)

**Company:** Nexora Digital Solutions
**Industry:** IT Services & Application Support

Nexora provides technical support for enterprise applications including payments, reporting, user management, and API integrations. When customers encounter issues, they create support tickets that are handled by specialized support teams.

---

## Business Problem

Support teams handle thousands of tickets across multiple applications and teams. Without analytics it becomes difficult to:

* Monitor ticket volume and workload
* Track SLA compliance
* Identify support teams missing SLA targets
* Evaluate engineer productivity
* Understand how resolution time affects customer satisfaction

This project provides a **data-driven dashboard solution** to monitor support operations and improve decision making.

---

# Tools & Technologies

* **SQL Server** – Data ingestion, cleaning, and analysis
* **Power BI** – Interactive dashboard development
* **DAX** – KPI calculations and analytical measures
* **GitHub** – Project documentation and portfolio hosting

---

# Dataset Description

The dataset simulates application support tickets.

### Key Fields

* Ticket_ID
* Created_Date
* Resolved_Date
* Support_Team
* Support_Engineer
* Application_Module
* Issue_Category
* Priority
* Ticket_Status
* Resolution_Days
* SLA_Target_Days
* SLA_Status
* CSAT_Score

---

# Data Processing Workflow

CSV Data
↓
SQL Server Raw Table
↓
Staging Table for Data Cleaning
↓
Data Validation & Constraints
↓
SQL Analysis Queries
↓
Power BI Dashboard

---

# Dashboard Pages

## 1. Operations Overview

### Business Problem Solved

Support managers need a quick overview of ticket workload and operational performance across teams.

### Key Metrics

* Total Tickets
* Average Resolution Days
* Tickets per Engineer
* Average CSAT Score

### Visuals

* Monthly ticket trend
* Ticket distribution by priority
* Ticket distribution by status
* Ticket workload by support team

<img width="1279" height="663" alt="Screenshot 2026-03-09 171140" src="https://github.com/user-attachments/assets/a1674606-da1f-4724-8c2d-987798dd04fa" />


### Insights Generated

* Identifies periods with high ticket volume
* Shows which priority levels dominate support workload
* Reveals which support teams handle the highest number of tickets
* Provides a quick health check of support operations

---

## 2. SLA Performance Analysis

### Business Problem Solved

Organizations must ensure tickets are resolved within defined SLA targets. This dashboard helps identify SLA breaches and performance gaps.

### Key Metrics

* Total Resolved Tickets
* SLA Met Tickets
* SLA Breached Tickets
* SLA Compliance Percentage

### Visuals

* SLA status distribution
* SLA performance by priority
* SLA performance by support team
* Resolution time by priority

<img width="1243" height="657" alt="Screenshot 2026-03-09 174629" src="https://github.com/user-attachments/assets/8c9648eb-9ba5-4388-bcb4-f970515054c5" />


### Insights Generated

* Measures overall SLA compliance
* Identifies which priority levels cause the most SLA breaches
* Shows which support teams miss SLA targets
* Highlights resolution time patterns across ticket priorities

---

## 3. Engineer Performance & Customer Insights

### Business Problem Solved

Support managers need to evaluate engineer productivity and understand how service quality impacts customer satisfaction.

### Key Metrics

* Total Engineers
* Tickets per Engineer
* Average Resolution Days
* Average CSAT Score

### Visuals

* Top engineers by ticket volume
* Top engineers by CSAT
* CSAT vs resolution time scatter analysis
* Ticket distribution by application module

<img width="1032" height="582" alt="Screenshot 2026-03-09 193207" src="https://github.com/user-attachments/assets/5b4e0a49-bf57-452b-96a5-8db7c0526684" />


### Insights Generated

* Identifies top performing engineers
* Reveals workload distribution across engineers
* Shows relationship between resolution time and customer satisfaction
* Identifies application modules generating the most support issues

---

# Key Business Insights

* Critical issues are resolved faster than lower priority tickets.
* Some application modules generate significantly more support tickets.
* Faster ticket resolution tends to result in higher customer satisfaction.
* Workload distribution varies across support teams and engineers.

---

# Project Structure

```id="projecttree1"
sla-csat-support-analysis
│
├── data
│   ├── raw
│   └── cleaned
│
├── sql
│   ├── data_ingestion.sql
│   ├── data_cleaning.sql
│   └── analysis_queries.sql
│
├── powerbi
│   └── support_dashboard.pbix
│
├── docs
│   └── project_documentation.docx
│
└── README.md
```

---

# Conclusion

This project demonstrates how data analytics can improve **IT support operations** by providing visibility into SLA compliance, resolution efficiency, and customer satisfaction.

The dashboards help organizations identify operational improvements, optimize support performance, and deliver better customer service.

---
