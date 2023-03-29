




use CarWorkshop
go


--drop table Invoices
--drop table PartsUsed
--drop table CarService
--drop table ServiceStatus
--drop table CarParts
--drop table Prices
--drop table Cars
--drop table Customers
--drop table CarTypes
--drop table Workshops
--drop table Employees







create table Employees
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	Profession NVARCHAR(100) NULL,
	Salary INT NULL,
	SupervisorId INT FOREIGN KEY REFERENCES Employees(Id) NULL,
)

insert Employees values ('Jacob', 'Manager', 15000, null)
insert Employees values ('Jack', 'Assistant Manager', 10000, 1)
insert Employees values ('Kate', 'Technician', 6000, 1)
insert Employees values ('Hugo', 'Secretary', 4000, 2)
insert Employees values ('John', 'Cleaner', 28000, 2)



select	*
from	Employees



create table Workshops
(	
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	Phone NVARCHAR(100) NULL,
	[Address] NVARCHAR(100) NULL,
	ManagerId INT FOREIGN KEY REFERENCES Employees(Id) NULL,
	WorkingHours INT NULL
)

insert Workshops values ('Shop1', '012-3456789', 'Nower, Illanoy', 1, 8)
insert Workshops values ('Shop2', '987-6543210', 'Samwer, Florida', null, 7)



select	*
from	Workshops



create table CarTypes
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL
)

insert CarTypes values ('Honda')
insert CarTypes values ('Ferari')
insert CarTypes values ('Fiat')
insert CarTypes values ('Ford')


select	*
from	CarTypes






create table Customers
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	Tel NVARCHAR(20) NULL,
)

insert Customers values ('Cindey', '000-00000001')
insert Customers values ('Sawyer', '000-00000002')
insert Customers values ('Desmond', '000-00000003')
insert Customers values ('Daniel', '000-00000004')


select	*
from	Customers




create table Cars
(
	LicenseNumber INT PRIMARY KEY,
	TypeId INT FOREIGN KEY REFERENCES CarTypes(Id) NULL,
	Model INT NULL,
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NULL
)

insert Cars values (18561, 1, 1993, 4)
insert Cars values (78654, 4, 2002, 2)
insert Cars values (45212, 3, 2012, 1)
insert Cars values (45105, 2, 1996, 3)


select	*
from	Cars





create table Prices
(
	Id INT PRIMARY KEY IDENTITY,
	CarLicenseNumber INT FOREIGN KEY REFERENCES Cars(LicenseNumber) NOT NULL,
	HourlyWorkRate INT NOT NULL
)

insert Prices values (18561, 500)
insert Prices values (45105, 300)
insert Prices values (45212, 100)
insert Prices values (78654, 950)


select	*
from	Prices





create table CarParts
(
	Number INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL,
	CarLicenseNumber INT FOREIGN KEY REFERENCES Cars(LicenseNumber) NULL,
	Price INT NULL
)

insert CarParts values ('part1', 18561, 250)
insert CarParts values ('part2', 45212, 1420)
insert CarParts values ('part3', 45212, 1000)
insert CarParts values ('part4', 78654, 450)
insert CarParts values ('part5', 78654, 300)
insert CarParts values ('part6', null, 5000)
insert CarParts values ('part7', 78654, 23)
insert CarParts values ('part8', null, 65)
insert CarParts values ('part9', null, 830)
insert CarParts values ('part10', 18561, 250)


select	*
from	CarParts




create table ServiceStatus
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL
)

insert ServiceStatus values ('1st stage')
insert ServiceStatus values ('2nd stage')
insert ServiceStatus values ('3rd stage')
insert ServiceStatus values ('4th stage')
insert ServiceStatus values ('5th stage')
insert ServiceStatus values ('6th stage')
insert ServiceStatus values ('7th stage')
insert ServiceStatus values ('8th stage')
insert ServiceStatus values ('9th stage')


select	*
from	ServiceStatus



create table CarService
(
	Id INT PRIMARY KEY IDENTITY,
	CarLicenseNumber INT FOREIGN KEY REFERENCES Cars(LicenseNumber) NOT NULL,
	StartTime DATETIME NOT NULL DEFAULT GETDATE(),
	FinishTime DATETIME NULL,
	StatusId INT FOREIGN KEY REFERENCES ServiceStatus(Id) NOT NULL,
	AssignedEmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NULL
)

insert CarService values (18561, '2001-01-27 12:37:45', '2001-01-28 08:00:21', 9, 3)
insert CarService values (18561, '2005-08-14 14:21:32', null, 4, 3)
insert CarService values (45105, '2001-01-27 12:37:45', '2001-01-28 08:00:21', 9, 3)
insert CarService values (45105, '2003-01-27 14:27:36', '2001-01-28 09:00:35', 9, 3)
insert CarService values (45105, '2005-01-27 16:41:45', '2001-01-28 08:30:22', 9, 3)
insert CarService values (45212, '2017-09-27 12:25:05', null, 6, 2)
insert CarService values (78654, '2004-08-08 13:37:55', '2004-08-14 11:05:21', 9, 3)
						  


select	*
from	CarService



create table PartsUsed
(
	PartNumber INT FOREIGN KEY REFERENCES CarParts(Number) NOT NULL,
	ServiceId INT FOREIGN KEY REFERENCES CarService(Id) NOT NULL,
	PRIMARY KEY (PartNumber, ServiceId)
)


insert PartsUsed (PartNumber, ServiceId) values (1, 1)
insert PartsUsed (PartNumber, ServiceId) values (7, 1)
insert PartsUsed (PartNumber, ServiceId) values (8, 1)
insert PartsUsed (PartNumber, ServiceId) values (9, 1)
insert PartsUsed (PartNumber, ServiceId) values (10, 1)
insert PartsUsed (PartNumber, ServiceId) values (2, 2)
insert PartsUsed (PartNumber, ServiceId) values (6, 2)
insert PartsUsed (PartNumber, ServiceId) values (7, 2)
insert PartsUsed (PartNumber, ServiceId) values (8, 2)
insert PartsUsed (PartNumber, ServiceId) values (10, 2)
insert PartsUsed (PartNumber, ServiceId) values (1, 3)
insert PartsUsed (PartNumber, ServiceId) values (5, 3)
insert PartsUsed (PartNumber, ServiceId) values (10, 3)
insert PartsUsed (PartNumber, ServiceId) values (3, 4)
insert PartsUsed (PartNumber, ServiceId) values (4, 4)
insert PartsUsed (PartNumber, ServiceId) values (6, 4)
insert PartsUsed (PartNumber, ServiceId) values (8, 4)
insert PartsUsed (PartNumber, ServiceId) values (4, 7)
insert PartsUsed (PartNumber, ServiceId) values (5, 7)
insert PartsUsed (PartNumber, ServiceId) values (6, 7)
insert PartsUsed (PartNumber, ServiceId) values (9, 7)
insert PartsUsed (PartNumber, ServiceId) values (10, 7)

						  


select	*
from	PartsUsed




create table Invoices
(
	RecietNumber INT PRIMARY KEY IDENTITY,
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NULL,
	CarLicenseNumber INT FOREIGN KEY REFERENCES Cars(LicenseNumber) NOT NULL,
	ServiceId INT FOREIGN KEY REFERENCES CarService(Id) NOT NULL,
)

insert into		Invoices
select			c.Id, cr.LicenseNumber, cs.Id
from			Customers c
join			Cars cr on c.Id = cr.CustomerId
join			CarService cs on cs.CarLicenseNumber = cr.LicenseNumber

select	*
from	Invoices