with source as (
      select * from {{ ref('stg_bond_reference') }}
),
renamed as (
    select
        *
    from source
)
select * from renamed
  