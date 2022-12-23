select * from emp;

  select 
    to_char(hiredate, 'YYYY'), count(*)
    from emp
group by to_char(hiredate, 'YYYY')
order by to_char(hiredate, 'YYYY');


select ename, lpad(' ',sal/100,'*')
  from emp
  order by sal desc;
  
select *
  from emp t1, emp t2
 where t1.mgr = t2.empno(+)
   and t1.sal > t2.sal;
   
select * from emp;   
select * 
  from emp 
 where name = 'breake';   
--1. EMP ���̺��� Blake�� ���� �μ��� �ִ� ��� ����� �̸��� �Ի����ڸ� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename, hiredate
  from emp
 where deptno in (  select deptno 
                      from emp
                     where ename = 'BLAKE' );
--2. EMP ���̺��� ��� �޿� �̻��� �޴� ��� �������� ���ؼ� ������ ��ȣ�� �̸��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. �� �޿��� ���� ������ ����Ͽ���.
    select empno, ename, sal
      from emp
     where sal >= ( select avg(sal)
                      from emp )
  order by sal desc;
  
--3. EMP ���̺��� �̸��� ��T���� �ִ� ����� �ٹ��ϴ� �μ����� �ٹ��ϴ� ��� �������� ���� ��� ��ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�. �� �����ȣ ������ ����Ͽ���.
select empno, ename, sal
  from emp
 where deptno in ( select deptno
                     from emp
                    where ename like '%T%' );
--4. EMP ���̺��� �μ� ��ġ�� Dallas�� ��� �������� ���� �̸�,����,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select * from dept;
select ename,job,sal
  from emp
 where deptno = ( select deptno
                    from dept
                   where loc = 'DALLAS' ); 
--5. EMP ���̺��� King���� �����ϴ� ��� ����� �̸��� �޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename,sal
  from emp
 where mgr in ( select empno 
                 from emp
                where ename = 'KING' );

--6. EMP ���̺��� SALES�μ� ����� �̸�,������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select * from dept;
select ename,job
  from emp
 where deptno in ( select deptno
                    from dept
                   where dname = 'SALES' );
--7. EMP ���̺��� ������ �μ� 30�� ���� ���޺��� ���� ����� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select ename, sal
  from emp
 where sal > ( select min(sal)
                 from emp 
                where deptno = 30 );
--8. EMP ���̺��� �μ� 10���� �μ� 30�� ����� ���� ������ �ð� �ִ� ����� �̸��� ������ ����ϴ� SELECT���� �ۼ��Ͻÿ�.

select ename,job
  from emp 
 where deptno = 10
   and job in ( select job
                  from emp 
                 where deptno = 30 );
                  
                