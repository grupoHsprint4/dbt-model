/*

*/

with houses as (
    select id as id_imovel, 
           name as desc_imovel,
           beds as qtd_cama,
           BEDROOMS as qtd_quarto,
           bathrooms_text as banheiro,
           room_type as tipo_quarto,
           accommodates as qtd_max_pessoas,
           neighbourhood_cleansed as bairro,
           AMENITIES as facilidades,
           longitude,
           LATITUDE,
           minimum_nights as qtd_min_noites,
           maximum_nights as qtd_max_noites,
           price as preco

      from {{ source('raw_data', 'listing') }}

)

select * from houses