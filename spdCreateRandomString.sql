create procedure spdCreateRandomString
	@maxLength as int
as
begin
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