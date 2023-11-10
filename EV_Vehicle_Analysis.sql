-- Selecting Unique Models and Their Counts:
-- Count the number of unique vehicle models
SELECT Model, COUNT(*) AS ModelCount
FROM electric_vehicles
GROUP BY Model
ORDER BY ModelCount DESC;

-- Filtering Electric Vehicles with Eligibility Information:
-- Select electric vehicles with eligibility information
SELECT *
FROM electric_vehicles
WHERE CAFV_Eligibility = 'Clean Alternative Fuel Vehicle Eligible';

-- Average Electric Range by Make:
-- Calculate the average electric range by make
SELECT Make, AVG(Electric_Range) AS AvgElectricRange
FROM electric_vehicles
GROUP BY Make
ORDER BY AvgElectricRange DESC;

-- Count of Electric Vehicles by County:
-- Count the number of electric vehicles by county
SELECT County, COUNT(*) AS VehicleCount
FROM electric_vehicles
GROUP BY County
ORDER BY VehicleCount DESC;

-- Find Vehicles with Low Battery Range:
-- Select vehicles with low battery range
SELECT *
FROM electric_vehicles
WHERE CAFV_Eligibility = 'Not eligible due to low battery range';

-- Calculate Total Base MSRP by Make:
-- Calculate the total base MSRP by make
SELECT Make, SUM(Base_MSRP) AS TotalBaseMSRP
FROM electric_vehicles
GROUP BY Make
ORDER BY TotalBaseMSRP DESC;

-- Count of Vehicles by Electric Utility:
-- Count the number of vehicles by electric utility
SELECT Electric_Utility, COUNT(*) AS VehicleCount
FROM electric_vehicles
GROUP BY Electric_Utility
ORDER BY VehicleCount DESC;

-- Filtering Vehicles with Unknown Eligibility:
-- Select vehicles with unknown eligibility
SELECT *
FROM electric_vehicles
WHERE CAFV_Eligibility = 'Eligibility unknown as battery range has not been researched';

-- Find Models with the Highest Electric Range:
-- Find models with the highest electric range
SELECT Model, Electric_Range
FROM electric_vehicles
ORDER BY Electric_Range DESC
LIMIT 5;

-- Calculate Average Electric Range by Electric Vehicle Type:
-- Calculate average electric range by electric vehicle type
SELECT Electric_Vehicle_Type, AVG(Electric_Range) AS AvgElectricRange
FROM electric_vehicles
GROUP BY Electric_Vehicle_Type
ORDER BY AvgElectricRange DESC;

-- Calculate the Total Base MSRP and Average Electric Range for Each Make and Model Combination:
-- Calculate total base MSRP and average electric range for each make and model combination
SELECT Make, Model, COUNT(*) AS ModelCount, SUM(Base_MSRP) AS TotalBaseMSRP, AVG(Electric_Range) AS AvgElectricRange
FROM electric_vehicles
GROUP BY Make, Model
ORDER BY ModelCount DESC, TotalBaseMSRP DESC;

-- Identify Models with the Highest Total Base MSRP and Average Electric Range:
-- Identify models with the highest total base MSRP and average electric range
WITH ModelStats AS (
    SELECT Model, COUNT(*) AS ModelCount, SUM(Base_MSRP) AS TotalBaseMSRP, AVG(Electric_Range) AS AvgElectricRange
    FROM electric_vehicles
    GROUP BY Model
)
SELECT Model, ModelCount, TotalBaseMSRP, AvgElectricRange
FROM ModelStats
ORDER BY TotalBaseMSRP DESC, AvgElectricRange DESC
LIMIT 5;

-- Calculate the Percentage of Electric Vehicles Eligible for Clean Alternative Fuel by County:
-- Calculate the percentage of electric vehicles eligible for clean alternative fuel by county
SELECT County, 
       COUNT(*) AS TotalVehicles,
       SUM(CASE WHEN CAFV_Eligibility = 'Clean Alternative Fuel Vehicle Eligible' THEN 1 ELSE 0 END) AS EligibleVehicles,
       (SUM(CASE WHEN CAFV_Eligibility = 'Clean Alternative Fuel Vehicle Eligible' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS PercentageEligible
FROM electric_vehicles
GROUP BY County
ORDER BY PercentageEligible DESC;

-- Find the Top 5 Legislative Districts with the Highest Average Electric Range:
-- Find the top 5 legislative districts with the highest average electric range
SELECT Legislative_District, AVG(Electric_Range) AS AvgElectricRange
FROM electric_vehicles
GROUP BY Legislative_District
ORDER BY AvgElectricRange DESC
LIMIT 5;

-- Identify Models and Makes with Low Battery Range but High Base MSRP:
-- Identify models and makes with low battery range but high base MSRP
SELECT Make, Model, Base_MSRP, Electric_Range
FROM electric_vehicles
WHERE CAFV_Eligibility = 'Not eligible due to low battery range' AND Base_MSRP > 50000
ORDER BY Base_MSRP DESC;
