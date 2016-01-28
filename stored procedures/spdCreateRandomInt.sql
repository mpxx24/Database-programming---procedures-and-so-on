create procedure spdCreateRandomInt
as
begin	
	declare @townPopulation int	
	select @townPopulation = cast(rand()*(12345-1)+1 as int)
	select @townPopulation
end
go