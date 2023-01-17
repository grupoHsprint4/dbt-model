/*
    Processo para carga da informação de faixa etaria. 

    A origem deste processo é o arquivo de COVID.
*/

with faixa_etaria as (
    select distinct faixa_etaria
    from {{ source('raw_data', 'dados_covid') }}
),

faixa_etaria_com_chave as (
    select md5(faixa_etaria) as id_faixa_etaria,
           faixa_etaria as desc_faixa_etaria
      from faixa_etaria
)

select * from faixa_etaria_com_chave