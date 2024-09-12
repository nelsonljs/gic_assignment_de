with source as (
      select * from {{ source('dataset', 'bond_reference') }}
),
renamed as (
    select *
    from source
)
select * from renamed
  