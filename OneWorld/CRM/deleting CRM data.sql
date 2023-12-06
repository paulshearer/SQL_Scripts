declare @next_table varchar(50)
declare @mysql nchar(100)
declare person cursor for select TABLE_NAME from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'person_id'
open person 
fetch next from person into @next_table
while @@fetch_status=0
begin
	set @mysql = 'delete crpcrm.' + @next_table +' where person_id > 99999999999999'
	print @next_table
	exec sp_executesql @mysql
	fetch next from person into @next_table
end
close person
deallocate person
