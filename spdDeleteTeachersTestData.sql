create procedure [dbo].spdDeleteTeachersTestData
	@valueToEnter int
as
begin
	delete from Teachers
	where teacherID in (select top (@valueToEnter) teacherID from Teachers order by teacherID desc)
end
