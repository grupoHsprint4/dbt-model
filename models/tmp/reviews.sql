/*
    Devido a uma limitação da origem em relação ao tamanho do arquivo, foi necessário a 
    quebra dele em três partes.

    Essa etapa será para unir as três tabelas criadas para que possa ser feita o tratamento
    em todas as partes do arquivo de uma vez.
*/


with reviews_union as (
    select *
      from {{ source('raw_data', 'reviewpt1') }}
    union
    select *
      from {{ source('raw_data', 'reviewpt2') }}
    union
    select *
      from {{ source('raw_data', 'reviewpt3') }}
)

select * from reviews_union
