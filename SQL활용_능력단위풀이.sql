--제약조건 삭제
alter table department drop constraint department_manager_fk;
alter table employee   drop constraint employee_deptno_fk;
alter table employee   drop constraint employee_phoneno_uk;
alter table project    drop constraint project_deptno_fk;
alter table works      drop constraint works_projno_fk;
alter table works      drop constraint works_empno_fk;

--테이블 삭제
drop table department;
drop table employee;
drop table project;
drop table works;

--테이블 생성
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

--제약조건
--1)기본키 primary key
alter table department  add constraint department_deptno_pk  primary key(deptno);
alter table employee    add constraint employee_empno_pk     primary key(empno);
alter table project     add constraint project_projno_pk     primary key(projno);
alter table works       add constraint works_projno_empno_pk primary key(projno,empno); 

--2)필수속성 not null
alter table employee    modify name     constraint employee_name_nn      not null;
--alter table employee add constraint employee_name_ck
--                     check(name is not null);   
alter table department  modify deptno   constraint department_deptno_nn  not null;
alter table project     modify projname constraint employee_projname_nn  not null;

--3)체크조건 check
alter table employee    add constraint  employee_sex_ck         check( sex in('남','여') );
alter table works       add constraint  works_hoursworked_ck    check( hoursworked > 0 );    

--4)외래키    foreign key
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

--6)중복 불가 unique (null값은 1개만 유효)
alter table employee    add constraint  employee_phoneno_uk unique(phoneno);

--샘플 데이터 생성
insert into department (deptno, deptname) values (10, '전산팀');
insert into department (deptno, deptname) values (20, '회계팀');
insert into department (deptno, deptname) values (30,'영업팀');
insert into department (deptno, deptname) values (40, '총무팀');
insert into department (deptno, deptname) values (50,'인사팀');

insert into project values (101, '빅데이터구축', 10);
insert into project values (102, 'IFRS', 20);
insert into project values (103, '마케팅', 30);

insert into employee values (1001,'홍길동1','010-111-1001','울산1','남','팀장',7000000,10);
insert into employee values (1002,'홍길동2','010-111-1002','울산2','남','팀원1',4000000,10);
insert into employee values (1003,'홍길동3','010-111-1003','울산3','남','팀원2',3000000,10);
insert into employee values (1004,'홍길동4','010-111-1004','부산1','여','팀장',6000000,20);
insert into employee values (1005,'홍길동5','010-111-1005','부산2','남','팀원1',3500000,20);
insert into employee values (1006,'홍길동6','010-111-1006','부산3','남','팀원2',2500000,20);
insert into employee values (1007,'홍길동7','010-111-1007','서울1','남','팀장',5000000,30);
insert into employee values (1008,'홍길동8','010-111-1008','서울2','남','팀원1',4000000,30);
insert into employee values (1009,'홍길동9','010-111-1009','서울3','남','팀원2',3000000,30);
insert into employee values (1010,'홍길동10',null,'서울4','남','팀원3',2000000,30);
insert into employee values (1011,'홍길동11','010-111-1011','대구1','여','팀장',5500000,40);
insert into employee values (1012,'홍길동12','010-111-1012','대구2','남','팀원1',2000000,40);
insert into employee values (1013,'홍길동13','010-111-1013','제주1','남','팀장',6500000,50);
insert into employee values (1014,'홍길동14','010-111-1014','제주2','남','팀원1',3500000,50);

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

--부서 데이터 insert-> 사원 데이터 insert-> update 부서 테이블
update department set manager = 1001 where deptno = 10;
update department set manager = 1004 where deptno = 20;
update department set manager = 1007 where deptno = 30;
update department set manager = 1011 where deptno = 40;
update department set manager = 1013 where deptno = 50;
commit;

--1. 테이블을 생성하는 create문을 작성하고 구조를 보이시오. 제약조건 미반영시 2점 감점.
--구조보기
desc department;
desc employee;
desc project;
desc works;
--제약조건보기
select *
  from user_constraints
 where table_name in ('DEPARTMENT','EMPLOYEE','PROJECT','WORKS')
   AND constraint_type = 'P'; 
   
select * 
  from user_indexes;
  
--2) 데이터를 삽입하는 insert문을 작성하고 저장된 결과를 보이시오.  
select * from department;
select * from employee;
select * from project;
select * from works;

--3. 여자 사원의 이름, 연락처, 주소를 보이시오. 
select name "이름" ,phoneno "연락처" ,address "주소"
  from employee
 where sex = '여';


--4. 팀장의 급여를 10%인상해 보이시오. (단, department테이블을 활용하시오.)
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
--5. 사원 중 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
    select substr(t1.name,1,1) "성", count(*) "인원수"
      from employee t1
  group by substr(t1.name,1,1);   
  
--6. ‘영업팀’ 부서에서 일하는 사원의 이름, 연락처, 주소를 보이시오. (단 연락처 없으면 ‘연락처 없음’ , 연락처 끝4자리 중 앞2자리는 별표 * 로 표시하시오. 예) 010-111-**78 )
select t2.name "이름", 
       nvl2(phoneno,substr(phoneno,1,8) || '**' || substr(phoneno,11,2),'연락처없음') "연락처", 
       t2.address "주소"
  from department t1, employee t2
 where t1.deptno = t2.deptno
   and t1.deptname = '영업팀'; 

--7. ‘홍길동7’ 팀장(manager) 부서에서 일하는 팀원의 수를 보이시오. 
select count(*) "팀원 수"
  from employee
 where deptno = ( select t2.deptno
                    from department t1, employee t2
                   where t1.deptno = t2.deptno
                     and t2.name = '홍길동7' )
   and name <> '홍길동7'; 
