-- Table DDL Template
use report_db;

create table if not exists analytics.some_table
(
    col1 varchar(50),
    agg_insert_dt timestamp
)
with tag
    pipeline_id='some_pipeline',
    exec_order=1,
    exec_proc_map='analytics.some_table'
;

-- Stored Procedure DDL Template
create procedure if not exists analytics.some_table(exec_dt varchar(25))
   returns varchar not null
    language sql
    execute as owner
as
$$
    declare result varchar;
   
    begin                
         
        /****** START SQL TEMPLATE ******/        
       
        -- TABLE FOR UNIQUE MAPPING THAT TIES DW_SITE_VISITOR_ID TO ONE USER_ID
        delete from analytics.some_table where agg_insert_dt = :exec_dt;

        insert into analytics.some_table
        select 
            col1,
            :exec_dt as agg_insert_dt
        from data.base_table;        
       
        /****** END SQL TEMPLATE  ******/        
        
        result := 'succeeded';
        return result;         

    end;
$$;
