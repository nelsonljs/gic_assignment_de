with source as (
      select * from {{ source('dataset', 'equity_prices') }}
),
renamed as (
    select *
    from source
)
select * from renamed
  