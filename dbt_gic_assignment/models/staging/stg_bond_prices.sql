with source as (
      select * from {{ source('dataset', 'bond_prices') }}
),
renamed as (
    select *
    from source
)
select * from renamed
  