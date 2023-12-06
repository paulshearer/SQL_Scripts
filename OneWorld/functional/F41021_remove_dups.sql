DECLARE         @LIITM FLOAT,  
                @LIMCU CHAR (12),  
                @LILOCN CHAR (20),  
	        @LILOTN CHAR (30),  
	        @LIPBIN CHAR (1),  
        	@LIGLPT CHAR (4),
	        @LILOTS CHAR (1),
        	@LILRCJ NUMERIC(18,0), 
	        @LIPQOH FLOAT,
        	@LIPBCK FLOAT,
	        @LIPREQ FLOAT,
        	@LIQWBO FLOAT,
	        @LIOT1P FLOAT,
        	@LIOT2P FLOAT,
	        @LIOT1A FLOAT,
        	@LIHCOM FLOAT, 
	        @LIPCOM FLOAT, 
        	@LIFCOM FLOAT, 
	        @LIFUN1 FLOAT, 
        	@LIQOWO FLOAT, 
		@LIQTTR FLOAT,
		@LIQTIN FLOAT,
		@LIQONL FLOAT,
		@LIQTRI FLOAT,
		@LIQTRO FLOAT,
		@LINCDJ NUMERIC(18,0),
		@LIQTY1 FLOAT,
		@LIQTY2 FLOAT,
		@LICSID FLOAT,
		@LIURAB FLOAT,
		@LIURRF CHAR(15),
		@LIURAT FLOAT,
		@LIURCD CHAR(2),
		@LIJOBN CHAR(10),
		@LIPID  CHAR(10),
		@LIUPMJ NUMERIC(18,0),
		@LIUSER CHAR(10),
		@LITDAY FLOAT,
		@LIURDT NUMERIC(18,0),
		@LIQTO1 FLOAT,
		@LIQTO2 FLOAT,
		@COUNT INT  

DECLARE del_cursor CURSOR FOR
SELECT [LIITM], [LIMCU], [LILOCN], [LILOTN], [LIPBIN], [LIGLPT], [LILOTS], [LILRCJ], [LIPQOH], 
       [LIPBCK], [LIPREQ], [LIQWBO], [LIOT1P], [LIOT2P], [LIOT1A], [LIHCOM], [LIPCOM], [LIFCOM], 
       [LIFUN1], [LIQOWO], [LIQTTR], [LIQTIN], [LIQONL], [LIQTRI], [LIQTRO], [LINCDJ], [LIQTY1],
       [LIQTY2], [LICSID], [LIURAB], [LIURRF], [LIURAT], [LIURCD], [LIJOBN], [LIPID], [LIUPMJ],
       [LIUSER], [LITDAY], [LIURDT], [LIQTO1], [LIQTO2],
       Count(LIITM) AS NumberOfDups FROM [JDE_PRODUCTION].[PRODDTA].[F41021] GROUP BY [LIITM], [LIMCU],
                     [LILOCN], [LILOTN], [LIPBIN], [LIGLPT], [LILOTS], [LILRCJ], [LIPQOH], [LIPBCK], 
                     [LIPREQ], [LIQWBO], [LIOT1P], [LIOT2P], [LIOT1A], [LIHCOM], [LIPCOM], [LIFCOM],
                     [LIFUN1], [LIQOWO], [LIQTTR], [LIQTIN], [LIQONL], [LIQTRI], [LIQTRO], [LINCDJ],
                     [LIQTY1], [LIQTY2], [LICSID], [LIURAB], [LIURRF], [LIURAT], [LIURCD], [LIJOBN], 
                     [LIPID], [LIUPMJ],  [LIUSER], [LITDAY], [LIURDT], [LIQTO1], [LIQTO2]
       HAVING COUNT(*) > 1

OPEN del_cursor

FETCH NEXT FROM del_cursor INTO @LIITM, @LIMCU, @LILOCN, @LILOTN, @LIPBIN, @LIGLPT, @LILOTS, @LILRCJ,
                                @LIPQOH, @LIPBCK, @LIPREQ, @LIQWBO, @LIOT1P, @LIOT2P, @LIOT1A, 
                                @LIHCOM, @LIPCOM, @LIFCOM, @LIFUN1, @LIQOWO, @LIQTTR, @LIQTIN, 
                                @LIQONL, @LIQTRI, @LIQTRO, @LINCDJ, @LIQTY1, @LIQTY2, @LICSID, 
                                @LIURAB, @LIURRF, @LIURAT, @LIURCD, @LIJOBN, @LIPID, @LIUPMJ,  
                                @LIUSER, @LITDAY, @LIURDT, @LIQTO1, @LIQTO2, @COUNT
	WHILE @@FETCH_STATUS = 0
	  BEGIN
	    SET @COUNT = @COUNT-1
	    SET ROWCOUNT @COUNT

    DELETE FROM [JDE_PRODUCTION].[PRODDTA].[F41021] WHERE [LIITM] = @LIITM AND [LIMCU] = @LIMCU
								    AND [LILOCN] = @LILOCN
								    AND [LILOTN] = @LILOTN 
								    AND [LIPBIN] = @LIPBIN 
								    AND [LIGLPT] = @LIGLPT
								    AND [LILOTS] = @LILOTS
								    AND [LILRCJ] = @LILRCJ
								    AND [LIPQOH] = @LIPQOH
								    AND [LIPBCK] = @LIPBCK
								    AND [LIPREQ] = @LIPREQ 
								    AND [LIQWBO] = @LIQWBO
								    AND [LIOT1P] = @LIOT1P 
								    AND [LIOT2P] = @LIOT2P
								    AND [LIOT1A] = @LIOT1A
								    AND [LIHCOM] = @LIHCOM
								    AND [LIPCOM] = @LIPCOM 
								    AND [LIFCOM] = @LIFCOM
								    AND [LIFUN1] = @LIFUN1
								    AND [LIQOWO] = @LIQOWO
    SET ROWCOUNT 0
    FETCH NEXT FROM del_cursor INTO @LIITM, @LIMCU, @LILOCN, @LILOTN, @LIPBIN, @LIGLPT, @LILOTS, @LILRCJ,
                                @LIPQOH, @LIPBCK, @LIPREQ, @LIQWBO, @LIOT1P, @LIOT2P, @LIOT1A, 
                                @LIHCOM, @LIPCOM, @LIFCOM, @LIFUN1, @LIQOWO, @LIQTTR, @LIQTIN, 
                                @LIQONL, @LIQTRI, @LIQTRO, @LINCDJ, @LIQTY1, @LIQTY2, @LICSID, 
                                @LIURAB, @LIURRF, @LIURAT, @LIURCD, @LIJOBN, @LIPID, @LIUPMJ,  
                                @LIUSER, @LITDAY, @LIURDT, @LIQTO1, @LIQTO2, @COUNT
    END

CLOSE del_cursor
DEALLOCATE del_cursor

