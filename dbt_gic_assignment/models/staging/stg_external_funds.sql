with source as (
      select * from {{ source('dataset', 'external_funds') }}
),

renamed as (
    select
        "FUND_NAME"                 as fund_name,
        "REPORT_DATE"::date         as report_date,
        "FINANCIAL TYPE"            as financial_type, 
        "SYMBOL"                    as SYMBOL, 
        "SECURITY NAME"             as security_name, 
        "ISIN"                      as ISIN, 
        "PRICE"::real               as PRICE, 
        "QUANTITY"                  as QUANTITY, 
        "REALISED P/L"::real        as realised_pl, 
        "MARKET VALUE"::real        as market_value

    from source
)

select * from renamed
  