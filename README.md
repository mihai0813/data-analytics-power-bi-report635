# README
## Importing Data into Power BI
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

## Data Model & Star Schema
### Date Table
I created this table using the CALENDAR function making it sure it includes all dates from the start of the year of the first order date to the end of the year of the latest shipping date in the Orders table.
I then added different columns using DAX formulas:

- `day_of_week = WEEKDAY('Dates Table'[date],2)`
- `month_name = FORMAT('Dates Table'[date],"MMMM")`
- `month_number = MONTH('Dates Table'[date])`
- `quarter = QUARTER('Dates Table'[date])`
- `year = YEAR('Dates Table'[date])`
- `start_of_year = STARTOFYEAR('Dates Table'[date])`
- `start_of_quarter = STARTOFQUARTER('Dates Table'[date])`
- `start_of_month = STARTOFMONTH('Dates Table'[date])`
- `start_of_week = 'Dates Table'[date] - WEEKDAY('Dates Table'[date],2) + 1`

### Star Schema & Measures Table
I created the relationships between the different tables and added a Measures Table.
![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/e181388d-3b2f-4c6e-b51b-a10bb15e3ac7)
### Key Measures
I used DAX formulas to create important measures that are going to be used later on:

- `Total Orders = COUNTROWS('Orders')`
- `Total Revenue = SUMX(Orders, Orders[product_quantity] * RELATED(Products[sale_price]))`
- `Total Profit = SUMX(Orders, Orders[product_quantity] * (RELATED(Products[sale_price]) - RELATED(Products[cost_price])))`
- `Total Customers = DISTINCTCOUNT(Orders[user_id])`
- `Total Quantity = SUM(Orders[product_quantity])`
- `Revenue YTD = TOTALYTD('Measures Table'[Total Revenue], Orders[order_date])`
- `Profit YTD = TOTALYTD('Measures Table'[Total Profit], Orders[order_date])`

### Date & Geography Hierarchies
I created the following date hierarchy to allow drill-down in future line charts.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/e9bf52da-c388-4d52-9695-1f9c8b36ed3a)

I then created the following columns in the Stores table using DAX formulas:

- `country = IF(Stores[country_code] = "GB", "United Kingdom", IF(Stores[country_code] = "US", "United States", "Germany"))`
- `world_region = IF(Stores[country_code] = "GB", "Europe", IF(Stores[country_code] = "US", "North America", "Europe"))`
- `geography = CONCATENATE(Stores[country_region] & ", ", Stores[country])`

These columns were used to create the geography hierarchy which allows the data to be filtered by region, country & country region.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/0132c7b4-5759-4ce9-9300-67954b08adb2)

## Creating Report Pages
This milestone only included creating the 4 pages of the report along with creating space for a future navigation bar:

- Executive Summary
- Customer Detail
- Product Detail
- Stores Map

## Customer Detail Page

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/db9ac652-ad45-4631-990b-cc45648955cb)

### Card Visuals

- Unique Customers: This visual uses the Total Customers measure to display the number of unique customers.
- Revenue per Customer: This required creating a new measure which divides the Total Revenue measure by the Total Customers measure.

### Charts

- Total Customers by Product Category: This is a bar chart with category from the Products table on the X-axis and the Total Customers measure on the Y-axis which shows the number of customers buying products from each category.
- Total Customers by Country: This is a donut chart with country from the Customers table and the Total Customers measure which shows the percentage of customers from each country.
- Customers Trending: This is a line chart which uses the Date Hierarchy on the X-axis (excluding start of week & date) and the Total Customers measure on the Y-axis. In additon this chart has a trend line and forecast.

### Top 20 Customers Table & Date Slicer

- Top 20 Customers by Revenue: This table contains the full_name column from the Customers table, along with the Total Revenue & Total Orders measures. The table has been filtered to show only the top 20 customers by the Total Revenue measure.
- Date Slicer: This is a data slicer by Year which uses a slider. The user can use this to see data for the other visuals for a specific time period.

### Top Customer Card Visuals

- Top Customer by Revenue: This card displays the full name of the customer which generated the most revenue, taken from the full_name column in the Customers Table. This card uses a new measure to display this information.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/fec015f4-cde9-41c3-a569-1dec0b14f1cc)

- Orders: This card displays the number of orders placed by the Top Customer by Revenue, taken from the Total Orders measure. This card uses a new measure to display this information.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/f3e8d46c-e2dd-42c0-99be-4dffd431e2f9)

- Revenue: This card displays the revenue generated by the Top Customer by Revenue, taken from the Total Revenue measure. This card uses a new measure to display this information.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/7a288acc-f61e-46aa-a976-4b4b060c01b3)

## Executive Summary Page

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/700816ab-bfeb-4281-92e8-09b4660155a1)

### Card Visuals

- Total Revenue: This visual displays the Total Revenue measure.
- Total Profit: This visual displays the Total Profit measure.
- Total Orders: This visual displays the Total Orders measure.

### Charts

