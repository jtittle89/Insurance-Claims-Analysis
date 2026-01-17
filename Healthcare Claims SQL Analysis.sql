# Initial look at the data
SELECT * FROM claims;
SELECT * FROM members;

# Check for null and missing values
SELECT
	SUM(CASE WHEN claim_id IS NULL OR claim_id = '' then 1 else 0 END) AS claim_id_null,
    SUM(CASE WHEN member_id IS NULL OR member_id = '' then 1 else 0 END) AS member_id_null,
    SUM(CASE WHEN provider_id IS NULL OR provider_id = '' then 1 else 0 END) AS provider_id_null,
    SUM(CASE WHEN claim_date IS NULL OR claim_date = '' then 1 else 0 END) AS claim_date_null,
    SUM(CASE WHEN claim_type IS NULL OR claim_type = '' then 1 else 0 END) AS claim_type_null,
    SUM(CASE WHEN cpt_code IS NULL OR cpt_code = '' then 1 else 0 END) AS cpt_code_null,
    SUM(CASE WHEN icd_code IS NULL OR icd_code = '' then 1 else 0 END) AS icd_code_null,
    SUM(CASE WHEN billed_amount IS NULL OR billed_amount = '' then 1 else 0 END) AS billed_amount_null,
    SUM(CASE WHEN paid_amount IS NULL OR paid_amount = '' then 1 else 0 END) AS paid_amount_null
FROM claims;

# Findings: On the claims dataset, claim IDs 6 and 225 have zero paid amount.
# Recommended Action: Communicate with a team member that has access to the claim data to confirm the amounts are correct. 

SELECT
    SUM(CASE WHEN member_id IS NULL OR member_id = '' then 1 else 0 END) AS member_id_null,
    SUM(CASE WHEN member_age IS NULL OR member_age = '' then 1 else 0 END) AS member_age_null,
    SUM(CASE WHEN member_gender IS NULL OR member_gender = '' then 1 else 0 END) AS member_gender_null,
    SUM(CASE WHEN plan_type IS NULL OR plan_type = '' then 1 else 0 END) AS plan_type_null,
    SUM(CASE WHEN enrollment_start_date IS NULL OR enrollment_start_date = '' then 1 else 0 END) AS enrollment_start_date_null,
    SUM(CASE WHEN enrollment_end_date IS NULL OR enrollment_end_date = '' then 1 else 0 END) AS enrollment_end_date_null
FROM members;

# Findings: On the members dataset, 15 members do not have an enrollment end date and are currently enrolled in a plan.
# Recommended Actions: replace blank values with text such as Currently Enrolled or Not Applicable, or continue to leave blank. 

# Manager Questions:

# Which claim types are the most expensive?
# Findings: The claim type with the highest billed and paid is inpatient which is three times higher than the next highest claim type.  
SELECT 
	claim_type,
    SUM(billed_amount) AS total_billed,
    SUM(paid_amount) AS total_paid,
    COUNT(*) AS total_claims
FROM claims
GROUP BY claim_type
ORDER BY total_paid DESC;

# Which CPT and ICD codes drive the highest spending?

#Top 10 CPT codes by total amount paid.
SELECT
	RANK() OVER (ORDER BY total_paid DESC) AS total_paid_rank,
    cpt_code,
    total_paid
FROM (
    SELECT 
        cpt_code,
        SUM(paid_amount) AS total_paid
    FROM claims
    GROUP BY cpt_code
) t
ORDER BY total_paid DESC
LIMIT 10;

#Top 10 ICD codes by total amount paid.
SELECT
	RANK() OVER (ORDER BY total_paid DESC) AS total_paid_rank,
    icd_code,
    total_paid
FROM (
    SELECT 
        icd_code,
        SUM(paid_amount) AS total_paid
    FROM claims
    GROUP BY icd_code
) t
ORDER BY total_paid DESC
LIMIT 10;

# CPT codes with the highest amount paid per claim.
SELECT
	cpt_code,
    ROUND(SUM(paid_amount)/COUNT(*),2) AS average_paid_per_claim
FROM claims
GROUP BY cpt_code
ORDER BY average_paid_per_claim DESC
LIMIT 10;

# Which members account for the largest share of total costs?
SELECT 
	member_id,
    claim_type,
    SUM(paid_amount) as total_paid
FROM claims
GROUP BY member_id, claim_type
ORDER BY total_paid DESC
LIMIT 10;

# How do billed amounts compare to paid amounts?

# Paid Ratios by claim type, provider, and CPT code
SELECT 
	claim_type,
    SUM(paid_amount) as total_paid,
    SUM(billed_amount) as total_billed,
    ROUND(SUM(paid_amount)/SUM(billed_amount),2) as paid_ratio
FROM claims
GROUP BY claim_type
ORDER BY paid_ratio;

SELECT 
	provider_id,
    SUM(paid_amount) as total_paid,
    SUM(billed_amount) as total_billed,
    ROUND(SUM(paid_amount)/SUM(billed_amount),2) as paid_ratio
FROM claims
GROUP BY provider_id
ORDER BY paid_ratio DESC, total_paid DESC;

SELECT 
	cpt_code,
    SUM(paid_amount) as total_paid,
    SUM(billed_amount) as total_billed,
    ROUND(SUM(paid_amount)/SUM(billed_amount),2) as paid_ratio
FROM claims
GROUP BY cpt_code
ORDER BY paid_ratio DESC, total_paid DESC;

# Which member age range has the most claims and highest amount paid?
SELECT
	CASE
		WHEN member_age BETWEEN 20 AND 29 THEN '20-29'
        WHEN member_age BETWEEN 30 AND 39 THEN '30-39'
        WHEN member_age BETWEEN 40 AND 49 THEN '40-49'
        WHEN member_age BETWEEN 50 AND 59 THEN '50-59'
        WHEN member_age BETWEEN 60 AND 69 THEN '60-69'
        WHEN member_age BETWEEN 70 AND 79 THEN '70-79'
        WHEN member_age BETWEEN 80 AND 89 THEN '80-89'
        WHEN member_age BETWEEN 90 AND 99 THEN '90-99'
        ELSE '100+'
	END AS member_age_range,
    COUNT(*) AS total_claims,
    ROUND(avg(paid_amount),2) as avg_paid_amount
FROM claims c JOIN members m on c.member_id = m.member_id
GROUP BY member_age_range
ORDER BY member_age_range;

# Which member plan and claim type had the highest and lowest paid ratios?
SELECT
	plan_type,
    claim_type,
    ROUND(AVG(billed_amount),2) as avg_billed_amount,
	ROUND(AVG(paid_amount),2) as avg_paid_amount,
    ROUND(AVG(paid_amount)/AVG(billed_amount),2) as avg_paid_ratio
FROM members m JOIN claims c ON m.member_id = c.member_id
GROUP BY claim_type, plan_type
ORDER BY plan_type, avg_paid_amount DESC;




