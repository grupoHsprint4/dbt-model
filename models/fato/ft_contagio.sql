/*
     Processo de carga da Fato com as informações de do COVID no estado do Rio de Janeiro .

     Possui métricas de QT_Morte, QT_Casos_Ativos, QT_Casos e QT_Recuperados.
*/

with contagio as (
    select 
           substr(dc.dt_notific, 7,4) || substr(dc.dt_notific, 1,2) || substr(dc.dt_notific, 4,2) as DT_MOVIMENTO ,
           --MM/DD/YYYY
           s.id_sexo,
           n.id_bairro,
           r.id_raca,
           fe.id_faixa_etaria,
           sum(case when evolucao = 'óbito' then 1 else 0 end) as qt_mortes,
           sum(case when evolucao = 'recuperado'  or evolucao = 'Recuperado' then 1 else 0 end) as qt_recuperados, 
           sum(case when evolucao = 'ativo'  or evolucao = 'Ativo' then 1 else 0 end) as qt_com_covid,
           count(*) as qt_casos
      from {{ source('raw_data', 'dados_covid') }} dc
        join {{ source('dw_data', 'dim_sexo') }} s on dc.sexo = s.desc_sexo
        join {{ source('dw_data', 'dim_bairro') }} n on dc.bairro_resid_estadia = n.desc_bairro
        join {{ source('dw_data', 'dim_raca') }} r on dc.raca_cor = r.desc_raca
        join {{ source('dw_data', 'dim_faixa_etaria') }} fe on dc.faixa_etaria = fe.desc_faixa_etaria
    group by substr(dc.dt_notific, 7,4) || substr(dc.dt_notific, 1,2) || substr(dc.dt_notific, 4,2),
           s.id_sexo,
           n.id_bairro,
           r.id_raca,
           fe.id_faixa_etaria

)

select * from contagio