-- funnel analysis
with first_impression as (
    select 
        distinct user_id,
        min(timestamp) as t_imp
    from ad_events
    where event_type='Impression'
    group by user_id
),

clickers as (
    select distinct e.user_id
    from ad_events e
    join first_impression i on e.user_id = i.user_id
    where e.event_type='Click' and e.timestamp > i.t_imp
),

first_click as (
    select
        e.user_id,
        min(e.timestamp) as t_click
    from ad_events e
    join clickers c on e.user_id = c.user_id
    where e.event_type='Click'
    group by e.user_id
),

likers as (
    select distinct e.user_id
    from ad_events e
    join first_click c on c.user_id = e.user_id
    where event_type='Like' and e.timestamp > c.t_click
),

first_like as (
    select
        e.user_id,
        min(e.timestamp) as t_like
    from ad_events e
    join likers l on e.user_id = l.user_id
    where e.event_type='Like'
    group by e.user_id
),

buyers as (
    select distinct e.user_id
    from first_like l 
    join ad_events e on l.user_id = e.user_id
    where event_type='Purchase' and e.timestamp > l.t_like
),

steps as (
    select 'View' as step, 1 as step_order, count(*) as users_cnt from first_impression
        union all
    select 'Click', 2, count(*) from clickers
        union all
    select 'Like', 3, count(*) from likers 
        union all
    select 'Purchase', 4, count(*) from buyers
)

select
    step,
    users_cnt,
    lag(users_cnt) over (order by step_order) as prev_step_cnt,
    case 
        when lag(users_cnt) over (order by step_order) is null then null
        else round(
            1.0 - (users_cnt * 1.0 / lag(users_cnt) over (order by step_order)), 
            2
        )
    end as drop_off_rate
from steps 
order by step_order;
