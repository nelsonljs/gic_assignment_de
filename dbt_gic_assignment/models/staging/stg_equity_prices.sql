with source as (
      select * from {{ source('dataset', 'equity_prices') }}
),
renamed as (
    select
        {{ adapter.quote("DATETIME") }}::date as datetime,
        {{ adapter.quote("SYMBOL") }} as SYMBOL,
        {{ adapter.quote("PRICE") }} as price

    from source
)
select * from renamed
  