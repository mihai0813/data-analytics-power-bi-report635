# README
## Milestone 2: Import the Data Into Power BI
This milestone involved importing some tables into Power BI using different methods.
### Orders Table
This table was imported from an Azure SQL Database, I first connected to the batabase and then selected the table I wanted.
Then I used the Power Query Editor to perform some transformations.
This included deleting the card_number column & using the Split Column feature to seperate the order_date & shipping_date into individual date and time columns.
In the end, I removed rows which had null order dates & renamed the columns to follow naming conventions.
### Products Table
This table was imported from a csv file on my device. I first removed duplicates from the product_code column so there were only unique entries.
Then I used the Power Query Editor to split the weight columns into two, one named weight_value with the number and another named weight_unit with the unit used.
I did this using the Column From Examples feature. Then I created a new calculated column, which contains the weight of the products in kg.
In the end I deleted the original weight column as it was no longer needed and renamed columns as required.
### Stores Table
This table was imported from an Azure Blob Storage, I first connected to this then I selected the Stores.csv file from the container. 
The only transformation carried out here was renaming the columns to follow conventions.
### Customers Table
This table was imported by first importing a folder on my device which contained three different (one for each region) csv files with the same columns.
Power BI then combined the three tables into one. 
Following this I combined the first_name and last_name columns into one full_name column using the Column From Examples feature.
Then I removed the columns which were no longer needed and renamed columns as necessary.
## Milestone 3: Create the Data Model
### Date Table
I created this table using the CALENDAR function making it sure it includes all dates from the start of the year of the first order date to the end of the year of the latest shipping date in the Orders table.
I then added different columns using DAX formulas:

- day_of_week = WEEKDAY('Dates Table'[date],2)
- month_name = FORMAT('Dates Table'[date],"MMMM")
- month_number = MONTH('Dates Table'[date])
- quarter = QUARTER('Dates Table'[date])
- year = YEAR('Dates Table'[date])
- start_of_year = STARTOFYEAR('Dates Table'[date])
- start_of_quarter = STARTOFQUARTER('Dates Table'[date])
- start_of_month = STARTOFMONTH('Dates Table'[date])
- start_of_week = 'Dates Table'[date] - WEEKDAY('Dates Table'[date],2) + 1

### Star Schema & Measures Table
I created the relationships between the different tables and added a Measures Table.
![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/e181388d-3b2f-4c6e-b51b-a10bb15e3ac7)
### Key Measures
I used DAX formulas to create important measures that are going to be used later on:

- Total Orders = COUNTROWS('Orders')
- Total Revenue = SUMX(Orders, Orders[product_quantity] * RELATED(Products[sale_price]))
- Total Profit = SUMX(Orders, Orders[product_quantity] * (RELATED(Products[sale_price]) - RELATED(Products[cost_price])))
- Total Customers = DISTINCTCOUNT(Orders[user_id])
- Total Quantity = SUM(Orders[product_quantity])
- Revenue YTD = TOTALYTD('Measures Table'[Total Revenue], Orders[order_date])
- Profit YTD = TOTALYTD('Measures Table'[Total Profit], Orders[order_date])

### Date & Geography Hierarchies
I created the following date hierarchy to allow drill-down in future line charts.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/e9bf52da-c388-4d52-9695-1f9c8b36ed3a)

I then created the following columns in the Stores table using DAX formulas:

- country = IF(Stores[country_code] = "GB", "United Kingdom", IF(Stores[country_code] = "US", "United States", "Germany"))
- world_region = IF(Stores[country_code] = "GB", "Europe", IF(Stores[country_code] = "US", "North America", "Europe"))
- geography = CONCATENATE(Stores[country_region] & ", ", Stores[country])

These columns were used to create the geography hierarchy which allows the data to be filtered by region, country & country region.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/0132c7b4-5759-4ce9-9300-67954b08adb2)

## Milestone 4: Set up the report
This milestone only included creating the 4 pages of the report along with creating space for a future navigation bar:

- Executive Summary
- Customer Detail
- Product Detail
- Stores Map

