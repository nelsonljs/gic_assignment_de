with source as (
      select * from {{ source('dataset', 'bond_prices') }}
),
renamed as (
    select
        {{ adapter.quote("DATETIME") }}::date as datetime,
        {{ adapter.quote("ISIN") }} as ISIN,
        {{ adapter.quote("PRICE") }} as PRICE

    from source
)
select * from renamed
  