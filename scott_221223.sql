select * from emp;

select t4.ename
  from emp t3, emp t4
 where t3.mgr = t4.empno
   and t3.empno = ( select t2.empno
                      from emp t1, emp t2
                     where t1.mgr = t2.empno
                       and t1.ename = 'ALLEN'); 
                       
select * from emp;                       
--EMP ���̺��� ����� �޿��� ����� �޿� �縸ŭ ��*���� ����ϴ� SELECT ������ �ۼ��Ͽ���. �� ��*���� 100�� �ǹ��Ѵ�.
select ename, trim(lpad(' ',sal/100+1,'*')), length(lpad(' ',sal/100,'*'))
  from emp;

select ename, lpad('*',sal/100,'*'), length(lpad(' ',sal/100,'*'))
  from emp;
  
select max(length(ename)) from emp;
  
select rpad(ename, 10 ,' ') || lpad('*',sal/100,'*') "Employee and their salary"
  from emp;  
  
select rpad(ename,10,' ') || ' ' || lpad(' ',(sal/100)+1,'*')
from emp;  
  
select  ename "employee",Trim(RPAD(' ', sal/100+1, '*')) "and their salary"
  from  emp;  
  
select ename|| ' ' || lpad('*',trunc(sal/100),'*') "Employee and their salary"
  from emp;  
  
  
  
  
  
SELECT empno,ename,job,hiredate,sal,deptno
  FROM emp
 WHERE deptno != 30 AND sal > all (SELECT sal
                                     FROM emp
                                    WHERE deptno = 30);
SELECT empno,ename,job,hiredate,sal,deptno
  FROM emp
 WHERE deptno != 30 AND sal >  (SELECT max(sal)
                                  FROM emp
                                 WHERE deptno = 30);  
                                 
                                 
--sql ���ǹ� 
--case 1) decode()
    SELECT empno,ename,job,sal,
           DECODE(job,'ANALYST', sal*1.1,
                      'CLERK',   sal*1.15,
                      'MANAGER', sal*1.2, sal) d_sal
      FROM emp
  ORDER BY sal DESC;
    
--case 2) case when ~ then end   
    SELECT empno,ename,job,sal,
           case when job = 'ANALYST' then sal*1.1
                when job = 'CLERK'   then sal*1.15
                when job = 'MANAGER' then sal*1.2
                                     else sal
           end  d_sal
      FROM emp
  ORDER BY sal DESC;
  
--case 3) case ~ when ~ then end   
    SELECT empno,ename,job,sal,
           case job when 'ANALYST' then sal*1.1
                    when 'CLERK'   then sal*1.15
                    when 'MANAGER' then sal*1.2
                                     else sal
           end  d_sal
      FROM emp
  ORDER BY sal DESC;  
  
--13. EMP ���̺��� �μ����� ������ ��� ���޺��� ���� ����� �μ���ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select *  from emp;
select t1.deptno "�μ���ȣ", t1.ename "�̸�", t1.sal "�޿�"
  from emp t1
 where t1.sal > ( select avg(sal)
                    from emp
                   where deptno = t1.deptno );
                 
--14. EMP ���̺��� �������� ������ ��� ���޺��� ���� ����� �μ���ȣ,�̸�,�޿��� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select t1.deptno "�μ���ȣ", t1.ename "�̸�", t1.sal "�޿�"
  from emp t1
 where t1.sal < ( select avg(sal)
                    from emp
                   where job = t1.job );
--15. EMP ���̺��� ��� �Ѹ� �̻����κ��� ���� ���� �� �ִ� ����� ����,�̸�,�����ȣ,�μ���ȣ�� ����ϴ� SELECT���� �ۼ��Ͻÿ�.
select job "����",ename "�̸�", empno "���", deptno "�μ���ȣ"
  from emp
 where empno in ( select distinct mgr
                    from emp
                   where mgr is not null );
select * from dept;
--16. EMP ���̺��� ���� ����� �����ȣ,�̸�,����,�μ���ȣ�� ����ϴ� SELECT���� �ۼ��Ͻÿ�
select job "����",ename "�̸�", empno "���", deptno "�μ���ȣ"
  from emp
 where empno in ( select empno  
                    from emp
                  minus  
                  select distinct mgr
                    from emp
                   where mgr is not null );

  
  
  
  