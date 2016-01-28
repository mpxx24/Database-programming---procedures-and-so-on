create procedure spdCreateRandomDateTime
as
begin
	select dateadd(day, (abs(checksum(newid())) % 36500),0)
end
go