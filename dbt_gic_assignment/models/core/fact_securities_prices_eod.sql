with source as (
    {{ dbt_utils.union_relations(
        relations=[
            ref('bond_prices_int'), 
            ref('stg_equity_prices')
        ]
    ) }}
),

renamed as (
    select 
        *,
        coalesce(ISIN, SYMBOL) as equity_id
    from source
)
select * from renamed
