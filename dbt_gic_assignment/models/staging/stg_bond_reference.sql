with source as (
      select * from {{ source('dataset', 'bond_reference') }}
),
renamed as (
    select
        {{ adapter.quote("SECURITY NAME") }} as security_name,
        {{ adapter.quote("ISIN") }} as ISIN,
        {{ adapter.quote("SEDOL") }},
        {{ adapter.quote("COUNTRY") }},
        {{ adapter.quote("COUPON") }},
        {{ adapter.quote("MATURITY DATE") }} as maturity_date,
        {{ adapter.quote("COUPON FREQUENCY") }} as coupon_frequency,
        {{ adapter.quote("SECTOR") }},
        {{ adapter.quote("CURRENCY") }}

    from source
)
select * from renamed
  