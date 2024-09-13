with source as (
      select * from {{ ref('stg_equity_reference') }}
),
renamed as (
    select
        *
    from source
)
select * from renamed
  