
/* 
	Unit:CSI 5135- Systems and Database Design
	Assignment 2 Task 2: Implementation
	Year: 2016
	Semester: 2
	Student Name: Pramesh Shrestha
	Student ID: 10400927
*/   

/*	Database Creation & Population Script (8 marks)
	Produce a script to create the database you designed in Task 1 (incorporating any changes you have made since then).  
	Be sure to give your columns the same data types, properties and constraints specified in your data dictionary, and be sure to name tables and columns consistently.  
	Include any logical and correct default values and any check or unique constraints that you feel are appropriate.

	Make sure this script can be run multiple times without resulting in any errors (hint: drop the database if it exists before trying to create it).  
	You can use/adapt the code at the start of the creation scripts of the sample databases available in the unit materials to implement this.

	See the assignment brief for further information. 
*/

-- Write your creation script here

IF DB_ID('Airline') IS NOT NULL
	BEGIN
		PRINT 'Database exists - dropping.';

		USE master;
		ALTER DATABASE Airline SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		
		DROP DATABASE Airline;
	END

GO


--  Now that we are sure the database does not exist, we create it.

PRINT 'Creating database.';

CREATE DATABASE Airline;

GO

--  Now that an empty database has been created, we will make it the active one.
--  The table creation statements that follow will therefore be executed on the newly created database.

USE Airline;

GO


--  **************************************************************************************
--  We now create the tables in the database.
--  **************************************************************************************


--  **************************************************************************************
--  Create the PlaneModel table to hold information of plane model.

PRINT 'Creating PlaneModel table...';

CREATE TABLE PlaneModel
( ModelNumber	VARCHAR(10) NOT NULL, 
  ManufacturerName	VARCHAR(50) NOT NULL,
  PlaneRange SMALLINT NOT NULL,
  CruiseSpeed SMALLINT NOT NULL
  
  CONSTRAINT ModelN_pk PRIMARY KEY (ModelNumber)
);


--  **************************************************************************************
--  Create the Pilot table to hold information of pilot.


PRINT 'Creating Pilot table...';

CREATE TABLE Pilot
( PilotID	 INT NOT NULL IDENTITY, 
  FirstName	 VARCHAR(50) NOT NULL,
  LastName   VARCHAR(50) NOT NULL,
  DOB		 DATE NOT NULL,
  HoursFlown SMALLINT NOT NULL
  
  CONSTRAINT PilotId_pk PRIMARY KEY (PilotID)
);


--  **************************************************************************************
--  Create the PlanePilot table to hold information of Plane and Pilot.


PRINT 'Creating PlanePilot...';

CREATE TABLE PlanePilot
( PlaneModel	VARCHAR(10) NOT NULL, 
  PilotID		INT NOT NULL
  
  CONSTRAINT PlaneModel_fk FOREIGN KEY(PlaneModel) REFERENCES PlaneModel(ModelNumber),
  CONSTRAINT PilotID_fk FOREIGN KEY(PilotID) REFERENCES Pilot(PilotID),
  CONSTRAINT planePilot_pk PRIMARY KEY (PilotID, PlaneModel),
);


--  **************************************************************************************
--  Create the PlaneDetail table to hold information of plane.


PRINT 'Creating PlaneDetail...';

CREATE TABLE PlaneDetail
( PlaneID			INT NOT NULL IDENTITY, 
  ModelNumber		VARCHAR(10) NOT NULL,
  RegistrationNo    VARCHAR(10) NOT NULL,
  BuiltYear			SMALLINT NOT NULL,
  FirstClassCapacity SMALLINT NOT NULL,
  EcoCapacity		SMALLINT NOT NULL,
  
  CONSTRAINT PlaneId_pk PRIMARY KEY (PlaneID),
  CONSTRAINT ModelN_fk FOREIGN KEY (ModelNumber) REFERENCES PlaneModel(ModelNumber),
  CONSTRAINT RegNO_uk UNIQUE (RegistrationNo)
);


--  **************************************************************************************
--  Create the Country table to hold information of country.


PRINT 'Creating Country...';

CREATE TABLE Country 
( CountryName	VARCHAR(50) NOT NULL, 
  CountryCode	CHAR(3) NOT NULL, 
  
  CONSTRAINT country_pk PRIMARY KEY (CountryCOde),
  CONSTRAINT Country_name_uk UNIQUE (CountryName)
);


