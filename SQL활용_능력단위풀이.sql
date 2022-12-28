--�������� ����
alter table department drop constraint department_manager_fk;
alter table employee   drop constraint employee_deptno_fk;
alter table employee   drop constraint employee_phoneno_uk;
alter table project    drop constraint project_deptno_fk;
alter table works      drop constraint works_projno_fk;
alter table works      drop constraint works_empno_fk;

--���̺� ����
drop table department;
drop table employee;
drop table project;
drop table works;

--���̺� ����
--1) department
create table department(
    deptno      number(2),
    deptname    varchar2(20),
    manager     number(4)
);

--2) employee
create table employee(
    empno       number(4),
    name        varchar2(20),
    phoneno     varchar2(20),
    address     varchar2(20),
    sex         char(3),
    position    varchar2(20),
    salary      number(7),
    deptno      number(2)
);

--3) project
create table project(
    projno      number(3),
    projname    varchar2(20),
    deptno      number(2)
);

--4) works
create table works(
    projno      number(3),
    empno       number(4),
    hoursworked number(3)
);

--��������
--1)�⺻Ű primary key
alter table department  add constraint department_deptno_pk  primary key(deptno);
alter table employee    add constraint employee_empno_pk     primary key(empno);
alter table project     add constraint project_projno_pk     primary key(projno);
alter table works       add constraint works_projno_empno_pk primary key(projno,empno); 

--2)�ʼ��Ӽ� not null
alter table employee    modify name     constraint employee_name_nn      not null;
--alter table employee add constraint employee_name_ck
--                     check(name is not null);   
alter table department  modify deptno   constraint department_deptno_nn  not null;
alter table project     modify projname constraint employee_projname_nn  not null;

--3)üũ���� check
alter table employee    add constraint  employee_sex_ck         check( sex in('��','��') );
alter table works       add constraint  works_hoursworked_ck    check( hoursworked > 0 );    

--4)�ܷ�Ű    foreign key
alter table department  add constraint  department_manager_fk   
    foreign key(manager) references employee(empno);
alter table employee    add constraint  employee_deptno_fk   
    foreign key(deptno) references department(deptno); 
alter table project     add constraint  project_deptno_fk   
    foreign key(deptno) references department(deptno);     
alter table works       add constraint  works_projno_fk   
    foreign key(projno) references project(projno);   
alter table works       add constraint  works_empno_fk   
    foreign key(empno)  references employee(empno); 

--6)�ߺ� �Ұ� unique (null���� 1���� ��ȿ)
alter table employee    add constraint  employee_phoneno_uk unique(phoneno);

--���� ������ ����
insert into department (deptno, deptname) values (10, '������');
insert into department (deptno, deptname) values (20, 'ȸ����');
insert into department (deptno, deptname) values (30,'������');
insert into department (deptno, deptname) values (40, '�ѹ���');
insert into department (deptno, deptname) values (50,'�λ���');

insert into project values (101, '�����ͱ���', 10);
insert into project values (102, 'IFRS', 20);
insert into project values (103, '������', 30);

insert into employee values (1001,'ȫ�浿1','010-111-1001','���1','��','����',7000000,10);
insert into employee values (1002,'ȫ�浿2','010-111-1002','���2','��','����1',4000000,10);
insert into employee values (1003,'ȫ�浿3','010-111-1003','���3','��','����2',3000000,10);
insert into employee values (1004,'ȫ�浿4','010-111-1004','�λ�1','��','����',6000000,20);
insert into employee values (1005,'ȫ�浿5','010-111-1005','�λ�2','��','����1',3500000,20);
insert into employee values (1006,'ȫ�浿6','010-111-1006','�λ�3','��','����2',2500000,20);
insert into employee values (1007,'ȫ�浿7','010-111-1007','����1','��','����',5000000,30);
insert into employee values (1008,'ȫ�浿8','010-111-1008','����2','��','����1',4000000,30);
insert into employee values (1009,'ȫ�浿9','010-111-1009','����3','��','����2',3000000,30);
insert into employee values (1010,'ȫ�浿10',null,'����4','��','����3',2000000,30);
insert into employee values (1011,'ȫ�浿11','010-111-1011','�뱸1','��','����',5500000,40);
insert into employee values (1012,'ȫ�浿12','010-111-1012','�뱸2','��','����1',2000000,40);
insert into employee values (1013,'ȫ�浿13','010-111-1013','����1','��','����',6500000,50);
insert into employee values (1014,'ȫ�浿14','010-111-1014','����2','��','����1',3500000,50);

insert into works values (101, 1001, 800);
insert into works values (101, 1002, 400);
insert into works values (101, 1003, 300);
insert into works values (102, 1004, 700);
insert into works values (102, 1005, 500);
insert into works values (102, 1006, 200);
insert into works values (103, 1007, 500);
insert into works values (103, 1008, 400);
insert into works values (103, 1009, 300);
insert into works values (103, 1010, 200);

