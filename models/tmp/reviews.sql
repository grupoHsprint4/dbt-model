/*
    Para esta implementação academia tivemos um problema na limitação por causa do tamanho 
    do arquivo e tivemos que dividir a leitura em 3.

    Este processo tem como objetivo apenas juntar os três arquivos que deveriam ser apenas um.
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
