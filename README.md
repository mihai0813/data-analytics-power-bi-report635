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
