SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure spdCreateRandomInt
as
begin	
	declare @townPopulation int	
	--generate random int -> range from 1 to 12345
	select @townPopulation = cast(rand()*(12345-1)+1 as int)
	select @townPopulation
end
go

create procedure spdCreateRandomString
	@maxLength as int
as
begin
	--create random string
	declare @townName nvarchar(15)
	declare @lenght int
	select @townName = ''
	set @lenght = cast(rand() *(@maxLength-1)+1 as int)
	while @lenght <> 0
		begin 
			select @townName = @townName + char(round(rand() * 26, 1) + 97)
			set @lenght = @lenght - 1
		end
	select @townName
end
go

create procedure spdCreateRandomDateTime
as
begin
	select dateadd(day, (abs(checksum(newid())) % 36500),0)
end
go

create procedure spdCreateTowns
	@townName as nvarchar(15),
	@townPopulation as int,
	@townMayor as nvarchar(12)
as
begin
	declare @HowManyRecords as int = 1000
	while @HowManyRecords <> 0
		begin
			--save
			insert into Towns (townName, townPopulation, townMayor)
			values (@townName, @townPopulation, @townMayor)
		end
ens
go

create procedure spdCreateRandomEmail
as
begin
	declare @mailName nvarchar(8)
	declare @hostName nvarchar(3)
	declare @mailEnding nvarchar(2)
	declare @char1 nvarchar(1)
	declare @char2 nvarchar(1)
	declare @mailLength int
	declare @mailHostLenght int
	declare @mailEndingLenght int

	set @mailName = ''	
	set @mailEnding = ''	
	set @hostName = ''	
	set @char1 = '@'
	set @char2 = '.'
	set @mailLength = 8
	set @mailHostLenght = 3
	set @mailEndingLenght = 2
	

	while @mailLength <> 0
		begin 
			select @mailName = @mailName + char(round(rand() * 26, 1) + 97)
			set @mailLength = @mailLength - 1
		end

	while @mailHostLenght <> 0
		begin 
			select @hostName = @hostName + char(round(rand() * 26, 1) + 97)
			set @mailHostLenght = @mailHostLenght - 1
		end

	while @mailEndingLenght <> 0
		begin 
			select @mailEnding = @mailEnding + char(round(rand() * 26, 1) + 97)
			set @mailEndingLenght = @mailEndingLenght - 1
		end

		select @mailName + @char1 + @hostName + @char2 + @mailEnding
end
go

create procedure spdCreateRandomPhoneNumber
as
begin
	declare @phoneNumber int
	select cast(rand()*(999999999-100000000)+100000000 as int)

end
go


-- ====================================================================================
-- FILL TABLES 
-- ====================================================================================

--
-- FILL Towns TABLE
--

declare @iterator int = 1;
declare @tempTNAME table (tempIndex int identity(1,1), tName nvarchar(15))
declare @tempTPOPULATION table (tempIndex int identity(1,1), tPopulation int)
declare @tempTMAYOR table (tempIndex int identity(1,1), tMayor nvarchar(32))

while @iterator <> 1001
	begin
		insert @tempTNAME 
		exec spdCreateRandomString 15	
		insert @tempTPOPULATION 
		exec spdCreateRandomInt
		insert @tempTMAYOR
		exec spdCreateRandomString 32

		set @iterator = @iterator + 1
	end

insert into Towns (townName, townPopulation, townMayor)
select t.tName, t2.tPopulation, t3.tMayor
from @tempTNAME t
inner join @tempTPOPULATION t2 on t2.tempIndex = t.tempIndex
inner join @tempTMAYOR t3 on t3.tempIndex = t.tempIndex

select * from @tempTNAME
select * from @tempTPOPULATION
select * from @tempTMAYOR

select * from Towns

--delete Towns
--dbcc CHECKIDENT ('Towns', reseed, 0) 
GO


--
-- FILL Schools TABLE
--

declare @iterator int = 1;
declare @tempSNAME table (tempIndex int identity(1,1), sName nvarchar(15))
declare @tempSNUMBEROFSTUDENTS table (tempIndex int identity(1,1), sNumberOfStudents int)
declare @tempSTOWNID table (tempIndex int identity(1,1), sTownId int)

while @iterator <> 1001
	begin
		insert @tempSNAME
		exec spdCreateRandomString 20	
		insert @tempSNUMBEROFSTUDENTS 
		exec spdCreateRandomInt
		insert @tempSTOWNID
		select top 1 townID from Towns
		order by newid()

		set @iterator = @iterator + 1
	end

insert into Schools(schoolName, schoolNumberOfStudents, townID)
select t.sName, t2.sNumberOfStudents, t3.sTownId
from @tempSNAME t
inner join @tempSNUMBEROFSTUDENTS t2 on t2.tempIndex = t.tempIndex
inner join @tempSTOWNID t3 on t3.tempIndex = t.tempIndex

select * from @tempSNAME
select * from @tempSNUMBEROFSTUDENTS
select * from @tempSTOWNID

select * from Schools

--delete Schools
--dbcc CHECKIDENT ('Schools', reseed, 0) 
GO


--
-- FILL Teachers TABLE
--

declare @iterator int = 1;
declare @tempTFirstName table (tempIndex int identity(1,1), sFisrtName nvarchar(10))
declare @tempTLastName table (tempIndex int identity(1,1), sLastName nvarchar(10))
declare @tempTSex table (tempIndex int identity(1,1), sSex nvarchar(6))
declare @tempTEmailAdress table (tempIndex int identity(1,1), sEmailAddress nvarchar(15))
declare @tempTTelephone table (tempIndex int identity(1,1), sTelephone nvarchar(9))
declare @tempTHireDate table (tempIndex int identity(1,1), sHireDate datetime)
declare @tempTSCHOOLID table (tempIndex int identity(1,1), sSchoolID int)

