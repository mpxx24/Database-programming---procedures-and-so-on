create procedure spdUpdateTearchesFirstRecord
	@valueToEnter nvarchar(10)
as
begin
	update Teachers set teacherFirstName = @valueToEnter where teacherID=1
end
go