--�μ� ������ insert-> ��� ������ insert-> update �μ� ���̺�
update department set manager = 1001 where deptno = 10;
update department set manager = 1004 where deptno = 20;
update department set manager = 1007 where deptno = 30;
update department set manager = 1011 where deptno = 40;
update department set manager = 1013 where deptno = 50;
commit;

--1. ���̺��� �����ϴ� create���� �ۼ��ϰ� ������ ���̽ÿ�. �������� �̹ݿ��� 2�� ����.
--��������
desc department;
desc employee;
desc project;
desc works;
--�������Ǻ���
select *
  from user_constraints
 where table_name in ('DEPARTMENT','EMPLOYEE','PROJECT','WORKS')
   AND constraint_type = 'P'; 
   
select * 
  from user_indexes;
  
--2) �����͸� �����ϴ� insert���� �ۼ��ϰ� ����� ����� ���̽ÿ�.  
select * from department;
select * from employee;
select * from project;
select * from works;

--3. ���� ����� �̸�, ����ó, �ּҸ� ���̽ÿ�. 
select name "�̸�" ,phoneno "����ó" ,address "�ּ�"
  from employee
 where sex = '��';


--4. ������ �޿��� 10%�λ��� ���̽ÿ�. (��, department���̺��� Ȱ���Ͻÿ�.)
--update employee t1
--   set salary = salary * 1.1
-- where empno = ( select t2.manager
--                   from department t2
--                  where t2.deptno = t1.deptno);                
update employee t1
   set salary = salary * 1.1
 where empno in ( select t2.manager
                    from department t2);
commit;
select * from employee;
--5. ��� �� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
    select substr(t1.name,1,1) "��", count(*) "�ο���"
      from employee t1
  group by substr(t1.name,1,1);   
  
--6. ���������� �μ����� ���ϴ� ����� �̸�, ����ó, �ּҸ� ���̽ÿ�. (�� ����ó ������ ������ó ������ , ����ó ��4�ڸ� �� ��2�ڸ��� ��ǥ * �� ǥ���Ͻÿ�. ��) 010-111-**78 )
select t2.name "�̸�", 
       nvl2(phoneno,substr(phoneno,1,8) || '**' || substr(phoneno,11,2),'����ó����') "����ó", 
       t2.address "�ּ�"
  from department t1, employee t2
 where t1.deptno = t2.deptno
   and t1.deptname = '������'; 

--7. ��ȫ�浿7�� ����(manager) �μ����� ���ϴ� ������ ���� ���̽ÿ�. 
select count(*) "���� ��"
  from employee
 where deptno = ( select t2.deptno
                    from department t1, employee t2
                   where t1.deptno = t2.deptno
                     and t2.name = 'ȫ�浿7' )
   and name <> 'ȫ�浿7'; 
--8. ������Ʈ�� �������� ���� ����� �̸��� ���̽ÿ�.
--1) left outer join
  select t1.name
    from employee t1, works t2
   where t1.empno = t2.empno(+)
     and t2.projno is null; 
--2) �������
  select t1.name
    from employee t1
   where not exists ( select *
                        from works t2
                       where t2.empno = t1.empno ); 
--3) not in
  select name
    from employee
   where empno not in ( select distinct empno
                          from works );
--4) ������
select name
  from employee
 where empno in (  select empno
                     from employee
                   minus
                    select distinct empno
                      from works );
--9. �޿� ���� TOP 3�� ������ �Բ� ���̽ÿ�.
select rownum, t1.*
  from (  select *
            from employee
        order by salary desc ) t1
 where rownum <=3;
--10. ������� ���� �ð� ���� �μ���, ��� �̸��� ������������ ���̽ÿ�. 
    select t1.deptname "�μ���", t2.name "�̸�", nvl(sum(t3.hoursworked),0) "���� �ð�"
      from department t1, employee t2, works t3
     where t2.deptno = t1.deptno(+)
       and t2.empno  = t3.empno(+)
  group by t1.deptname, t2.name
  order by t1.deptname, t2.name;
--11. 2�� �̻��� ����� ������ ������Ʈ�� ��ȣ, ������Ʈ��, ����� ���� ���̽ÿ�. 
  select t2.projno "������Ʈ ��ȣ", 
         t2.projname "������Ʈ��", 
         count(*) "�����"
    from works t1, project t2
   where t1.projno = t2.projno 
group by t2.projno, t2.projname
  having count(*) >= 2;
  
