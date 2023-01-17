/*



*/


with sexo as (
    select distinct sexo 
      from {{ source('raw_data', 'dados_covid') }}

),


sexo_com_chave as (
    select md5(sexo) as id_sexo,
           sexo as desc_sexo
      from sexo
)

select * from sexo_com_chave
