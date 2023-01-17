/*
    Processo para carga da informação de bairros. 

    Possui como fontes os arquivo da COVID e o arquivos do airbnb.

*/

with bairros_airbnb as (
    select distinct
        replace(        replace(        replace(        replace(        replace(
        replace(        replace(        replace(        replace(
                upper(neighbourhood)
                , 'Ã', 'A')                , 'Á', 'A')                , 'Â', 'A')
                , 'É', 'E')                , 'Ê', 'E')                , 'Í', 'I')
                , 'Ó', 'O')                , 'Ú', 'U')                , 'Ç', 'C') as neighbourhood

      from {{ source('raw_data', 'neighbourhood') }}
),

bairros_covid as (
    select distinct bairro_resid_estadia as neighbourhood
      from {{ source('raw_data', 'dados_covid') }}
),

bairros_airbnb_covid as (
    select * 
      from bairros_airbnb
    union
    select *
      from bairros_covid
),

bairros_com_chave as (
    select md5 (neighbourhood) as id_bairro,
           neighbourhood as desc_bairro
      from bairros_airbnb_covid
)

select * from bairros_com_chave