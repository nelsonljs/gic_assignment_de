{{config(
    materialized = 'table'
)}}

{% set src_stg_external_funds = ref('stg_external_funds') %}

with source as (
    select
        *
    from
        {{ src_stg_external_funds }}
),

enrichments as (
    select 
        *,
        coalesce(ISIN, SYMBOL) as equity_id
    from source
)

select * from renamed