while @iterator <> 1001
	begin
		insert @tempTFirstName
		exec spdCreateRandomString 10
		insert @tempTLastName
		exec spdCreateRandomString 10
		insert @tempTSex
		select round((rand() * (1-0)), + 0)
		insert @tempTEmailAdress
		exec spdCreateRandomEmail
		insert @tempTTelephone
		exec spdCreateRandomPhoneNumber
		insert @tempTHireDate
		exec spdCreateRandomDatetime
		insert @tempTSCHOOLID
		select top 1 schoolID from Schools
		order by newid()

		set @iterator = @iterator + 1
	end

insert into Teachers(teacherFirstName, teacherLastName, teacherSex, teacherEmailAddress, teacherTelephone, teacherHireDate, schoolID)
select t.sFisrtName, t2.sLastName, t3.sSex, t4.sEmailAddress, t5.sTelephone, t6.sHireDate, t7.sSchoolID
from @tempTFirstName t
inner join @tempTLastName t2 on t2.tempIndex = t.tempIndex
inner join @tempTSex t3 on t3.tempIndex = t.tempIndex
inner join @tempTEmailAdress t4 on t4.tempIndex = t.tempIndex
inner join @tempTTelephone t5 on t5.tempIndex = t.tempIndex
inner join @tempTHireDate t6 on t6.tempIndex = t.tempIndex
inner join @tempTSCHOOLID t7 on t7.tempIndex = t.tempIndex

select * from Teachers

--delete Teachers
--dbcc CHECKIDENT ('Teachers', reseed, 0) 
GO



--
-- FILL Classes TABLE
--

declare @iterator int = 1;
declare @tempCName table (tempIndex int identity(1,1), cName nvarchar(32))

while @iterator <> 1001
	begin
		insert @tempCName 
		exec spdCreateRandomString 15	

		set @iterator = @iterator + 1
	end

insert into Classes(className)
select t.cName
from @tempCName t

select * from Classes

--delete Grades
--dbcc CHECKIDENT ('Grades', reseed, 0) 
GO



--
-- FILL Grades TABLE
--

declare @iterator int = 1;
declare @tempGName table (tempIndex int identity(1,1), gName nvarchar(32))

while @iterator <> 1001
	begin
		insert @tempGName 
		exec spdCreateRandomString 32	

		set @iterator = @iterator + 1
	end

insert into Grades(gradeName)
select t.gName
from @tempGName t

select * from Grades

--delete Grades
--dbcc CHECKIDENT ('Grades', reseed, 0) 
GO




--
-- FILL Students TABLE
--

declare @iterator int = 1;
declare @tempSFirstName table (tempIndex int identity(1,1), sFisrtName nvarchar(10))
declare @tempSLastName table (tempIndex int identity(1,1), sLastName nvarchar(10))
declare @tempSBirthDate table (tempIndex int identity(1,1), sBirthDate datetime)
declare @tempSBirthPlace table (tempIndex int identity(1,1), sBirthPlace nvarchar(15))
declare @tempSSex table (tempIndex int identity(1,1), sSex nvarchar(6))
declare @tempSTelephone table (tempIndex int identity(1,1), sTelephone nvarchar(9))
declare @tempSAddress table (tempIndex int identity(1,1), sAddress nvarchar(15))
declare @tempSTEACHERID table (tempIndex int identity(1,1), sTearcherID int)
declare @tempTCLASSID table (tempIndex int identity(1,1), sClassID int)
declare @tempTGRADEID table (tempIndex int identity(1,1), sGradeID int)


while @iterator <> 1001
	begin
		insert @tempSFirstname
		exec spdCreateRandomString 5
		insert @tempSLastName
		exec spdCreateRandomString 6
		insert @tempSBirthDate
		exec spdCreateRandomDatetime
		insert @tempSBirthPlace
		exec spdCreateRandomString 12
		insert @tempSSex
		select round((rand() * (1-0)), + 0)
		insert @tempSTelephone
		exec spdCreateRandomPhoneNumber	
		insert @tempSLastName
		exec spdCreateRandomString 10
		insert @tempSTEACHERID
		select top 1 teacherID from Teachers
		order by newid()
		insert @tempTCLASSID
		select top 1 classID from Classes
		order by newid()
		insert @tempTGRADEID
		select top 1 gradeID from Grades
		order by newid()

		set @iterator = @iterator + 1
	end

insert into Students(studentFirstName, studentLastName, studentBirthDate, studentBirthPlace, studentSex, studentTelephone, studentAddress, teacherID, classID, gradeID)
select t.sFisrtName, t2.sLastName, t3.sBirthDate, t4.sBirthPlace, t5.sSex, t6.sTelephone, t7.sAddress, t8.sTearcherID, t9.sClassID, t10.sGradeID
from @tempSFirstName t
inner join @tempSLastName t2 on t2.tempIndex = t.tempIndex
inner join @tempSBirthDate t3 on t3.tempIndex = t.tempIndex
inner join @tempSBirthPlace t4 on t4.tempIndex = t.tempIndex
inner join @tempSSex t5 on t5.tempIndex = t.tempIndex
inner join @tempSTelephone t6 on t6.tempIndex = t.tempIndex
inner join @tempSAddress t7 on t7.tempIndex = t.tempIndex
inner join @tempSTEACHERID t8 on t8.tempIndex = t.tempIndex
inner join @tempTCLASSID t9 on t9.tempIndex = t.tempIndex
inner join @tempTGRADEID t10 on t10.tempIndex = t.tempIndex

select * from Students

--delete Students
--dbcc CHECKIDENT ('Students', reseed, 0) 
GO
