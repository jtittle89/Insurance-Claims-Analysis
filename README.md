# Insurance-Claims-Analysis
Analysis of insurance claims data to identify key financial areas.

Project Overview

This project delivers a comprehensive financial analysis of insurance claims data to identify cost drivers, spending patterns, and high-impact areas across claim types, member demographics, and medical codes. The analysis is designed to support strategic decision-making by highlighting where claim dollars are concentrated and where opportunities for financial optimization exist.

Business Objective

    Provide clear, data-driven insights into insurance claims spending in order to:
    
    Identify claim types and services driving the highest costs
    
    Understand payment efficiency through pay ratio analysis
    
    Analyze member demographics contributing most to claim volume and spend
    
    Support cost containment, pricing, and utilization management strategies

Tools & Methodology

SQL (MySQL)

    SQL was used to prepare, validate, and analyze the raw claims data prior to visualization.
    
    Key activities included:
    
    Reviewing and validating claims and member data to ensure consistency and accuracy
    
    Identifying and addressing missing or null values that could impact financial metrics
    
    Analyzing highest paid claims by claim type
    
    Using SQL ranking functions to identify the Top 10 highest paid CPT and ICD codes
    
    Calculating pay ratios (paid amount ÷ billed amount) by claim type
    
    Grouping members into age buckets using CASE statements to analyze claim volume and average paid amounts by age group
    
    Writing aggregation queries to calculate average billed amount, paid amount, and pay ratio by insurance plan type and claim type
    
    This SQL-driven approach ensured clean, reliable data and repeatable analysis prior to dashboard development.

Tableau

Tableau was used to build an executive-level dashboard focused on financial performance and utilization trends.

Dashboard components include:

    KPI Cards displaying:
    
    Total Claims
    
    Total Members
    
    Total Billed Amount
    
    Total Paid Amount
    
    Overall Pay Ratio
    
    Bar Chart showing total paid amount and claim count by claim type
    
    Column Charts highlighting the Top 10 CPT and ICD codes by total amount paid
    
    Column Chart displaying total paid amounts by age group, segmented by gender
    
    Line Chart illustrating trends in claims paid over time
    
    Interactive Filters for plan type, claim type, ICD code, and CPT code to enable drill-down and ad hoc analysis

The dashboard is designed for executives and analysts to quickly identify cost drivers while retaining the ability to explore underlying details.

Key Insights

    Inpatient claims have the lowest pay ratio (0.75) but represent the highest billed amounts, making them the most financially significant claim type
    
    The highest paid CPT and ICD codes identified were 67890 and I10, indicating concentrated spend in specific procedures and diagnoses
    
    Members aged 30–59 account for the highest claim volume and total paid amounts, with the 40–49 age group being the most costly
    
    Male members show higher claim counts and total paid amounts compared to female members
    
    Inpatient claims experienced a noticeable spike from January 2023 through May 2023, followed by a significant decline, suggesting potential changes in utilization, policy, or operational factors

Business Impact

    This analysis enables stakeholders to:
    
    Focus cost-management strategies on high-impact claim types and services
    
    Monitor payment efficiency through pay ratio trends
    
    Better understand demographic-driven utilization patterns
    
    Support data-driven decisions in pricing, contracting, and utilization review

Skills Demonstrated

    SQL Data Validation & Financial Aggregation
    
    Advanced SQL (CASE statements, ranking functions)
    
    Healthcare & Insurance Claims Analytics
    
    KPI Development & Executive Reporting
    
    Tableau Dashboard Design & Interactive Analysis

<img width="1691" height="851" alt="image" src="https://github.com/user-attachments/assets/b91a12eb-30d6-433f-b1e5-fcc866022a1e" />