--  **************************************************************************************
--  Create the Airport table to hold information of airport.


PRINT 'Creating Airport table...';

CREATE TABLE Airport
( AirportCode    CHAR(3) NOT NULL PRIMARY KEY,
  AirportName	 VARCHAR(50) NOT NULL,
  ContactNo		 NUMERIC(18,0) NOT NULL,
  Longitude		 FLOAT NOT NULL,
  Latitude		 FLOAT NOT NULL,
  CountryCode    CHAR(3) NOT NULL,
  CONSTRAINT CountryCode_fk FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode)
  
);
 
 

--  **************************************************************************************
--  Create the Flight table to hold information of flight.


PRINT 'Creating Flight table...';

CREATE TABLE Flight
( FlightNo			VARCHAR(10) NOT NULL,
  FlightDepartTo	CHAR(3) NOT NULL,
  FlightArriveFrom	CHAR(3) NOT NULL,
  Distance			INT NOT NULL,
  
  CONSTRAINT FlightNo_pk PRIMARY KEY (FlightNo),
  CONSTRAINT FLightDepartTo_fk FOREIGN KEY (FlightDepartTo) REFERENCES Airport(AirportCode),
  CONSTRAINT FLightArriceFrom_fk FOREIGN KEY (FlightArriveFrom) REFERENCES Airport(AirportCode),
  CONSTRAINT FlightArriveFrom CHECK (FlightArriveFrom != FlightDepartTo)
);


--  **************************************************************************************
--  Create the FlightAttendant table to hold information of flight attendant.


PRINT 'Creating FlightAttendant table...';

CREATE TABLE FlightAttendant
( AttendantID    INT NOT NULL IDENTITY,
  FirstName		 VARCHAR(50) NOT NULL,
  LastName       VARCHAR(50) NOT NULL,
  DOB			 DATE NOT NULL,
  HireDate		 DATE NOT NULL,
  MentorID		 INT NULL,
  
  CONSTRAINT attendantID_pk PRIMARY KEY (AttendantID),
  CONSTRAINT mentorID_fk FOREIGN KEY (MentorID) REFERENCES FlightAttendant(AttendantID), 
);


--  **************************************************************************************
--  Create the FlightInstance table to hold information of flight instance.



PRINT 'Creating FlightInstance table...';

CREATE TABLE FlightInstance
( InstanceID		INT NOT NULL IDENTITY,
  FlightNo			VARCHAR(10) NOT NULL,
  PlaneID			INT NOT NULL,
  PilotAboardID	    INT NOT NULL,
  CoPilotAboardID	INT NOT NULL,
  FSM_AttendantID   INT NOT NULL,
  DateTimeLeave		DATETIME NOT NULL,
  DateTimeArrive    DATETIME NOT NULL,
  
  
  CONSTRAINT InstanceId_pk PRIMARY KEY (InstanceID),
  CONSTRAINT FlightNo_fk FOREIGN KEY (FlightNo) REFERENCES Flight(FlightNo),
  CONSTRAINT PlaneID_fk FOREIGN KEY (PlaneID) REFERENCES PlaneDetail(PlaneID),
  CONSTRAINT PilotAboardId_fk FOREIGN KEY (PilotAboardID) REFERENCES Pilot(PilotID),
  CONSTRAINT CoPilotAboardId_fk FOREIGN KEY (CoPilotAboardID) REFERENCES Pilot(PilotID),
  CONSTRAINT FSM_AttendantID FOREIGN KEY (FSM_AttendantID) REFERENCES FlightAttendant(AttendantID),   
  CONSTRAINT CoPilodAboardId_fk CHECK (CoPilotAboardId !=PilotAboardID),
  CONSTRAINT DateTimeArrive_ck CHECK (DateTimeArrive > DateTimeLeave)
);


--  **************************************************************************************
--  Create the Pilot InstanceAttendant to hold information of instance attendant.

--  This table has a compound primary key consisting of the InstanceID and AttendantID columns.

PRINT 'Creating InstanceAttendant table...';
CREATE TABLE InstanceAttendant
( InstanceID	INT NOT NULL,
  AttendantID   INT NOT NULL,
  
  CONSTRAINT InstanceAttendantID_pk PRIMARY KEY (InstanceID, AttendantID),
  CONSTRAINT InstanceId_fk FOREIGN KEY (InstanceID) REFERENCES FlightInstance(InstanceID),
  CONSTRAINT AttendantId_fk FOREIGN KEY (AttendantID) REFERENCES FlightAttendant(AttendantID)
) ;

