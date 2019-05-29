USE Airline
GO
IF OBJECT_ID('FlightInstance_View', 'v') IS NOT NULL
	DROP VIEW FlightInstance_View;
GO
CREATE VIEW FlightInstance_View
AS SELECT F.InstanceID, F.FlightNo, F.PlaneID, F.PilotAboardID, F.CoPilotAboardID, F.FSM_AttendantID, F.DateTimeLeave, F.DateTimeArrive,
FL.FlightDepartTo, FL.FlightArriveFrom,
P.FirstName+' '+P.LastName AS 'PILOT',CP.FirstName+' '+CP.LastName AS 'CO-PILOT', FA.FirstName+' '+FA.LastName AS 'FSM',
PD.ModelNumber , (PD.EcoCapacity+ PD.FirstClassCapacity)/100 AS 'FLIGHT ATTENDENT NUMBER'
--SUM(PD.EcoCapacity+PD.FirstClassCapacity)AS 'SUM'
 from 
 FlightInstance AS F
INNER JOIN Flight FL
 ON FL.FlightID=F.FlightNo
INNER JOIN PlaneDetail AS PD
 ON F.PlaneID= PD.PlaneID
INNER JOIN Pilot AS P
 ON f.PilotAboardID=p.PilotID
INNER JOIN Pilot AS CP
 ON F.CoPilotAboardID=CP.PilotID
INNER JOIN FlightAttendant AS FA
 ON FA.AttendantID=F.FSM_AttendantID