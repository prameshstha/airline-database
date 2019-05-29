--  Populate the region table.
--  Since the primary key uses IDENTITY, we don't specify a value for that column.

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
--  Populate the country table.

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
--  Populate the job table.
--  Note that I've specified the column names for this table, and used NULL and DEFAULT for some pieces of data.

PRINT 'Populating PlaneDetail table...';

INSERT INTO PlaneDetail
VALUES ('A390','AU-1989',1989,100,200),
	   ('A380','AU-2000',2000,150,300), 
		('A300','AU-1970',1970,50,150), 
		('A340','AU-1880',1880,90,190), 
		('A390','AU-1990',1990,110,230),
		('737','BO-2001',2001,88,320), 
		('777','BO-1990',1990,80,250),
		('779','BO-2002',2002,121,444),
		('787','BO-2005',2005,195,340),
		('787','BO-2005-1',2005,195,340);


--  **************************************************************************************
--  Populate the location table.
--  Since the primary key uses IDENTITY, we don't specify a value for that column.

PRINT 'Populating PlanePilot table...';

INSERT INTO PlanePilot 
VALUES ('777',1),
	   ('A390',2),
	   ('A380',3),
	   ('777',3),
	   ('787',5),
	   ('787',6),
	   ('A340',1),
	   ('737',1),
	   ('779',4)
	   ; 




--  **************************************************************************************
--  Populate the department table.
--  Since the primary key uses IDENTITY, we don't specify a value for that column.
--  Note that the department_id uses IDENTITY(10, 10), so the values generated will be 10, 20, 30, 40, etc.

--  Remember that for the time being, the middle column (manager_id) does not have a foreign key constraint.
--  We can't link the data to the employee table yet, since the employee details have not been inserted yet.

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
--  Populate the employee table.
--  Note that I've specified the column names for this table, and used NULL for some pieces of data.

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
--  Populate the job_history table.

--  Note that I have used a different date format for the start dates in this table.
--  Always make sure that the date format you use is recognised by the database server you are using.

PRINT 'Populating Flight table...';

INSERT INTO Flight
VALUES ('TIA','SYD',5500),
       ('PER', 'TIA',8800),
	   ('ZYZ', 'PKR',5800),
	   ('ABC', 'AKL',7600),
	   ('PER', 'DXB',7400),
	   ('MEL', 'TIA',9800),
	   ('PKR', 'IJK',3500),
	   ('PER', 'MEL',5680);


--  **************************************************************************************
--  Populate the FlightAttendant table.

PRINT 'Populating FlightAttendant table...';

INSERT INTO FlightAttendant 
VALUES ('Pramesh', 'Shrestha', '25-04-1989', '25-04-1989', 6),
		('John', 'Rai', '12-12-1979', '25-04-1989', 2),
		('Mike', 'Magar', '28-02-1890', '25-04-1989', 5),
		('Hari', 'Cobin', '04-11-1990', '25-04-1989', 3),
		('Greg', 'Nepali', '11-11-1991', '25-04-1989', 4),
		('Ram', 'Sharma', '08-09-1998', '25-04-1989', 1),
		('Amol', 'Pokharel', '24-05-1980', '25-04-1989', 1),
		('Nishesh', 'Gajurel', '15-06-1899', '25-04-1989', 8),
		('Pratik', 'Shrestha', '22-04-1999', '25-04-1989', 7);


--  **************************************************************************************
--  Populate the FlightAttendant table.

INSERT INTO FlightInstance
VALUES (3,5,1,2,5,'12-11-2015','14-11-2015'),
		(4,4,3,1,2,'12-10-2015','14-10-2015'),
		(2,1,5,3,3,'12-09-2015','14-09-2015'),
		(3,4,1,2,4,'12-08-2015','14-08-2015'),
		(2,3,3,3,5,'12-12-2015','14-12-2015');


--  **************************************************************************************
--  Populate the FlightAttendant table.

INSERT INTO InstanceAttendant
VALUES (1,2),
		(2,3),
		(3,4),
		(4,1),
		(5,5);