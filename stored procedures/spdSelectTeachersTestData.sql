create procedure [dbo].spdSelectTeachersTestData
	@valueToEnter int
as
begin
	select top (@valueToEnter) * from Teachers
end