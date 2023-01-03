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
    uname   varchar2(20),   --������̸�
    gubun   varchar2(20),   --�۾�����(����,����,����)
    udate   timestamp,      --�����Ͻ�
    empno   number(4,0),    --���
    old_sal number(7,2),    --������ �޿�
    new_sal number(7,2)     --������ �޿�
);
alter table emp_audit_row add constraint emp_audit_row_id_pk primary key (id);

--������ ������ȣ ����
select emp_audit_row_seq.nextval
  from dual;
  
--������ ���� ��ȣ ��ȸ
select emp_audit_row_seq.currval
  from dual;
  
--Ʈ���� ��Ȱ��ȭ    
alter trigger emp_tr disable;   
--Ʈ���� Ȱ��ȭ    
alter trigger emp_tr enable;  

--insert
insert into emp values(
    8000,'ȫ�浿','analyst',null,'20230101',1000,null,10);
    
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
        values(emp_audit_row_seq.nextval,user,'����',systimestamp, :new.empno, :new.sal, :new.sal);
    dbms_output.put_line('����');
 elsif  updating then
    insert into emp_audit_row
       values(emp_audit_row_seq.nextval,user,'����',systimestamp, :new.empno, :old.sal, :new.sal);
    dbms_output.put_line('����');
 elsif  deleting then
     insert into emp_audit_row
       values(emp_audit_row_seq.nextval,user,'����',systimestamp, :old.empno, :old.sal, :old.sal);
    dbms_output.put_line('����');
 end if;
end;


select t1.deptno, t1.job, sum(t1.sal)
  from emp t1, dept t2
 where t1.deptno = t2.deptno  
group by t1.deptno, t1.job
order by t1.deptno, t1.job;  

select nvl(to_char(t1.deptno),'�Ѱ�') "�μ�", 
       case when t1.deptno is null then 
                ' '
            else
                 nvl(t1.job,'�Ұ�')
       end "����",
       sum(t1.sal) "�޿�"
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
       --�м��Լ�(�Ű���) over()  
       rank() over(partition by deptno order by sal desc)
  from emp;
select deptno, empno,sal,
       --�м��Լ�(�Ű���) over()  
       dense_rank() over(partition by deptno order by sal desc)
  from emp;  
select deptno, empno,sal,
       --�м��Լ�(�Ű���) over()  
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
