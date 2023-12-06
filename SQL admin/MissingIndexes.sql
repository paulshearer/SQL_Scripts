DECLARE @rev VARCHAR(50)

SELECT  @rev=CAST(SERVERPROPERTY('productversion') AS VARCHAR(50))

IF (CHARINDEX('9',@rev)>0) 
    BEGIN
        SELECT  migs.avg_total_user_cost*(migs.avg_user_impact/100.0)
                *(migs.user_seeks+migs.user_scans) AS improvement_measure
               ,'CREATE INDEX [missing_index_'
                +CONVERT (VARCHAR,mig.index_group_handle)+'_'
                +CONVERT (VARCHAR,mid.index_handle)+'_'
                +LEFT(PARSENAME(mid.statement,1),32)+']'+' ON '+mid.statement
                +' ('+ISNULL(mid.equality_columns,'')
                +CASE WHEN mid.equality_columns IS NOT NULL
                           AND mid.inequality_columns IS NOT NULL THEN ','
                      ELSE ''
                 END+ISNULL(mid.inequality_columns,'')+')'+ISNULL(' INCLUDE ('
                                                              +mid.included_columns
                                                              +')','')
                + 'WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,'
                + 'DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY])' AS create_index_statement                                                               
               ,migs.user_seeks
               ,migs.last_user_seek
               ,migs.user_scans
               ,migs.last_user_scan               
               ,migs.avg_total_user_cost
               ,migs.avg_user_impact
               ,DB_NAME(mid.database_id) AS 'Database Name'
               ,mid.[object_id]
        FROM    sys.dm_db_missing_index_groups mig
        INNER JOIN sys.dm_db_missing_index_group_stats migs
        ON      migs.group_handle=mig.index_group_handle
        INNER JOIN sys.dm_db_missing_index_details mid
        ON      mig.index_handle=mid.index_handle
        WHERE  DB_NAME(mid.database_id) <> 'msdb'              
        AND migs.avg_total_user_cost*(migs.avg_user_impact/100.0)
                *(migs.user_seeks+migs.user_scans) > 100
        ORDER BY DB_NAME(mid.database_id)
                ,mid.[object_id]
                ,migs.avg_total_user_cost*(migs.avg_user_impact/100.0)
                *(migs.user_seeks+migs.user_scans) DESC

    END

IF (CHARINDEX('10',@rev)>0) 
    BEGIN
        SELECT  migs.avg_total_user_cost*(migs.avg_user_impact/100.0)
                *(migs.user_seeks+migs.user_scans) AS improvement_measure
               ,'CREATE INDEX [missing_index_'
                +CONVERT (VARCHAR,mig.index_group_handle)+'_'
                +CONVERT (VARCHAR,mid.index_handle)+'_'
                +LEFT(PARSENAME(mid.statement,1),32)+']'+' ON '+mid.statement
                +' ('+ISNULL(mid.equality_columns,'')
                +CASE WHEN mid.equality_columns IS NOT NULL
                           AND mid.inequality_columns IS NOT NULL THEN ','
                      ELSE ''
                 END+ISNULL(mid.inequality_columns,'')+')'+ISNULL(' INCLUDE ('
                                                              +mid.included_columns
                                                              +')','') 
                + 'WITH (DATA_COMPRESSION=PAGE, PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF,'
                + 'DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY])' AS create_index_statement
               ,migs.user_seeks
               ,migs.last_user_seek
               ,migs.user_scans
               ,migs.last_user_scan
               ,migs.avg_total_user_cost
               ,migs.avg_user_impact
               ,DB_NAME(mid.database_id) AS 'Database Name'
               ,mid.[object_id]
        FROM    sys.dm_db_missing_index_groups mig
        INNER JOIN sys.dm_db_missing_index_group_stats migs
        ON      migs.group_handle=mig.index_group_handle
        INNER JOIN sys.dm_db_missing_index_details mid
        ON      mig.index_handle=mid.index_handle
        WHERE  DB_NAME(mid.database_id) <> 'msdb'              
        AND migs.avg_total_user_cost*(migs.avg_user_impact/100.0)
                *(migs.user_seeks+migs.user_scans) > 100
        ORDER BY DB_NAME(mid.database_id)
                ,mid.[object_id]
                ,migs.avg_total_user_cost*(migs.avg_user_impact/100.0)
                *(migs.user_seeks+migs.user_scans) DESC

    END
GO