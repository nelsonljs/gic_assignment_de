with source as (
      select * from {{ source('dataset', 'equity_reference') }}
),
renamed as (
    select *
    from source
)
select * from renamed
  