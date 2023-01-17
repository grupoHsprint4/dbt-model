

{{ config(materialized='view') }}

with airbnb_covid as (
    select fta.mes_movimento,
           b.desc_bairro,
           fta.qtd_locacoes,
           ftc.qt_com_covid,
           ftc.qt_recuperados,
           ftc.qt_mortes,
           ftc.qt_casos
      from {{ source('dw_data', 'ft_aluguel_airbnb_mes') }} fta
      join {{ source('dw_data', 'ft_contagio_mes')}} ftc on fta.id_bairro = fta.id_bairro 
                                                        and fta.mes_movimento = ftc.mes_movimento
      join {{ source('dw_data', 'dim_bairro')}} b on fta.id_bairro = b.id_bairro

)

select * from airbnb_covid