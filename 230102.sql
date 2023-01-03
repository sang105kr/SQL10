drop table emp_audit_row;
drop sequence emp_audit_row_seq;
create sequence emp_audit_row_seq
    increment by 1
    start with 1
    maxvalue 9999
    minvalue 1
    nocycle
    nocache;
create table emp_audit_row(
    id      number(4),
    uname   varchar2(20),   --사용자이름
    gubun   varchar2(20),   --작업구분(삽입,수정,삭제)
    udate   timestamp,      --변경일시
    empno   number(4,0),    --사번
    old_sal number(7,2),    --변경전 급여
    new_sal number(7,2)     --변경후 급여
);
alter table emp_audit_row add constraint emp_audit_row_id_pk primary key (id);

--시퀀스 다음번호 생성
select emp_audit_row_seq.nextval
  from dual;
  
--시퀀스 현재 번호 조회
select emp_audit_row_seq.currval
  from dual;
  
--트리거 비활성화    
alter trigger emp_tr disable;   
--트리거 활성화    
alter trigger emp_tr enable;  

--insert
insert into emp values(
    8000,'홍길동','analyst',null,'20230101',1000,null,10);
    
--update
update emp
   set sal = sal * 1.1
 where empno = 8000;

--delete
delete from emp where empno = 8000;

select * from emp;
select * from emp_audit_row;
delete from emp_audit_row;

commit;
rollback; 

set verify off;
set serveroutput on;

create or replace trigger emp_tr
after insert or update or delete on emp
for each row
begin
 if inserting then
    insert into emp_audit_row
        values(emp_audit_row_seq.nextval,user,'삽입',systimestamp, :new.empno, :new.sal, :new.sal);
    dbms_output.put_line('삽입');
 elsif  updating then
    insert into emp_audit_row
       values(emp_audit_row_seq.nextval,user,'수정',systimestamp, :new.empno, :old.sal, :new.sal);
    dbms_output.put_line('수정');
 elsif  deleting then
     insert into emp_audit_row
       values(emp_audit_row_seq.nextval,user,'삭제',systimestamp, :old.empno, :old.sal, :old.sal);
    dbms_output.put_line('삭제');
 end if;
end;


select t1.deptno, t1.job, sum(t1.sal)
  from emp t1, dept t2
 where t1.deptno = t2.deptno  
group by t1.deptno, t1.job
order by t1.deptno, t1.job;  

select nvl(to_char(t1.deptno),'총계') "부서", 
       case when t1.deptno is null then 
                ' '
            else
                 nvl(t1.job,'소계')
       end "직무",
       sum(t1.sal) "급여"
  from emp t1, dept t2
 where t1.deptno = t2.deptno  
group by rollup(t1.deptno, t1.job)
order by t1.deptno, t1.job;  

select *
  from ( select t1.*, rownum rank
           from ( select empno, sal
                    from emp
                order by sal desc ) t1 )
where rank = 5 ;
  
select deptno, empno,sal,
       --분석함수(매개값) over()  
       rank() over(partition by deptno order by sal desc)
  from emp;
select deptno, empno,sal,
       --분석함수(매개값) over()  
       dense_rank() over(partition by deptno order by sal desc)
  from emp;  
select deptno, empno,sal,
       --분석함수(매개값) over()  
       row_number() over(partition by deptno order by sal desc)
  from emp;  

select deptno, empno,sal,
       rank()       over(partition by deptno order by sal desc) "rank1",
       dense_rank() over(partition by deptno order by sal desc) "rank2",
       row_number() over(partition by deptno order by sal desc) "rank3"
  from emp;  

select deptno, empno, sal,
       ntile(3) over(order by sal desc) "grade"
  from emp;

select deptno, empno, sal,
       ntile(3) over(partition by deptno order by sal desc) "grade",
       lag(sal,1,0) over(partition by deptno order by sal desc) "next",
       lead(sal,1,0) over(partition by deptno order by sal desc) "pre"
  from emp;
