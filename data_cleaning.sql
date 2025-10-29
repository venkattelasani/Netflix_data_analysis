-- Netflix Data Cleaning SQL Script
-- ----------------------------------------------------
-- Step 1: Remove duplicate records
DELETE FROM netflix_titles
WHERE show_id IN (
    SELECT show_id FROM (
        SELECT show_id, ROW_NUMBER() OVER (PARTITION BY title, type ORDER BY show_id) AS rn
        FROM netflix_titles
    ) t WHERE t.rn > 1
);

-- Step 2: Handle missing values
-- Example: Replace NULL country values with 'Unknown'
UPDATE netflix_titles
SET country = 'Unknown'
WHERE country IS NULL;

-- Step 3: Standardize date formats
-- Example: Update inconsistent date formats if any
-- UPDATE netflix_titles SET date_added = STR_TO_DATE(date_added, '%M %d, %Y');

-- Step 4: Extract year and month from date_added
-- ALTER TABLE netflix_titles ADD COLUMN year_added INT;
-- ALTER TABLE netflix_titles ADD COLUMN month_added VARCHAR(20);
-- UPDATE netflix_titles SET year_added = YEAR(date_added), month_added = MONTHNAME(date_added);

-- Step 5: Clean text data (trim spaces, lowercasing)
-- UPDATE netflix_titles SET listed_in = LOWER(TRIM(listed_in));
