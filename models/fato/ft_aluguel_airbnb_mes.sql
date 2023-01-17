/*
     Processo de carga da Fato com as informações de aluguel do airbnb agregadas por mês.

     Criação de métrica de quantidade de locações por mês.
*/

with aluguel_mes as (
    select substr(DT_MOVIMENTO, 1, 6) as MES_MOVIMENTO,
           id_imovel,
           id_proprietario,
           id_bairro,
           count(*) as qtd_locacoes
      from {{ source('dw_data', 'ft_aluguel_airbnb') }}
      group by substr(DT_MOVIMENTO, 1, 6) ,
           id_imovel,
           id_proprietario,
           id_bairro
)

select * from aluguel_mes