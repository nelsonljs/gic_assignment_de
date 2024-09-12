with source as (
      select * from {{ source('dataset', 'external_funds') }}
),

renamed as (
    select
        fund_name,
        report_date,
        `FINANCIAL TYPE` as financial_type, 
        SYMBOL, 
        `SECURITY NAME` as security_name, 
        ISIN, 
        PRICE, 
        QUANTITY, 
        `REALISED P/L` as realised_pl, 
        `MARKET VALUE` as market_value

    from source
)

select * from renamed
  