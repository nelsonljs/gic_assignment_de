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
src_bond_prices as (
    select
        DATETIME::date as bond_price_date,
        ISIN,
        price,
        first_value(price) over (partition by ISIN, bond_price_date order by datetime) as last_recorded_price_by_day
    from    
        {{ ref('stg_bond_prices') }}
),

get_eod_bond_prices as (
    select
        bond_price_date,
        ISIN,
        last_recorded_price_by_day
    from
        src_bond_prices
    group by all
),

get_pseudo_type2_table as (
    select
        *,
        lead(DATETIME, 1, '2999-01-01') RESPECT NULLS over (partition by ISIN order by bond_price_date) as lead_date_to
        bond_price_date as date_from,
        dateadd('day', -1, lead_date_to) as date_to
    from
        get_eod_bond_prices
),

joined as (
    select
        date_day,
        last_recorded_price_by_day as price,
        ISIN
    from date_spine 
    left join src_bond_prices s on
        (date_spine.date_day between s.date_from and s.date_to)
)

select *
from joined

