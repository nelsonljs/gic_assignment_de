with source as (
    {{ dbt_utils.union_relations(
        relations=[
            ref('bond_prices_int'), 
            ref('equity_prices_int')
        ],
        source_column_name=None
    ) }}
),

renamed as (
    select 
        *,
        coalesce(ISIN, SYMBOL) as equity_id
    from source
)
select * from renamed
