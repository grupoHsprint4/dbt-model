/*
    Processo para carga da informação de proprietários. 

    Tem como origem o arquivo listing do Inside Airbnb.
*/

with host as (
    select  host_id as id_proprietario, 
            host_name as desc_proprietario, 
            HOST_IDENTITY_VERIFIED as fl_identidade_verificada, 
            HOST_IS_SUPERHOST as fl_superhost
      from {{ source('raw_data', 'listing') }}
),

host_distinct as (
select distinct id_proprietario, desc_proprietario, 
            fl_identidade_verificada, fl_superhost
    from host
)

select * from host_distinct

