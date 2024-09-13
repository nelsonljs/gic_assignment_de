{{config(
    materalized = 'table'
)}}

{% set src_fund_date_holdings = ref('fact_fund_date_holdings')%}
{% set src_security_prices = ref('fact_securities_prices')%}