--8. 프로젝트에 참여하지 않은 사원의 이름을 보이시오.
--1) left outer join
  select t1.name
    from employee t1, works t2
   where t1.empno = t2.empno(+)
     and t2.projno is null; 
--2) 상관쿼리
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
--4) 차집합
select name
  from employee
 where empno in (  select empno
                     from employee
                   minus
                    select distinct empno
                      from works );
--9. 급여 상위 TOP 3를 순위와 함께 보이시오.
select rownum, t1.*
  from (  select *
            from employee
        order by salary desc ) t1
 where rownum <=3;
--10. 사원들이 일한 시간 수를 부서별, 사원 이름별 오름차순으로 보이시오. 
    select t1.deptname "부서명", t2.name "이름", nvl(sum(t3.hoursworked),0) "일한 시간"
      from department t1, employee t2, works t3
     where t2.deptno = t1.deptno(+)
       and t2.empno  = t3.empno(+)
  group by t1.deptname, t2.name
  order by t1.deptname, t2.name;
--11. 2명 이상의 사원이 참여한 프로젝트의 번호, 프로젝트명, 사원의 수를 보이시오. 
  select t2.projno "프로젝트 번호", 
         t2.projname "프로젝트명", 
         count(*) "사원수"
    from works t1, project t2
   where t1.projno = t2.projno 
group by t2.projno, t2.projname
  having count(*) >= 2;
  
--12. 3명 이상의 사원이 있는 부서의 사원 이름을 보이시오. 
select t3.deptname "부서명", t4.name "이름"
  from department t3, employee t4
 where t3.deptno = t4.deptno
   and t3.deptno in  ( select t1.deptno
                         from department t1, employee t2
                        where t1.deptno = t2.deptno 
                     group by t1.deptno
                       having count(*) >= 3 );
--13. 프로젝트에 참여시간이 가장 많은 사원과 적은 사원의 이름을 보이시오.
  select t2.empno "사번", t1.name "이름", sum(t2.hoursworked) "시간"
    from employee t1 , works t2
   where t1.empno = t2.empno 
group by t2.empno, t1.name
  having sum(t2.hoursworked) in ( (select max(sum(hoursworked))
                                     from works
                                 group by empno),
                                  (select min(sum(hoursworked))
                                     from works
                                 group by empno));


  select empno "사번",
         (select name 
            from employee 
           where empno = works.empno) "이름",
         sum(hoursworked) "시간"
    from works
group by empno
  having sum(hoursworked) in    ( (select max(sum(hoursworked))
                                     from works
                                 group by empno),
                                  (select min(sum(hoursworked))
                                     from works
                                 group by empno));
--case2)합집합
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

--14. 사원이 참여한 프로젝트에 대해 사원명, 프로젝트명, 참여시간을 보이는 뷰를 작성하시오.
create or replace view vw_proj (name, projectname, hours)
as
    select t2.name, t3.projname, sum(t1.hoursworked)
      from works t1, employee t2, project t3
     where t1.empno  = t2.empno
       and t1.projno = t3.projno
  group by t2.name, t3.projname;     
  
select name "이름",projectname "프로젝트명",hours "참여시간"
  from vw_proj;
--15. EXISTS 연산자로 ‘빅데이터 구축’ 프로젝트에 참여하는 사원의 이름을 보이시오.
--case1)
select t1.name "이름" 
  from employee t1
 where exists ( select *
                  from project t2, works t3
                 where t2.projno = t3.projno
                   and t3.empno  = t1.empno 
                   and t2.projname = '빅데이터구축' );
--case2)
select (select name 
          from employee 
         where empno = t3.empno) "이름"
  from project t2, works t3
 where t2.projno = t3.projno
   and t2.projname = '빅데이터구축'
   and exists ( select * 
                  from employee 
                 where empno = t3.empno);

--16. employee 테이블의 name,phoneno 열을 대상으로 인덱스를 생성하시오. (단.인덱스명은 ix_employee2)
create index ix_employee2 on employee(name,phoneno);
select *
  from user_indexes
 where table_name = 'EMPLOYEE' 
   and index_name = 'IX_EMPLOYEE2';
--17. 부서별로 급여가 부서평균 급여 보다 높은 사원의 이름과 월급을 보이시오.
select t3.deptname "부서명", t1.name "이름", t1.salary "급여",
       ( select avg(salary)
           from employee 
          where deptno = t1.deptno ) "부서평균 급여"
  from employee t1, department t3
 where t1.deptno = t3.deptno 
   and t1.salary > (  select avg(salary)
                        from employee t2
                       where t2.deptno = t1.deptno );
--참고                               
select t1.*, t1."급여" - t1."부서평균 급여" "차이"
  from (
        select t3.deptname "부서명", t1.name "이름", t1.salary "급여",
               ( select avg(salary)
                   from employee 
                  where deptno = t1.deptno ) "부서평균 급여"
          from employee t1, department t3
         where t1.deptno = t3.deptno 
           and t1.salary > (  select avg(salary)
                                from employee t2
                               where t2.deptno = t1.deptno )) t1;

--18. 부서별 급여 높은 사원순으로 2위 까지만 보이시오.
select t1.deptname "부서명", t2.name "이름", t2.salary "급여"
  from department t1, employee t2
 where t1.deptno = t2.deptno
   and t2.salary in (select t1.salary
                      from (  select t3.empno, t3.salary
                                from employee t3
                               where t3.deptno = t1.deptno                 
                            order by t3.salary desc ) t1
                     where rownum <=2 );





