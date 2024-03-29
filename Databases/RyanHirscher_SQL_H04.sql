#Ryan Hirscher

#29
select EMP_FNAME, EMP_LNAME, EMP_EMAIL
from LGEMPLOYEE
where EMP_HIREDATE >= '2005-01-01' and EMP_HIREDATE < '2014-12-31'
order by EMP_LNAME, EMP_FNAME;

#31
select LE.EMP_NUM, LE.EMP_LNAME, LE.EMP_FNAME, LS.SAL_FROM as start_time, LS.SAL_END as end_time, LS.SAL_AMOUNT 
from LGSALARY_HISTORY LS join LGEMPLOYEE LE on LE.EMP_NUM=LS.EMP_NUM
where LS.EMP_NUM in ('83731', '83745', '84039')
order by LS.EMP_NUM;

#32
select distinct CUST_FNAME, CUST_LNAME, CUST_STREET, CUST_CITY, CUST_STATE, CUST_ZIP, I.INV_DATE 
from LGCUSTOMER CUS join LGINVOICE I on CUS.CUST_CODE=I.CUST_CODE
join LGLINE L on L.INV_NUM=I.INV_NUM join LGPRODUCT P on L.PROD_SKU=P.PROD_SKU
join LGBRAND B on P.BRAND_ID=B.BRAND_ID 
where B.BRAND_NAME='Foresters Best' and P.PROD_CATEGORY='Top Coat' and (I.INV_DATE >= '2017-07-15' and I.INV_DATE < '2017-07-31')
order by CUST_STATE, CUST_LNAME, CUST_FNAME;

#38
select distinct B.BRAND_ID, B.BRAND_NAME,round(avg(P.PROD_PRICE), 2) as AVGPRICE
from LGBRAND B join LGPRODUCT P on B.BRAND_ID=P.BRAND_ID
group by B.BRAND_ID
order by B.BRAND_NAME;

#41
select C.CUST_CODE, C.CUST_FNAME, C.CUST_LNAME, sum(I.INV_TOTAL) as Total_Invoices
from LGCUSTOMER C join LGINVOICE I on C.CUST_CODE=I.CUST_CODE
group by C.CUST_CODE 
having sum(I.INV_TOTAL) > 1500
order by sum(I.INV_TOTAL) desc;

#43
select V.VEND_ID, V.VEND_NAME, B.BRAND_NAME, count(P.PROD_SKU) as NUM_PRODUCTS
from LGVENDOR V join LGSUPPLIES S on V.VEND_ID=S.VEND_ID join LGPRODUCT P on P.PROD_SKU=S.PROD_SKU
join LGBRAND B on B.BRAND_ID=P.BRAND_ID
group by V.VEND_ID, V.VEND_NAME, B.BRAND_NAME 
order by V.VEND_NAME, B.BRAND_NAME;

#46
select BP.BRAND_ID, BP.BRAND_NAME, BP.BRAND_TYPE, max(BP.AVGPRICE)
from (select distinct B.BRAND_ID, B.BRAND_NAME, B.BRAND_TYPE, round(avg(P.PROD_PRICE), 2) as AVGPRICE
from LGBRAND B join LGPRODUCT P on B.BRAND_ID=P.BRAND_ID
group by B.BRAND_ID
order by round(avg(P.PROD_PRICE), 2) desc) as BP;

#47
select EE.EMP_FNAME as Manager_FName, EE.EMP_LNAME as Manager_LName, D.DEPT_NAME, D.DEPT_PHONE, 
E.EMP_FNAME as Employee_FName, E.EMP_LNAME as Employee_LName, C.CUST_FNAME, C.CUST_LNAME, 
I.INV_DATE, I.INV_TOTAL
from LGEMPLOYEE E join LGDEPARTMENT D on D.DEPT_NUM=E.DEPT_NUM
join LGEMPLOYEE EE on D.EMP_NUM=EE.EMP_NUM
join LGINVOICE I on E.EMP_NUM=I.EMPLOYEE_ID
join LGCUSTOMER C on I.CUST_CODE=C.CUST_CODE
where I.INV_DATE = '2017-05-18' and C.CUST_LNAME = 'Hagan';

#50
select distinct LL.LINE_NUM, PP.PROD_SKU, PP.PROD_DESCRIPT, ILP.LINE_NUM, ILP.PROD_SKU, ILP.PROD_DESCRIPT, B.BRAND_ID
from (select distinct I.INV_NUM, L.LINE_NUM, P.PROD_SKU, P.PROD_DESCRIPT
from LGINVOICE I join LGLINE L on I.INV_NUM=L.INV_NUM
join LGPRODUCT P on P.PROD_SKU=L.PROD_SKU) as ILP
join LGLINE LL on ILP.INV_NUM=LL.INV_NUM
join LGPRODUCT PP on ILP.PROD_SKU=PP.PROD_SKU
join LGBRAND B on B.BRAND_ID=PP.BRAND_ID
order by LL.LINE_NUM, LL.LINE_NUM;

#53
select C.CUST_CODE, C.CUST_FNAME, C.CUST_LNAME, C.CUST_STREET, C.CUST_CITY, 
C.CUST_STATE, C.CUST_ZIP, I.INV_DATE, max(I.INV_TOTAL) as Largest_Invoice
from LGCUSTOMER C join LGINVOICE I on C.CUST_CODE=I.CUST_CODE
where C.CUST_STATE='AL'# and I.INV_TOTAL = (select case when I.INV_TOTAL is null then 0 else 1 end)
group by C.CUST_CODE
order by C.CUST_LNAME, C.CUST_FNAME;