- Total Revenue by Country: This is a donut chart with country from the Stores table and the Total Revenue measure which shows the proportion of revenue from each country.
- Total Revenue by Store Type: This is a donut chart with store_type from the Stores table and the Total Revenue measure which shows the proportion of revenue from each store type.
- Total Orders by Product Category: This is a bar chart with category from the Products table on the Y-axis and the Total Orders measure on the X-axis which shows the number of orders for each product category.
- Customers Trending: This is a line chart which uses the Date Hierarchy on the X-axis (excluding start of week & date) and the Total Customers measure on the Y-axis. In additon this chart has a trend line and forecast.

### Top 10 Products Table
Top 10 Products by Orders: This table contains the description & category columns from the Products table, along with the Total Revenue, Total Customers & Total Orders measures. The table has been filtered to show only the top 10 products by the Total Orders measure.

### KPI Visuals
I've created Quarterly Revenue, Profit & Orders KPI visuals. These display the values for the previous quarter along with the target values and the percentage difference between these. 
This required creating Previous Quarter & Target Revenue/Profit/Orders measures.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/1ba05131-360c-4bc8-8a94-c2f34a8b7845)

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/f2eed5f1-6489-4d3e-af2f-8f1aef2622af)

## Product Detail Page

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/8038c4ef-a187-45ea-943b-02ab36a54661)

### Gauge Visuals
I've added three Gauge Visuals to display Quarterly Revenue, Quarterly Profit & Quarterly Orders against a 10% growth target. New DAX measures were created to calculate the targets. In addition new "Gauge Colour" measures were created to use conditional formatting on the visuals in order to display the value as red when it's below the target or green when it's above the target.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/b3abde8c-0f45-4038-8c4d-cc278674b2ce)

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/f0f81f41-f717-4963-bc17-cf1f0b65af60)

### Charts

- Total Revenue by Start of Quarter & Category: This is an area chart showing the revenue of the different categories of products, with time on the X-axis & revenue on the Y-axis.
- Orders vs Profitability: This is a scatter graph with Profit per Order on the X-axis and Total Quantity (of products sold) on the Y-axis. This shows the  profitability of each product.

### Top 10 Products Table
Top 10 Products by Revenue: This table contains the description & category columns from the Products table, along with the Total Revenue, Total Customers & Total Orders measures. The table has been filtered to show only the top 10 products by the Total Revenue measure.

## Stores Map Page

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/962bb3f8-227a-4c17-beee-14162489183c)

On this page I added a map that shows the locations of the stores, to achieve this the visual uses the geography hierarchy created previously as the location and the bubble size is based on the Profit YTD Measure.
In addition, I added a tile style slicer which allows users to select a specific country and only be shown the stores in that perticular country on the map.

### Stores Drillthrough Page

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/0f3bdc92-340d-467f-8ee2-ca5e62cf2c11)

This page allows users to select a particular location and see more specific data. This page uses the following visuals:

- Card Visual: This displays the store location, taken from the Stores Table.
- Top 5 Products by Profit YTD: This table contains the description column from the Products Table, along with the Profit YTD, Total Orders & Total Revenue measures. The table has been filtered to show only the top 10 products by the Profit YTD measure.
- Total Orders by Product Category: This is a column chart that shows the total orders on the Y-axis for every category of products on the X-axis.
- Gauge Visuals - Revenue/Profit YTD & Targets: These visuals use new measures to display a target value of 20% year on year growth, the value field shows the Revenue/Profit YTD measures.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/32ee9bf9-1dad-4d55-a0db-489f43044a99)

### Stores Tooltip Page

Finally, I created a Stores Tooltip Page to be used as a tooltip for the Stores Map visual. This contains the Profit YTD vs Goal gauge visual from the drillthrough page and allows users to see relevant data by hovering over any store on the map.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/437103f7-33ba-4519-b6bd-1701ca10d91b)

## Cross-filtering & Report Navigation

I edited cross filtering between visuals as follows:

- Executive Summary Page: Total Orders by Category bar chart and Top 10 Products table don't filter the KPI or card visuals.
- Customer Detail Page: Top 20 Customers table does not filter any of the visuals. The Total Customers by Product Category bar chart does not affect the Customers Trending line chart. The Total Customers by Country chart cross-filters the Total Customers by Product Category chart.
- Product Detail Page: The Orders vs. Profitability scatter graph and Top 10 Products table won't affect any of the other visuals.

I used the icons provided to create the navigation bar buttons, when hovered over they change colour.

![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/05db2583-fb2a-417c-8c45-bc6f41956a92)
![image](https://github.com/mihai0813/data-analytics-power-bi-report635/assets/148639573/bbbf29d1-8bd2-4f59-a5e1-af9c354a16ec)

## SQL Server - Answering Business Questions

For this milestone I connected to the SQL server of the database by using the SQLTools extentions on VScode. After this I saved the table and column names to my PC by using SQL queries.
Finally, I answered some questions using SQL queries which can be found in this repository.
