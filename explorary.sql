-- change data types
alter table ad_events alter column ad_id int;
alter table ads alter column campaign_id int;

alter table campaigns alter column campaign_id int not null;
alter table campaigns alter column start_date date;
alter table campaigns alter column end_date date;
alter table campaigns alter column duration_days int;
alter table campaigns alter column total_budget decimal(18,2);

alter table users alter column user_age int;

-- check gaps
select *
from users
where user_id IS NULL

-- check dublicates: there are some pairs with the same user_id but they are different people
-- so i will not delete them and will join tables by user_pk
select *
from users 
where user_id in (
    select user_id 
    from users 
    group by user_id 
    having count(*) > 1
)
order by user_id
