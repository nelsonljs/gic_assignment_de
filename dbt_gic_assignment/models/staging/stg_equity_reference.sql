with source as (
      select * from {{ source('dataset', 'equity_reference') }}
),
renamed as (
    select
        {{ adapter.quote("SYMBOL") }} as SYMBOL,
        {{ adapter.quote("COUNTRY") }},
        {{ adapter.quote("SECURITY NAME") }} as security_name,
        {{ adapter.quote("SECTOR") }},
        {{ adapter.quote("INDUSTRY") }},
        {{ adapter.quote("CURRENCY") }}

    from source
)
select * from renamed
  