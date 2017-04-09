--Creating Table

CREATE TABLE IF NOT EXISTS temp_data(station string,date string,obs_type string,temperature int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

--Loading Data

LOAD DATA LOCAL INPATH '/home/acadgild/Downloads/Temperature.csv' OVERWRITE INTO TABLE temp_data;

-- Minimum temperature observed in a given weather station in a particular year.

SELECT YEAR(TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(date,'yyyymmdd')))) as date,MIN(temperature) AS min_temp ,station FROM 
temp_data GROUP BY YEAR(TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(date,'yyyymmdd')))),station; 

--Maximum temperature observed in a given weather station in a particular year.

SELECT YEAR(TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(date,'yyyymmdd')))) as date,MAX(temperature) AS max_temp ,station FROM 
temp_data GROUP BY YEAR(TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(date,'yyyymmdd')))),station; 

--Number of readings given by each weather station according to the dataset.

SELECT station,count(*) FROM temp_data GROUP BY station;