--  **************************************************************************************
--  Now that the database tables have been created, we can populate them with data
--  **************************************************************************************

--  **************************************************************************************


/*  Database Population Statements

    Add the INSERT statements you write to the end of the create.sql file as you work through the views and queries.  
    The final create.sql should be able to create your database and populate it with enough data to make sure that all
	views and queries return meaningful results.
*/

-- Write your insert statements here



--  Populate the region PlaneModel.

PRINT 'Populating PlaneModel table...';

INSERT INTO PlaneModel 
VALUES ('A380','Airbus','15700','900'), 
		('A300','Airbus','13450','871'), 
		('A340','Airbus','12400','881'), 
		('A390','Airbus','17400','1081'),
		('737','Boeing','5600','780'), 
		('777','Boeing','10000','892'),
		('779','Boeing','17000','922'),
		('787','Boeing','15000','903');


--  **************************************************************************************
--  Populate the Pilot table.
--  Since the primary key uses IDENTITY, we don't specify a value for that column.
PRINT 'Populating Pilot table...';

INSERT INTO Pilot 
VALUES ('Pramesh', 'Shrestha', '1989-04-25',5),
		('Maila', 'Battard', '2002-11-15',10),
		('Tom', 'Hardy', '1977-09-15',39),
		('Leonardo', 'DiCaprio', '1974-11-11',85),
		('Huge', 'Glass', '1980-08-22',9),
		('John', 'Fitzgerald', '1979-09-18',77),
		('Jennifer', 'Whalen','1987-09-17',10),
       ('Michael', 'Hartstein','1996-02-17',18),
		('Steven', 'King','1987-06-17', 60);


--  **************************************************************************************
--  Populate the PlaneDetail table.
--  Since the primary key uses IDENTITY, we don't specify a value for that column.

PRINT 'Populating PlaneDetail table...';

INSERT INTO PlaneDetail
VALUES ('A390','AU-1989',1989,50,50),
	   ('A380','AU-2000',2000,100,200), 
		('A300','AU-1970',1970,200,350), 
		('A340','AU-1880',1880,310,420), 
		('A390','AU-1990',1990,110,230),
		('737','BO-2001',2001,40,120), 
		('777','BO-1990',1990,155,450),
		('779','BO-2002',2002,121,244),
		('787','BO-2005',2005,195,340),
		('787','BO-2005-1',2005,95,140);


--  **************************************************************************************
--  Populate the PlanePilot table.

PRINT 'Populating PlanePilot table...';

INSERT INTO PlanePilot 
VALUES ('777',1),
	   ('A390',2),
	   ('A380',3),
	   ('777',3),
	   ('787',5),
	   ('787',6),
	   ('A340',1),
	   ('A340',3),
	   ('A340',4),
	   ('A340',2),
	   ('A340',8),
	   ('A340',9),
	   ('737',1),
	   ('779',4)
	   ; 




--  **************************************************************************************
--  Populate the Country table.

PRINT 'Populating Country table...';

INSERT INTO Country 
VALUES ('Australia','AUS'),
		('Austria','AUT'),
		('Brazil','BRA'),
		('Belgium','BEL'),
		('Canada','CAN'),
		('China','CHN'),
		('Nepal','NPl'),
		('Germany','GER'),
		('England','ENG'),
		('Spain','ESP'),
		('Portugal','POR'),
		('Sweden','SWE'),
		('New Zealand','NZL'),
		('United Arab Emirates', 'UAE'),
		('United States of America','USA');
       

--  **************************************************************************************
--  Populate the Airport table.

PRINT 'Populating Airport table...';

INSERT INTO Airport
VALUES ('PER','Perth Airport',0894788888,31.9385,115.9672,'AUS'),
		('AKL','Auckland Airport',06492750789,37.0082,174.7850,'NZL'),
		('DXB','Dubai International Airport',06494544432,56.54,33.33,'UAE'),
		('TIA','Tribhuwan International Airport',097714113033,27.6981,85.3592,'NPL'),
		('ABC','Abc Airport',985485893,43.221,44.54,'ENG'),
		('XYZ','Xyz Airport',542345433,34.43,23.32,'USA'),
		('IJK','Ijk Airport',844428322,67.54,54.32,'POR'),
		('PKR','Pokhara Airport',097761465979,28.2000,83.9817,'NPL'),
		('MEL','Melbourne Airport',0392971600,37.6690,144.8410,'AUS'),
		('SYD','Sydney Airport',0296679111,33.9399,151.1753,'AUS');


 

