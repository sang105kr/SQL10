--학과 테이블
create table department(
    code    varchar2(4) primary key,
    name    varchar2(15)
);

--학생 테이블
create table student(
    no      number(3) primary key, 
    name    varchar2(12),
    code    varchar2(4),
    foreign key (code) references department(code) 
);

drop table student;
-- 학과 데이터 입력
insert into department values('1001','컴퓨터학과');
insert into department values('2001','체육학과');
select * from department;
commit;
-- 학생 데이터 입력
insert into student values(501,'박지성','1001');
insert into student values(401,'김연아','2001');
insert into student values(402,'장미란','2001');
insert into student values(502,'추신수','1001');
select * from student;
commit;

insert into department values('3001','철학과');
insert into student values(601,'홍길동','3001');
select * from department;
select * from student;
rollback;
commit;

delete from student
 where no = 601;
delete from department
 where code = '3001';
 commit;









