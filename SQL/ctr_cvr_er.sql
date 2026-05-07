-- check if Impression > Click
select event_type, count(*) as types_cnt
from ad_events 
group by event_type
order by types_cnt desc

-- CTR analysis
select 
    a.ad_id,
    ad_platform,
    sum(case when event_type='Impression' then 1 else 0 end) as impressions,
    sum(case when event_type='Click' then 1 else 0 end) as clicks,
    cast(round(100.0 * 
        sum(case when event_type='Click' then 1 else 0 end) / 
        nullif(sum(case when event_type='Impression' then 1 else 0 end), 0), 2) as decimal(10,2)) as ctr_percentage
from ad_events a
join ads on ads.ad_id = a.ad_id
group by a.ad_id, ad_platform
having sum(case when event_type='Impression' then 1 else 0 end) > 100
order by ad_platform, ctr_percentage desc

-- CVR analysis (Conversion Rate)
select 
    ad_platform,
    count(distinct user_id) as total_users,
    count(distinct case when event_type='Purchase' then user_id end) as buyers,
    sum(case when event_type='Purchase' then 1 else 0 end) as purchases,
    cast(round(100.0 * 
        count(distinct case when event_type='Purchase' then user_id end) /
        nullif(count(distinct user_id), 0), 2) as decimal(10,2)) as cvr_users
from ad_events a
join ads on a.ad_id = ads.ad_id
group by ad_platform


-- Engagement Rate
select
    a.ad_id,
    ad_platform,
    sum(case when event_type in ('Click', 'Like', 'Comment', 'Share') then 1 else 0 end) as total_interactions,
    sum(case when event_type in ('Like', 'Comment', 'Share') then 1 else 0 end) as social_interactions,
    sum(case when event_type='Impression' then 1 else 0 end) as impressions,
    cast(round(100.0 *
        sum(case when event_type in ('Click', 'Like', 'Comment', 'Share') then 1 else 0 end) /
        nullif(sum(case when event_type='Impression' then 1 else 0 end), 0), 2) as decimal(10,2)) as er_percentage,
    cast(round(100.0 *
        sum(case when event_type in ('Like', 'Comment', 'Share') then 1 else 0 end) /
        nullif(sum(case when event_type='Impression' then 1 else 0 end), 0), 2) as decimal(10,2)) as ers_percentage
from ad_events a
join ads on a.ad_id = ads.ad_id
group by a.ad_id, ad_platform
order by ad_platform, er_percentage desc, ers_percentage desc

select
    sum(case when event_type='Impression' then 1 else 0 end) as impressions,
    sum(case when event_type='Click' then 1 else 0 end) as clicks,
    sum(case when event_type='Like' then 1 else 0 end) as likes,
    sum(case when event_type='Comment' then 1 else 0 end) as comms,
    sum(case when event_type='Share' then 1 else 0 end) as shares
from ad_events
