if not exists (select * from sys.tables where name = 'Towns')
	create table Towns(
	townID int primary key identity(1,1),
	townName nvarchar(15) not null,
	townPopulation int,
	townMayor nvarchar (32)
	)
go

if not exists (select * from sys.tables where name = 'Schools')
	create table Schools(
	schoolID int primary key identity(1,1),
	schoolName nvarchar(20) not null,
	schoolNumberOfStudents int,
	townID int,
	foreign key (townID) references Towns(townID) on delete cascade
	)
go

if not exists (select * from sys.tables where name = 'Teachers')
	create table Teachers(
	teacherID int primary key identity(1,1),
	teacherFirstName nvarchar(10) not null,
	teacherLastName nvarchar(10) not null,
	teacherSex nvarchar(6),
	teacherEmailAddress nvarchar(15),
	teacherTelephone nvarchar(9),
	teacherHireDate datetime,
	schoolID int,
	foreign key (schoolID) references Schools(schoolID)
	)
go

if not exists (select * from sys.tables where name = 'Classes')
	create table Classes(
	classID int primary key identity(1,1),
	className nvarchar(15) not null,
	)
go

if not exists (select * from sys.tables where name = 'Grades')
	create table Grades(
	gradeID int primary key identity(1,1),
	gradeName nvarchar(32) not null
	)
go

if not exists (select * from sys.tables where name = 'Students')
	create table Students(
	studentID int primary key identity(1,1),
	studentFirstName nvarchar(10) not null,
	studentLastName nvarchar(10) not null,
	studentBirthDate datetime,
	studentBirthPlace nvarchar(15),
	studentSex nvarchar(6),
	studentTelephone nvarchar(9),
	studentAddress nvarchar(15),
	teacherID int, 
	classID int,
	gradeID int,
	foreign key (teacherID) references Teachers(teacherID),
	foreign key (classID) references Classes(classID),
	foreign key (gradeID) references Grades(gradeID)
	)
go

-- ================================================== --