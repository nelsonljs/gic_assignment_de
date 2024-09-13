{{config(
    materialized = 'view'
)}}

-- Get End of DAY price by extending end of week prices using a datespine.
with date_spine as (
    select
        date_day
    from
        {{ ref('dim_date') }}
    where
        date_day < current_date()
),

-- In case of duplicates, dedupe on day.
src_equity_prices as (
    select
        DATETIME::date as equity_price_date,
        SYMBOL,
        price,
        first_value(price) over (partition by SYMBOL, equity_price_date order by datetime) as last_recorded_price_by_day
    from    
        {{ ref('stg_equity_prices') }}
),

get_eod_equity_prices as (
    select
        equity_price_date,
        SYMBOL,
        last_recorded_price_by_day
    from
        src_equity_prices
    group by all
),

get_pseudo_type2_table as (
    select
        *,
        lead(DATETIME, 1, '2999-01-01') RESPECT NULLS over (partition by SYMBOL order by equity_price_date) as lead_date_to
        equity_price_date as date_from,
        dateadd('day', -1, lead_date_to) as date_to
    from
        get_eod_equity_prices
),

joined as (
    select
        date_day,
        last_recorded_price_by_day as price,
        SYMBOL
    from date_spine 
    left join src_equity_prices s on
        (date_spine.date_day between s.date_from and s.date_to)
)

select *
from joined