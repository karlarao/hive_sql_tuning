-- explain plan/instrumentation settings
set hive.log.explain.output=true;
set hive.explain.user=true;
set hive.tez.exec.print.summary=true;

-- hive params to test
--set hive.auto.convert.join = false;

explain formatted
select count(employees.department_id)
from hr.employees 
join hr.departments 
on employees.department_id = departments.department_id;