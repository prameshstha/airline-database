/* 
	Unit:CSI 5135- Systems and Database Design
	Assignment 2 Task 2: Implementation
	Year: 2016
	Semester: 2
	Student Name: Pramesh Shrestha
	Student ID: 10400927
*/ 
/* Flight Instance View (6 marks)
   Create a view which shows the following details of all flight instances:
     • All of the columns in the flight instance table.

     • The departure airport code, arrival airport code and distance of the flight.

     • The full name of the pilot, co-pilot and flight service manager.
        - Concatenate the first name and last name into one column, e.g. “Joe Bloggs”.

     • The model number of the plane.

     • A column with an alias of “expected_attendants”, which will contain the number of attendants which are expected to be on board based upon the capacity of the plane.
        - The column should calculate this by adding together the plane’s first class capacity and economy capacity and dividing the total by 100 .

   Creating this view will require joining the flight instance table to the flight table, the plane table, the attendant table, and the pilot table (twice) – a total of 5 joins.
   This view serves as a very convenient replacement for the flight instance table, as it includes the relevant details from numerous other tables – use this view in queries that need this data!
   
   When writing a view, it is easiest to write the SELECT statement first, and only add the CREATE VIEW statement to the beginning once you have confirmed that the SELECT statement is working correctly.
*/

-- Write your Flight Instance View here
--This statement involve joining FlightInstace, Flight, PlaneDetail, Pilot two times for pilot and co-pilot, FlightAttendant tables.

USE Airline
GO
IF OBJECT_ID('FlightInstance_View') IS NOT NULL
DROP VIEW FlightInstance_View;
GO
CREATE VIEW FlightInstance_View
AS SELECT F.InstanceID, F.FlightNo, F.PlaneID, F.PilotAboardID, F.CoPilotAboardID, F.FSM_AttendantID, F.DateTimeLeave, F.DateTimeArrive,
FL.FlightDepartTo, FL.FlightArriveFrom,
P.FirstName+' '+P.LastName AS 'PILOT',CP.FirstName+' '+CP.LastName AS 'CO-PILOT', FA.FirstName+' '+FA.LastName AS 'FSM',
PD.ModelNumber , (PD.EcoCapacity+ PD.FirstClassCapacity)/100 AS 'EXPECTED ATTENDENT'

 FROM 
 FlightInstance AS F
INNER JOIN Flight FL
 ON FL.FlightNo=F.FlightNo
INNER JOIN PlaneDetail AS PD
 ON F.PlaneID= PD.PlaneID
INNER JOIN Pilot AS P
 ON f.PilotAboardID=p.PilotID
INNER JOIN Pilot AS CP
 ON F.CoPilotAboardID=CP.PilotID
INNER JOIN FlightAttendant AS FA
 ON FA.AttendantID=F.FSM_AttendantID








/* Additional Information:
   The views essentially create “flat” versions of the main tables of the database, giving you a convenient way to access all details, including those that are stored in other tables.  
   You are encouraged to use the views to simplify the queries which follow - You can use a view in a SELECT statement in exactly the same way as you can use a table – often avoiding the need to write the same JOINs over and over.  

   If you wish to create additional views to simplify the queries which follow, include them in this file.
*/