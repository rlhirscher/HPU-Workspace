#1
select EMP_NUM, EMP_LNAME, EMP_FNAME, EMP_INITIAL 
from EMPLOYEE where EMP_LNAME like 'Smith%';

#2
select PROJ_NAME, PROJ_VALUE, PROJ_BALANCE, EMP_LNAME, EMP_FNAME, EMP_INITIAL, JOB.JOB_CODE, JOB_DESCRIPTION, JOB_CHG_HOUR 
from PROJECT join EMPLOYEE on EMPLOYEE.EMP_NUM = PROJECT.EMP_NUM join JOB on JOB.JOB_CODE = EMPLOYEE.JOB_CODE order by PROJ_VALUE;

#3
select PROJ_NAME, PROJ_VALUE, PROJ_BALANCE, EMP_LNAME, EMP_FNAME, EMP_INITIAL, JOB.JOB_CODE, JOB_DESCRIPTION, JOB_CHG_HOUR 
from PROJECT join EMPLOYEE on EMPLOYEE.EMP_NUM = PROJECT.EMP_NUM join JOB on JOB.JOB_CODE = EMPLOYEE.JOB_CODE order by EMP_LNAME ASC;

#4
select distinct PROJ_NUM 
from ASSIGNMENT order by PROJ_NUM;

#5 
select ASSIGN_NUM, PROJ_NUM, EMP_NUM, ASSIGN_CHARGE, ASSIGN_CHG_HR * ASSIGN_HOURS as PRODUCT 
from ASSIGNMENT order by ASSIGN_NUM;

#6
select ASSIGNMENT.EMP_NUM, EMP_LNAME, sum(ASSIGNMENT.ASSIGN_HOURS) as SumOfASSIGN_HOURS, sum(ASSIGNMENT.ASSIGN_CHG_HR*ASSIGNMENT.ASSIGN_HOURS) as SumOfASSING_CHARGE 
from EMPLOYEE, ASSIGNMENT where EMPLOYEE.EMP_NUM=ASSIGNMENT.EMP_NUM group by ASSIGNMENT.EMP_NUM, EMP_LNAME order by ASSIGNMENT.EMP_NUM;

#7
select PROJ_NUM, sum(ASSIGN_HOURS) as SumOfASSIGN_HOURS, sum(ASSIGN_CHARGE) as SumOfASSIGN_CHARGE 
from ASSIGNMENT group by PROJ_NUM order by PROJ_NUM;

#8
select sum(ASSIGN_HOURS) as SumOfASSIGN_HOURS, sum(ASSIGN_CHARGE) as SumOfASSIGN_CHARGE 
from ASSIGNMENT;
