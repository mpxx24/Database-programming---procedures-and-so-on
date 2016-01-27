create procedure spdCreateRandomPhoneNumber
as
begin
	declare @phoneNumber int
	select cast(rand()*(999999999-100000000)+100000000 as int)

end
go