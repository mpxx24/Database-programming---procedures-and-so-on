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