--12. 3�� �̻��� ����� �ִ� �μ��� ��� �̸��� ���̽ÿ�. 
select t3.deptname "�μ���", t4.name "�̸�"
  from department t3, employee t4
 where t3.deptno = t4.deptno
   and t3.deptno in  ( select t1.deptno
                         from department t1, employee t2
                        where t1.deptno = t2.deptno 
                     group by t1.deptno
                       having count(*) >= 3 );
--13. ������Ʈ�� �����ð��� ���� ���� ����� ���� ����� �̸��� ���̽ÿ�.
  select t2.empno "���", t1.name "�̸�", sum(t2.hoursworked) "�ð�"
    from employee t1 , works t2
   where t1.empno = t2.empno 
group by t2.empno, t1.name
  having sum(t2.hoursworked) in ( (select max(sum(hoursworked))
                                     from works
                                 group by empno),
                                  (select min(sum(hoursworked))
                                     from works
                                 group by empno));


  select empno "���",
         (select name 
            from employee 
           where empno = works.empno) "�̸�",
         sum(hoursworked) "�ð�"
    from works
group by empno
  having sum(hoursworked) in    ( (select max(sum(hoursworked))
                                     from works
                                 group by empno),
                                  (select min(sum(hoursworked))
                                     from works
                                 group by empno));
--case2)������
  select t2.empno, t1.name, sum(t2.hoursworked)
    from employee t1 , works t2
   where t1.empno = t2.empno 
group by t2.empno, t1.name
  having sum(t2.hoursworked) in ( select max(sum(hoursworked))
                                     from works
                                 group by empno )
union                                 
  select t2.empno, t1.name, sum(t2.hoursworked)
    from employee t1 , works t2
   where t1.empno = t2.empno 
group by t2.empno, t1.name
  having sum(t2.hoursworked) in ( select min(sum(hoursworked))
                                     from works
                                 group by empno );

--14. ����� ������ ������Ʈ�� ���� �����, ������Ʈ��, �����ð��� ���̴� �並 �ۼ��Ͻÿ�.
create or replace view vw_proj (name, projectname, hours)
as
    select t2.name, t3.projname, sum(t1.hoursworked)
      from works t1, employee t2, project t3
     where t1.empno  = t2.empno
       and t1.projno = t3.projno
  group by t2.name, t3.projname;     
  
select name "�̸�",projectname "������Ʈ��",hours "�����ð�"
  from vw_proj;
--15. EXISTS �����ڷ� �������� ���࡯ ������Ʈ�� �����ϴ� ����� �̸��� ���̽ÿ�.
--case1)
select t1.name "�̸�" 
  from employee t1
 where exists ( select *
                  from project t2, works t3
                 where t2.projno = t3.projno
                   and t3.empno  = t1.empno 
                   and t2.projname = '�����ͱ���' );
--case2)
select (select name 
          from employee 
         where empno = t3.empno) "�̸�"
  from project t2, works t3
 where t2.projno = t3.projno
   and t2.projname = '�����ͱ���'
   and exists ( select * 
                  from employee 
                 where empno = t3.empno);

--16. employee ���̺��� name,phoneno ���� ������� �ε����� �����Ͻÿ�. (��.�ε������� ix_employee2)
create index ix_employee2 on employee(name,phoneno);
select *
  from user_indexes
 where table_name = 'EMPLOYEE' 
   and index_name = 'IX_EMPLOYEE2';
--17. �μ����� �޿��� �μ���� �޿� ���� ���� ����� �̸��� ������ ���̽ÿ�.
select t3.deptname "�μ���", t1.name "�̸�", t1.salary "�޿�",
       ( select avg(salary)
           from employee 
          where deptno = t1.deptno ) "�μ���� �޿�"
  from employee t1, department t3
 where t1.deptno = t3.deptno 
   and t1.salary > (  select avg(salary)
                        from employee t2
                       where t2.deptno = t1.deptno );
--����                               
select t1.*, t1."�޿�" - t1."�μ���� �޿�" "����"
  from (
        select t3.deptname "�μ���", t1.name "�̸�", t1.salary "�޿�",
               ( select avg(salary)
                   from employee 
                  where deptno = t1.deptno ) "�μ���� �޿�"
          from employee t1, department t3
         where t1.deptno = t3.deptno 
           and t1.salary > (  select avg(salary)
                                from employee t2
                               where t2.deptno = t1.deptno )) t1;

--18. �μ��� �޿� ���� ��������� 2�� ������ ���̽ÿ�.
select t1.deptname "�μ���", t2.name "�̸�", t2.salary "�޿�"
  from department t1, employee t2
 where t1.deptno = t2.deptno
   and t2.salary in (select t1.salary
                      from (  select t3.empno, t3.salary
                                from employee t3
                               where t3.deptno = t1.deptno                 
                            order by t3.salary desc ) t1
                     where rownum <=2 );





