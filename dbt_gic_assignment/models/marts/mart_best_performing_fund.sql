{{config(
    materialized = 'table'
)}}

with src_fund_date_holdings as (
    select
        *
    from
        {{ ref('fact_fund_date_holdings') }}
),

filtered as (
    select
        *
    from
        src_fund_date_holdings
    where
        financial_type = 'Equities'
),

get_aggregation_by_fund_and_date as (
    select
        fund_name,
        report_date,
        sum(realised_pl) as total_realised_pl,
        sum(market_value) as total_market_value,
        sum(market_value + realised_pl) as total_current_value
    from
        filtered
    group by 1,2
),

sum_of_fund_equity_value as (
    select
        *,
        lag(total_current_value) over (partition by fund_name order by report_date) as previous_month_value,
        first_value(total_current_value) over (partition by fund_name order by report_date) as initial_investment_value
    from
        get_aggregation_by_fund_and_date
),

get_performance_metrics as (
    select
        *,
        total_current_value - previous_month_value as difference_month_value,
        (total_current_value - previous_month_value) / previous_month_value as percent_change,
        total_current_value - initial_investment_value as cumulative_change,
        (total_current_value - initial_investment_value) / initial_investment_value as percent_cumulative_change
    from
        sum_of_fund_equity_value
),

get_rankings as (
    select
        *,
        dense_rank() over (partition by report_date order by percent_change desc) as monthly_fund_rank,
        dense_rank() over (partition by report_date order by percent_cumulative_change desc) as cumulative_fund_rank
    from
        get_performance_metrics
)

select *
from get_rankings
order by report_date