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
--1. EMP 테이블에서 Blake와 같은 부서에 있는 모든 사원의 이름과 입사일자를 출력하는 SELECT문을 작성하시오.
select ename, hiredate
  from emp
 where deptno in (  select deptno 
                      from emp
                     where ename = 'BLAKE' );
--2. EMP 테이블에서 평균 급여 이상을 받는 모든 종업원에 대해서 종업원 번호와 이름을 출력하는 SELECT문을 작성하시오. 단 급여가 많은 순으로 출력하여라.
    select empno, ename, sal
      from emp
     where sal >= ( select avg(sal)
                      from emp )
  order by sal desc;
  
--3. EMP 테이블에서 이름에 “T”가 있는 사원이 근무하는 부서에서 근무하는 모든 종업원에 대해 사원 번호,이름,급여를 출력하는 SELECT문을 작성하시오. 단 사원번호 순으로 출력하여라.
select empno, ename, sal
  from emp
 where deptno in ( select deptno
                     from emp
                    where ename like '%T%' );
--4. EMP 테이블에서 부서 위치가 Dallas인 모든 종업원에 대해 이름,업무,급여를 출력하는 SELECT문을 작성하시오.
select * from dept;
select ename,job,sal
  from emp
 where deptno = ( select deptno
                    from dept
                   where loc = 'DALLAS' ); 
--5. EMP 테이블에서 King에게 보고하는 모든 사원의 이름과 급여를 출력하는 SELECT문을 작성하시오.
select ename,sal
  from emp
 where mgr in ( select empno 
                 from emp
                where ename = 'KING' );

--6. EMP 테이블에서 SALES부서 사원의 이름,업무를 출력하는 SELECT문을 작성하시오.
select * from dept;
select ename,job
  from emp
 where deptno in ( select deptno
                    from dept
                   where dname = 'SALES' );
--7. EMP 테이블에서 월급이 부서 30의 최저 월급보다 높은 사원을 출력하는 SELECT문을 작성하시오.
select ename, sal
  from emp
 where sal > ( select min(sal)
                 from emp 
                where deptno = 30 );
--8. EMP 테이블에서 부서 10에서 부서 30의 사원과 같은 업무를 맡고 있는 사원의 이름과 업무를 출력하는 SELECT문을 작성하시오.

select ename,job
  from emp 
 where deptno = 10
   and job in ( select job
                  from emp 
                 where deptno = 30 );
                  
                