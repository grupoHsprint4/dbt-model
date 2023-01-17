


with contagio_mes as (
    select substr(dt_movimento, 1, 6) as mes_movimento,
           id_sexo,
           id_bairro,
           id_raca,
           id_faixa_etaria,
           sum(qt_mortes) as qt_mortes,
           sum(qt_recuperados) as qt_recuperados,
           sum(qt_com_covid) as qt_com_covid,
           sum(qt_casos) as qt_casos
      from {{ source('dw_data','ft_contagio') }}
    group by substr(dt_movimento, 1, 6),
           id_sexo,
           id_bairro,
           id_raca,
           id_faixa_etaria

)

select * from contagio_mes