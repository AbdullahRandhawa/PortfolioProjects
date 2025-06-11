This repository contains SQL projects demonstrating fundamental and intermediate data analysis, exploration, and cleaning skills using real-world datasets. These projects were completed during my SQL learning phase, focusing on practical application of database queries for data manipulation and insight generation.

Projects Included:
1. COVID-19 Data Exploration
Objective: To explore global COVID-19 death and vaccination data to uncover trends, analyze infection and death rates, and understand vaccination progress over time.

Dataset(s): CovidDeaths.xlsx, CovidVaccinations.xlsx

Key Skills Demonstrated:
Data Aggregation: Calculating sums, maximums across various dimensions (location, continent, date).

Case Studies: Analyzing specific regions (e.g., Pakistan) for detailed insights.

Rate Calculation: Deriving death percentages and infection percentages from raw data.

Table Joins: Combining data from multiple tables (CovidDeaths and CovidVaccinations) to analyze total population vs. vaccinations.

Window Functions: Implementing SUM() OVER(PARTITION BY...) for rolling calculations of vaccinations.

Common Table Expressions (CTEs) and Temp Tables: Utilizing advanced SQL features for complex multi-step queries.

View Creation: Storing complex queries as views for easy access and potential visualization.

Global vs. Continental Analysis: Summarizing data at different geographical levels.

3. Nashville Housing Data Cleaning
Objective: To clean, standardize, and transform raw housing data from the NashvilleHousing dataset using SQL queries, making it ready for analysis.

Dataset(s): Nashville Housing Data (implicitly from PortfoliProject..NashvilleHousing)

Key Skills Demonstrated:

Data Type Conversion: Standardizing date formats (CONVERT).

Handling Missing Values: Populating null property addresses using self-joins and ISNULL().

Data Parsing: Breaking out concatenated address fields into separate street and city columns using SUBSTRING and CHARINDEX.

Data Standardization: Converting inconsistent categorical values (e.g., 'Y'/'N' to 'Yes'/'No') using CASE statements.

Duplicate Removal: Identifying and eliminating duplicate records using ROW_NUMBER() and CTEs.

Column Management: Adding and dropping columns to refine the dataset structure.

Technologies Used:
SQL (Transact-SQL): For all data querying, manipulation, and transformation.
SQL Server Management Studio (SSMS): (Implied, as commonly used for T-SQL execution)
