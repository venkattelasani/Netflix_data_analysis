# Netflix Data Analysis Using MySQL

## Project Overview
This project focuses on analyzing Netflix's dataset to uncover insights about the platform’s content distribution, trends, and catalog management using MySQL. The dataset contains details about movies and TV shows, including cast, country, release year, rating, and more.  
The primary goal is to clean, transform, and analyze this dataset to derive meaningful business insights and improve data-driven decision-making.

## Business Problem
Netflix, as a global streaming platform, continuously adds, removes, and promotes titles based on viewer engagement, regional preferences, and content performance.  
However, with thousands of titles across multiple countries, understanding content trends, viewer demographics, and catalog composition becomes challenging without structured data analysis.

This project addresses the following business problems:

1. **Content Strategy Optimization:** Identify which types of content (Movies vs TV Shows), genres, and ratings dominate the platform.
2. **Regional Insights:** Analyze which countries contribute the most to Netflix’s content library and how preferences differ.
3. **Content Release Trends:** Understand how Netflix’s catalog has evolved over time.
4. **Director and Genre Analysis:** Determine which directors or genres contribute most to Netflix’s diversity.
5. **Data Quality and Catalog Management:** Identify missing, inconsistent, or duplicate records that may affect reporting accuracy.

## Objectives
1. Clean and preprocess Netflix data for MySQL analysis.
2. Detect and handle missing or duplicate values.
3. Perform exploratory analysis using SQL queries.
4. Derive insights to support business and data decisions.

## Dataset Description
- **Source:** [Netflix Shows Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows)
- **File:** `netflix_titles.csv`
- **Attributes:** show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description.

## Tools and Technologies
- MySQL for database management and querying
- Python (Pandas) for initial data cleaning and transformation
- Excel/CSV for dataset handling
- GitHub for version control and portfolio presentation

## Data Preparation Steps
1. Download the dataset from Kaggle.
2. Clean data using Python or Excel (remove missing, duplicate, or inconsistent records).
3. Import the dataset into MySQL using the following command:

```sql
LOAD DATA INFILE 'path/netflix_titles.csv'
INTO TABLE netflix_titles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

4. Validate data types and constraints.

## Data Cleaning Overview
- Removed duplicate rows using `DISTINCT` and `ROW_NUMBER()`.
- Replaced null or missing values in important columns.
- Standardized categorical values (e.g., “TV Show”, “Movie”).
- Ensured consistent date formats for `date_added`.

## Analysis and Insights

### Basic Level Questions
1. **How many movies and TV shows are there on Netflix?**
   ```sql
   SELECT type, COUNT(*) AS total_count
   FROM netflix_titles
   GROUP BY type;
   ```
   **Insight:** Helps understand Netflix's focus between movies and series.

2. **What are the top 5 countries with the most titles?**
   ```sql
   SELECT country, COUNT(*) AS total_titles
   FROM netflix_titles
   GROUP BY country
   ORDER BY total_titles DESC
   LIMIT 5;
   ```
   **Insight:** Identifies top content-producing regions.

3. **How many titles were released each year?**
   ```sql
   SELECT release_year, COUNT(*) AS total_releases
   FROM netflix_titles
   GROUP BY release_year
   ORDER BY release_year;
   ```

### Intermediate Level Questions
1. **Which director has the highest number of titles on Netflix?**
   ```sql
   SELECT director, COUNT(*) AS total_titles
   FROM netflix_titles
   WHERE director IS NOT NULL
   GROUP BY director
   ORDER BY total_titles DESC
   LIMIT 1;
   ```

2. **Which country has produced the most TV Shows?**
   ```sql
   SELECT country, COUNT(*) AS total_shows
   FROM netflix_titles
   WHERE type = 'TV Show'
   GROUP BY country
   ORDER BY total_shows DESC
   LIMIT 1;
   ```

3. **Find the most common rating across all titles.**
   ```sql
   SELECT rating, COUNT(*) AS total
   FROM netflix_titles
   GROUP BY rating
   ORDER BY total DESC
   LIMIT 1;
   ```

4. **Which year had the most releases of Netflix Originals?**
   ```sql
   SELECT release_year, COUNT(*) AS total_titles
   FROM netflix_titles
   WHERE title LIKE '%Netflix%'
   GROUP BY release_year
   ORDER BY total_titles DESC
   LIMIT 1;
   ```

5. **Find titles released in more than one country.**
   ```sql
   SELECT title, country
   FROM netflix_titles
   WHERE country LIKE '%,%';
   ```

## Key Insights Summary
- The majority of titles are **Movies**, not TV Shows.
- The **United States, India, and the United Kingdom** dominate content production.
- The number of Netflix titles increased significantly post-2015.
- Most common rating: **TV-MA**, indicating adult-oriented content.

## Future Enhancements
- Integrate Tableau or Power BI for interactive visualization.
- Automate ETL pipeline using Python and Airflow.
- Build a dashboard for genre-wise and year-wise insights.

## Suggested Folder Structure
```
netflix-data-analysis/
│
├── data/
│   └── netflix_titles.csv
│
├── sql/
│   ├── data_cleaning.sql
│   ├── basic_analysis.sql
│   └── intermediate_analysis.sql
│
├── README.md
└── results/
    └── analysis_summary.txt
```

---