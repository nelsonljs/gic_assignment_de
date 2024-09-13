{{config(
    materalized = 'table'
)}}

{% set src_fund_date_holdings = ref('fact_fund_date_holdings')%}
{% set src_security_prices = ref('fact_securities_prices_eod')%}

with src_fund_date_holdings as (
    select
        *
    from
        {{ ref('fact_fund_date_holdings') }}
),

src_security_prices as (
    select
        *
    from
        {{ ref('fact_securities_prices_eod') }}
),

joined as (
    select
        a.*,
        b.price as actual_eod_price
    from
        src_fund_date_holdings a 
        left join src_security_prices b on (
            a.equity_id = b.equity_id and
            a.report_date = b.date_day
        )
),

enriched as (
    select
        *,
        price = actual_eod_price as is_price_matched,
        price - actual_eod_price as price_break
    from
        joined
)

select * 
from enriched
