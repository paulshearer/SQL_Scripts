declare @object varchar (20)
declare @disc varchar (50)
declare @obnm varchar (10)
declare @mkey varchar (15)
declare @enhv varchar (10)
declare @user varchar (10)
declare @dm numeric (18,0)
declare @jdevers varchar (10)
declare @msar varchar (8)
declare @stce varchar (1)
declare @dvp varchar (1)
declare @mrgmod varchar (1)
declare @mrgopt varchar (1)
declare @rls varchar (10)
declare @pathcd varchar (10)
declare @modcmt varchar (30)
declare @pid varchar (10)
declare @jobn varchar (10)
declare @upmj numeric (18,0)
declare @upmt float

declare curs1 CURSOR FOR select * from ps811.OL811.f9861 where SIPATHCD='PS811'
open curs1
FETCH NEXT FROM curs1 into @obnm, @mkey, @enhv, @user, @dm, @jdevers, @msar, @stce, @dvp, @mrgmod, @mrgopt, 
			   @rls, @pathcd, @modcmt, @pid, @jobn, @upmj, @upmt
WHILE @@FETCH_STATUS = 0
BEGIN
	if (select count(*) from ps811.OL811.F9861 where SIOBNM = @obnm and SIPATHCD = 'DV811') = 0
	BEGIN
         	insert into ps811.OL811.F9861 (SIOBNM, SIMKEY, SIENHV, SIUSER, SIDM, SIJDEVERS, SIMSAR, SISTCE, SIDVP,
					  SIMRGMOD, SIMRGOPT, SIRLS, SIPATHCD, SIMODCMT, SIPID, SIJOBN, SIUPMJ, SIUPMT)
				  values (@obnm, @mkey, @enhv, @user, @dm, @jdevers, @msar, @stce,
						@dvp, @mrgmod, @mrgopt, @rls, 'DV811', @modcmt, @pid, @jobn, @upmj, @upmt)
	END
	FETCH NEXT FROM curs1 into @obnm, @mkey, @enhv, @user, @dm, @jdevers, @msar, @stce, @dvp, @mrgmod, @mrgopt, 
			   	   @rls, @pathcd, @modcmt, @pid, @jobn, @upmj, @upmt
END

close curs1
DEALLOCATE curs1





