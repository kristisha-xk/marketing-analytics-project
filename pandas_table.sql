with rfm_base as
(
	select 
		a.user_id,
		datediff(day, max(timestamp), '2025-08-07') as recency_days,
		count(case when event_type in ('Click','Like','Purchase', 'Comment', 'Share') then 1 end) as frequency,
		sum(case 
			when event_type='Purchase' then 5
			when event_type='Click' then 4
			when event_type='Like' then 3
			when event_type='Share' then 2
			else 1
		end) as engagement_score
	from ad_events a
	inner join users u on a.user_id = u.user_id
	group by a.user_id
), 

rfm_scores as
(
	select 
		*,
		case
			when recency_days <= 1 then 5
			when recency_days <= 3 then 4
			when recency_days <= 7 then 3
			when recency_days <= 14 then 2
			else 1
		end as r_score,
		case
			when frequency >= 25 then 5
			when frequency >= 15 then 4
			when frequency >= 8 then 3
			when frequency >= 3 then 2
			else 1
		end as f_score,
		case
			when engagement_score >= 120 then 5
			when engagement_score >= 80 then 4
			when engagement_score >= 40 then 3
			when engagement_score >= 15 then 2
			else 1
		end as e_score
	from rfm_base
),

rfm_segmentation as
(
	select 
		*,
		case
			when r_score = 5 and f_score >= 4 then 'Champions'
			when r_score >= 4 and f_score >= 3 then 'Loyal Customers'
			when r_score = 5 and f_score = 1 then 'New Users'
			when r_score >= 4 and f_score = 2 then 'Potential Loyalists'
			when f_score = 1 then 'Low Engagement'
			else 'Regular Users'
		end as segmentations
	from rfm_scores
),

user_features as 
(
    select 
        u.user_id,
		u.user_pk,
        u.interests
    from users u
),

ad_features as 
(
    select 
        ad_id,
        target_interests
    from ads
)

select 
    r.user_id,
    r.r_score,
    r.f_score,
    r.e_score,
    r.segmentations,
    u.interests,
	a.ad_id,
	a.target_interests
from rfm_segmentation r
left join user_features u on r.user_id = u.user_id
join ad_features a on a.ad_id = u.user_pk
