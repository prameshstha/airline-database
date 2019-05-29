/* Student Name: Pramesh Shrestha
   Student ID: 10400927
*/ 

USE Airline;
GO

/* Query 1 – Plane Finder (2 marks)
   Write a query that selects the registration number, model number, range, and total passenger capacity (first class plus economy) of all planes 
   which have a total capacity of at least 400 and a range of at least 14000kms.  Order the results by range, in descending order.
*/

-- Write Query 1 here

SELECT PD.RegistrationNo, PD.ModelNumber,PM.PlaneRange, PD.EcoCapacity+PD.FirstClassCapacity AS 'CAPACITY'
 FROM PlaneModel AS PM
  INNER JOIN PlaneDetail AS PD
   ON PM.ModelNumber=PD.ModelNumber
   WHERE PM.PlaneRange>14000
   AND PD.EcoCapacity+PD.FirstClassCapacity>400
   ORDER BY PlaneRange DESC


/* Query 2 – Flight Instance Descriptions (2.5 marks)
   Write a query that concatenates various pieces of flight instance information to form a single column that describes all flight instances in the following way: 
     “The [departure time] instance of flight [flight number] from [departure airport code] to [arrival airport code] takes [travel time in hours] hours.”

   The travel time can be calculated with the DATEDIFF function using the departure time and arrival time columns.  
   You will need to CAST/CONVERT the data type of some columns.  Using the Flight Instance View in this query is recommended.
*/

-- Write Query 2 here

SELECT Concat('The ',F.DateTimeLeave,' instance of flight ',F.FlightNo,' from ',fl.FlightDepartTo,' to ',fl.FlightArriveFrom,' takes ',
DATEDIFF(HOUR,F.DateTimeLeave,F.DateTimeArrive),' hours') AS 'Flight Instance Description'

 FROM FlightInstance AS F
 INNER JOIN Flight AS FL
 ON F.FlightNo=FL.FlightNo
 INNER JOIN PlaneDetail AS PD
 ON PD.PlaneID=F.PlaneID
 INNER JOIN PlaneModel AS PM
 ON PM.ModelNumber=PD.ModelNumber



/* Query 3 – Departing Flight Information (2.5 marks)
   Write a query that selects the flight number, arrival airport code, departure time minus one hour and model number of all upcoming flights (departure time in the future).  
   Give the columns aliases of “Flight Number”, “Destination”, “Boarding Time ” and “Plane”.  Order the results by departure time.  Using the Flight Instance View in this query is recommended.
*/

-- Write Query 3 here

SELECT F.FlightID, F.FlightDepartTo, DATEADD(HOUR,-1, FI.DateTimeLeave) 
AS 'BOARDING TIME', concat(PM.ManufacturerName,'-',PD.ModelNumber,'-',FI.FlightNo) AS PLANE
FROM Flight AS F
INNER JOIN FlightInstance AS FI
ON F.FlightID=FI.FlightNo
INNER JOIN PlaneDetail AS PD
ON PD.PlaneID=FI.PlaneID
INNER JOIN PlaneModel AS PM
ON PM.ModelNumber=PD.ModelNumber

/* Query 4 – Flight Statistics (3 marks)
   Write a query that selects the flight number, number of flight instances and total distance travelled of all flights.  Only flight instances that have already occurred 
   (i.e. ones before the current date) should be included, and your results do not need to include flights that have had no instances.
   Give all columns appropriate aliases, and order the results by the total distance in descending order.  Using the Flight Instance View in this query is recommended.
*/

-- Write Query 4 here





/* Query 5 – Attendant Comparison (3 marks)
   Write a query that selects the ID number, full name, and number of years worked for all attendants as well as the ID number, full name and number of years worked 
   of their mentor, if they have one.  Attendants with no mentor should appear in the results, but will have NULL for the mentor details.  
*/

-- Write Query 5 here






/* Query 6 – Pilot Selection (3.5 marks)
   Write a query that selects the pilot ID number and full name of all pilots who are qualified to fly plane used in flight instance 3.
   Use a subquery to determine the model of plane for flight instance 3.
*/

-- Write Query 6 here





/* Query 7 – International Flights (3.5 marks)
   Write a query that selects the flight number, the name of the country that the departure airport is in and the name of the country that the arrival airport is in
   for all international flights – i.e.  All flights where the departure airport and arrival airport are in a different country.
   This will involve multiple joins with the same table (use table aliases to make this possible).
*/

-- Write Query 7 here





/* Query 8 – Understaffed Flight Instances (4 marks)
   Write a query that selects the flight instance ID, flight number, departure time, expected number of attendants and actual number of attendants for any flight instances 
   where the actual number of attendants is less than the expected number.  See Page 8 (views.sql) for details regarding the expected number of attendants, 
   and use the information in your database to determine the number of attendants actually rostered onto the flight instance.  
   This query will involve using COUNT, GROUP BY and HAVING, and using the Flight Instance View in this query is recommended.
*/

-- Write Query 8 here



