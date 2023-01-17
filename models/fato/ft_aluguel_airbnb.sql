/*
    Processo de carga da Fato com as informações de aluguel do airbnb.

    Esta fato funciona apenas para fazer uma relação no tempo entre imóvel, proprietário e bairro.
    Não possui uma métrica.
*/

with review_listing as (
    select replace(r.date, '-', '') as DT_MOVIMENTO,
           i.id_imovel,
           p.id_proprietario,
           replace(        replace(        replace(        replace(        replace(
           replace(        replace(        replace(        replace(
                upper(l.NEIGHBOURHOOD_CLEANSED)
                , 'Ã', 'A')                , 'Á', 'A')                , 'Â', 'A')
                , 'É', 'E')                , 'Ê', 'E')                , 'Í', 'I')
                , 'Ó', 'O')                , 'Ú', 'U')                , 'Ç', 'C') as bairro
      from {{ source('dw_data', 'reviews') }} r
      join {{ source('raw_data', 'listing') }} l on r.listing_id = l.id
      join {{ source('dw_data', 'dim_imovel') }} i on l.id = i.id_imovel
      join {{ source('dw_data', 'dim_proprietario') }} p on l.host_id = p.id_proprietario
      --
),

dataset_com_endereco as (
    select l.DT_MOVIMENTO,
           l.id_imovel,
           l.id_proprietario,
           b.id_bairro
      from review_listing l
      join {{ source('dw_data', 'dim_bairro') }} b on l.bairro = b.desc_bairro

)

select * from dataset_com_endereco