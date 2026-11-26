with 

source as (

    select * from {{ source('gw', 'prod') }}

),

renamed as (

    select
        products_id as product_id,
        purchase_price

    from source

)

select * from renamed