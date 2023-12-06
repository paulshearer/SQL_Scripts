declare @tablename varchar(10)
declare @julie nchar(50)
declare paul cursor for select name from sysobjects where xtype='U'
open paul
fetch next from paul into @tablename

while @@fetch_status=0
begin
	set @julie = 'truncate table PY7334.' + @tablename
	exec sp_executesql @julie
	PRINT @julie
	fetch next from paul into @tablename
end
close paul
deallocate paul