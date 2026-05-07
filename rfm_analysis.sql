-- RFM segmentation
declare @reference_date date = '2025-08-07';

with rfm_base as (
	select 
		user_id,
		max(timestamp) as last_activity,
		datediff(day, max(timestamp), @reference_date) as recency_days,
		
		count(case when event_type in ('Click','Like','Purchase', 'Comment', 'Share') then 1 end) as frequency,
		sum(case 
				when event_type='Purchase' then 5
				when event_type='Click' then 4
				when event_type='Like' then 3
				when event_type='Share' then 2
			else 1
		end) as engagement_score
	from ad_events 
	group by user_id
), 

rfm_scores as (
	select 
		*,
		ntile(5) over (order by recency_days asc) as r_score,
		ntile(5) over (order by frequency desc) as f_score,
		ntile(5) over (order by engagement_score desc) as e_score
	from rfm_base
)

select 
	*,
	case
		when r_score = 5 and f_score >= 4 and e_score >= 4 then 'Champions'
		when r_score >= 4 and f_score >= 3 and e_score >= 3 then 'Loyal Customers'
		when r_score = 5 and f_score = 1 then 'New Users'
		when r_score >= 4 and f_score = 2 then 'Potential Loyalists'
		when f_score = 1 and e_score <= 2 then 'Low Engagement'
		else 'Regular Users'
	end as segment
from rfm_scores
order by r_score desc, f_score desc, e_score desc