--  **************************************************************************************
--  Populate the Flight table.

PRINT 'Populating Flight table...';

INSERT INTO Flight
VALUES ('ABC123','TIA','SYD',5500),
       ('ABC987','PER', 'TIA',8800),
	   ('XYP023','XYZ', 'PKR',5800),
	   ('XCF123','ABC', 'AKL',7600),
	   ('PRA172','PER', 'DXB',7400),
	   ('JKL980','MEL', 'TIA',9800),
	   ('QR340','PKR', 'IJK',3500),
	   ('STH650','PER', 'MEL',5680);


--  **************************************************************************************
--  Populate the FlightAttendant table.
--  Since the primary key uses IDENTITY, we don't specify a value for that column.
PRINT 'Populating FlightAttendant table...';

INSERT INTO FlightAttendant 
VALUES ('Pramesh', 'Shrestha', '1989-04-25', '2004-04-25', 6),
		('John', 'Rai','1979-04-22', '2005-04-25', 3),
		('Mike', 'Magar','1990-04-22', '2010-04-25', 5),
		('Hari', 'Cobin', '1990-04-22', '2003-04-25', 3),
		('Greg', 'Nepal', '1991-04-22', '2002-04-25', 4),
		('Ram', 'Sharma', '1998-04-22', '2001-04-25', 1),
		('Amol', 'Pokharel', '1980-04-22', '2008-04-25', 1),
		('Nishesh', 'Gajurel', '1899-04-22', '2009-04-25', 2),
		('Pratik', 'Shrestha', '1999-04-22', '2003-04-25', 7);


--  **************************************************************************************
--  Populate the FlightInstance table.
--  Since the primary key uses IDENTITY, we don't specify a value for that column.
INSERT INTO FlightInstance
VALUES ('PRA172',3,1,2,5,'2015-12-11 10:30:00','2015-12-14 10:30:00'),
		('XCF123',3,2,3,1,'2015-12-11 10:30:00','2015-12-14 10:30:00'),
		('JKL980',4,3,1,2,'2015-12-11 10:30:00','2015-12-14 10:30:00'),
		('QR340',4,3,1,2,'2015-12-10 10:30:00','2015-12-11 10:30:00'),
		('QR340',4,3,1,2,'2015-12-11 10:30:00','2015-12-12 10:30:00'),
		('QR340',4,3,1,2,'2015-12-12 10:30:00','2015-12-13 10:30:00'),
		('PRA172',3,1,2,5,'2015-12-11 10:30:00','2015-12-14 10:30:00'),
		('ABC987',2,5,3,3,'2015-12-11 10:30:00','2015-12-14 10:30:00'),
		('ABC123',3,1,2,4,'2015-12-11 10:30:00','2015-12-14 10:30:00'),
		('JKL980',4,3,1,2,'2015-12-11 10:30:00','2015-12-14 10:30:00'),
		('STH650',1,3,4,5,'2015-12-11 10:30:00','2015-12-14 10:30:00'),
		('XCF123',3,2,3,1,'2015-12-11 10:30:00','2015-12-14 10:30:00'),
		('ABC123',5,4,2,4,'2017-11-11 10:30:00','2017-11-14 10:30:00'),
		('ABC123',5,4,2,4,'2017-11-11 10:30:00','2017-11-14 10:30:00'),
		('JKL980',4,3,1,2,'2017-12-11 10:30:00','2017-12-14 10:30:00'),
		('STH650',1,3,4,5,'2017-12-11 10:30:00','2017-12-14 10:30:00');


--  **************************************************************************************
--  Populate the InstanceAttendant table.

INSERT INTO InstanceAttendant
VALUES (1,2),
		(2,3),
		(3,4),
		(4,1),
		(5,5),
		(7,6),
		(1,7),
		(2,8),
		(3,5),
		(7,3),
		(8,3),
		(2,1),
		(8,1),
		(9,5),
		(6,1),
		(10,7),
		(10,8),
		(10,9),
		(11,1),
		(11,2),
		(11,3),
		(13,4),
		(15,6),
		(15,1),
		(16,5),
		(16,4),
		(12,7),
		(14,9),
		(15,7);


-- **************************************************************************************