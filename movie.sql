drop table reservation;
drop table cinema;
drop table theater;
drop table customer;

--���� ���̺�
create table theater (
    theater_no      number(2),      --�����ȣ
    theater_name    varchar2(60),   --�����
    location        varchar2(30)
);
alter table theater add constraint theater_theater_no_pk primary key (theater_no);  

--�� ���̺�
create table customer (
    cust_no     number(2),          --����ȣ
    name        varchar2(12),       --����
    address     varchar2(90)        --�ּ�
);
alter table customer add constraint customer_cust_no_pk primary key(cust_no);

--�󿵰� ���̺�
create table cinema(
    theater_no      number(2),      --�����ȣ
    cinema_no       number(2),      --�󿵰���ȣ
    movie_title     varchar2(30),   --��ȭ����
    price           number(5),      --����
    seats           number(3)       --�¼���    
);
alter table cinema add constraint cinema_theater_no_pk primary key(theater_no,cinema_no);
alter table cinema add constraint cinema_theater_no_fk 
    foreign key (theater_no) references theater(theater_no);
alter table cinema add constraint cinema_price_ck check( price <= 20000 );  
alter table cinema add constraint cinema_cinema_no check( cinema_no between 1 and 10 );
    
--���� ���̺�
create table reservation(
    theater_no      number(2),      --�����ȣ
    cinema_no       number(2),      --�󿵰���ȣ
    cust_no         number(2),      --����ȣ
    seat_no         number(3),      --�¼���ȣ
    screening_date  date            --��¥(����)
);
alter table reservation add constraint reservation_theater_no_pk primary key(theater_no,cinema_no,cust_no);
alter table reservation add constraint reservation_theater_no_cinema_no_fk
    foreign key(theater_no,cinema_no) references cinema(theater_no,cinema_no);
alter table reservation add constraint reservation_cust_no_fk
    foreign key(cust_no) references customer(cust_no);    

--���� ���� ������
insert into theater values (1,'�Ե�','���');
insert into theater values (2,'�ް�','����');
insert into theater values (3,'����','���');

--�� ���� ������
insert into customer values (3,'ȫ�浿','����');
insert into customer values (4,'��ö��','���');
insert into customer values (9,'�ڿ���','����');

--�󿵰� ���� ������
insert into cinema values (1,1,'����� ��ȭ',15000,48);
insert into cinema values (3,1,'���� ��ȭ',7500,120);
insert into cinema values (3,2,'��մ� ��ȭ',8000,110);

--���� ���� ������
insert into reservation values (3,2,3,15,'20200901');
insert into reservation values (3,1,4,16,'20200901');
insert into reservation values (1,1,9,48,'20200901');

commit;




