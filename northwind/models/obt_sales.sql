with f_sales as (
    select * from {{ ref('fact_sales') }}
),
d_customer as (
    select * from {{ ref('dim_customer') }}
),
d_employee as (
    select * from {{ ref('dim_employee') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
),
d_product as (
    select * from {{ ref('dim_product') }}
)

select 
    f.orderid,
    f.quantity,
    f.extendedpriceamount,
    f.discountamount,
    f.soldamount,
    dc.*,
    de.*,
    dd.*,
    dp.*
from f_sales f
left join d_customer dc on f.customerkey = dc.customerkey
left join d_employee de on f.employeekey = de.employeekey
left join d_date dd on f.orderdatekey = dd.datekey
left join d_product dp on f.productkey = dp.productkey
