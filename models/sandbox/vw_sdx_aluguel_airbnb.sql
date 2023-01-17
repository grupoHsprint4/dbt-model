

with dados_aluguel as (
    select distinct
            --informações do proprietario
            p.fl_identidade_verificada,
            p.fl_superhost,

            --informações do imovel
            i.tipo_quarto,
            i.qtd_quarto,
            i.qtd_cama,
            i.banheiro,
            i.facilidades,
            i.qtd_max_pessoas,
            i.qtd_min_noites,
            i.qtd_max_noites,
            i.longitude,
            i.latitude,
            i.preco,

            --bairro do imovel
            b.desc_bairro        

      from {{ source('dw_data', 'ft_aluguel_airbnb_mes') }} ft
      join {{ source('dw_data', 'dim_imovel') }} i on ft.id_imovel = i.id_imovel
      join {{ source('dw_data', 'dim_bairro') }} b on ft.id_bairro = b.id_bairro
      join {{ source('dw_data', 'dim_proprietario') }} p on ft.id_proprietario = p.id_proprietario
)

select * from dados_aluguel 


