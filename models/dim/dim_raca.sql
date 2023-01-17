/*
    Processo para carga da informação de raça. 

    A origem deste processo é o arquivo de COVID.
*/

with raca_cor as (
    select distinct raca_cor  
      from {{ source('raw_data', 'dados_covid') }}
),

raca_cor_com_chave as (
    select md5(raca_cor) as id_raca,
           raca_cor as desc_raca 
        from raca_cor
)

select * from raca_cor_com_chave