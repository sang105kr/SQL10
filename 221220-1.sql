--�а� ���̺�
create table department(
    code    varchar2(4) primary key,
    name    varchar2(15)
);

--�л� ���̺�
create table student(
    no      number(3) primary key, 
    name    varchar2(12),
    code    varchar2(4),
    foreign key (code) references department(code) 
);

drop table student;
-- �а� ������ �Է�
insert into department values('1001','��ǻ���а�');
insert into department values('2001','ü���а�');
select * from department;
commit;
-- �л� ������ �Է�
insert into student values(501,'������','1001');
insert into student values(401,'�迬��','2001');
insert into student values(402,'��̶�','2001');
insert into student values(502,'�߽ż�','1001');
select * from student;
commit;

insert into department values('3001','ö�а�');
insert into student values(601,'ȫ�浿','3001');
select * from department;
select * from student;
rollback;
commit;

delete from student
 where no = 601;
delete from department
 where code = '3001';
 commit;









