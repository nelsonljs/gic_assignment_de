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
        date_day < current_date
),

src_bond_prices as (
    select
        *
    from    
        {{ ref('stg_bond_prices') }}
),

get_pseudo_type2_table as (
    select
        *,
        lead(DATETIME, 1, '2999-01-01') over (partition by ISIN order by datetime) as lead_date_to,
        datetime as date_from
    from
        src_bond_prices
),

enrichments as (
    select
        *,
        lead_date_to - INTERVAL '1 day' as date_to
    from
        get_pseudo_type2_table
),

joined as (
    select
        date_day,
        price,
        ISIN
    from date_spine 
    left join enrichments s on
        (date_spine.date_day between s.date_from and s.date_to)
    where isin is not null
)

select *
from joined

