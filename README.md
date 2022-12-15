# Airline-Passenger-Satisfaction-System
<!--CONTENT-->
<details>
  <summary>Contents</summary>
  <ol>
    <li>About The Project</li>
    <li>Scope of the Project</li>
    <li>Scope of the Project</li>
    <li>Data Sources</li>
    <li>System Requirements</li>
    <li>Python Libraries</li>
    <li>Steps To Run</li>
    <li>ER Diagram</li>
    <li>Processed Covered</li>
  </ol>  
</details>


<!-- ABOUT THE PROJECT -->
## ABOUT THE PROJECT
<ul>
<li>This project aims to determine the factors affecting the customer experience throughout the flight journey of the passengers and further provide
recommendations to improve the customer experience by analyzing the data collected.
</li>
<li>
There are various factors that play a crucial role in determining a passenger's soothing travel experience. 
</li>
<li>
Customer experience being one of them, plays an important role in determining what are the certain drawbacks that the aviation industry faces in terms of meeting the expectation of its passengers right from the time they book a flight, until they reach their destination.
</li>
<li>
The travel experience of the passengers can be defined through services such as flight booking, baggage handling, availability of the desired meal, comfortable seat allotment, washroom facility, safety assurance and many more.
</li>
</ul>

<!-- SCOPE OF THE PROJECT -->
## PROJECT SCOPE
The scope of our  project includes the following
<ul>
<li>Database design</li>
<li>Web scraping and data cleaning</li>
<li>Analyzing factors affecting customer satisfaction and experience for various airline</li>
<li>Providing suitable recommendations for improving customer experience</li>
<lu>Determining fruitful data points to analyze why an airline is succeeding/failing</li>
</ul>

<!-- DATA SOURCES -->
## DATA SOURCES
* Skytrax Website
* Kayak Website
* Twitter
* Kaggle,csv datasets

<!-- SYSTEM REQUIREMENTS -->
## SYSTEM REQUIREMENTS
* python 3.9
* pip 22.2 or above

<!-- PYTHON LIBRARIES -->
## PYTHON LIBRARIES
* Jupyter
* sqlalchemy
* pymysql
* Pandas
* numpy
* Re
* Sntwitter
* Snscrape

<!-- STEPS TO RUN -->
## STEPS TO RUN
* Run DDL commands - ./SQL/Table DDL/create_tables.sql
* Run Jupyter file to insert CSV files - ./Python Scripts/Data Ingestion Scripts/data_ingestion.ipynb
* Run insert_flight DML - ./SQL/Table DDL/insert_flight.sql
* Run views, triggers and indices - ./SQL/Table DDL/
* Run all queries - ./SQL/use_cases.sql

<!-- ER DIAGRAM-->
## ER Diagram
![image](https://user-images.githubusercontent.com/53204171/207755917-e2c2286e-51ca-495b-b4be-73117493f76d.png)


<!-- PROCESS COVERED -->
## PROCESS COVERED
* Data for passenger reviews extracted from Skytrax Website.
* Python script written in Jupyter notebookto extract data using python library Beautiful Soup,
Scrapy, Selenium.
* Flight Details and information extracted from Kayak Website.
* Further Datasets collected from GitHub, Kaggle and other sources.
* Jupyter Scripts created to cleaning, munging the extracted data.
* Script created to populate data collected after scrapping to the Airline Database.

