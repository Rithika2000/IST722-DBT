with stg_orders as (
    select * from {{ source('northwind', 'Orders') }}
),
stg_order_details as (
    select * from {{ source('northwind', 'Order_Details') }}
)

select 
    o.orderid,
    {{ dbt_utils.generate_surrogate_key(['o.customerid']) }} as customerkey,
    {{ dbt_utils.generate_surrogate_key(['o.employeeid']) }} as employeekey,
    replace(to_date(o.orderdate)::varchar,'-','')::int as orderdatekey,
    {{ dbt_utils.generate_surrogate_key(['d.productid']) }} as productkey,
    d.quantity,
    d.quantity * d.unitprice as extendedpriceamount,
    (d.quantity * d.unitprice) * d.discount as discountamount,
    (d.quantity * d.unitprice) - ((d.quantity * d.unitprice) * d.discount) as soldamount
from stg_orders o
join stg_order_details d on o.orderid = d.orderid
