drop table reservation;
drop table cinema;
drop table theater;
drop table customer;

--극장 테이블
create table theater (
    theater_no      number(2),      --극장번호
    theater_name    varchar2(60),   --극장명
    location        varchar2(30)
);
alter table theater add constraint theater_theater_no_pk primary key (theater_no);  

--고객 테이블
create table customer (
    cust_no     number(2),          --고객번호
    name        varchar2(12),       --고객명
    address     varchar2(90)        --주소
);
alter table customer add constraint customer_cust_no_pk primary key(cust_no);

--상영관 테이블
create table cinema(
    theater_no      number(2),      --극장번호
    cinema_no       number(2),      --상영관번호
    movie_title     varchar2(30),   --영화제목
    price           number(5),      --가격
    seats           number(3)       --좌석수    
);
alter table cinema add constraint cinema_theater_no_pk primary key(theater_no,cinema_no);
alter table cinema add constraint cinema_theater_no_fk 
    foreign key (theater_no) references theater(theater_no);
alter table cinema add constraint cinema_price_ck check( price <= 20000 );  
alter table cinema add constraint cinema_cinema_no check( cinema_no between 1 and 10 );
    
--예약 테이블
create table reservation(
    theater_no      number(2),      --극장번호
    cinema_no       number(2),      --상영관번호
    cust_no         number(2),      --고객번호
    seat_no         number(3),      --좌석번호
    screening_date  date            --날짜(상영일)
);
alter table reservation add constraint reservation_theater_no_pk primary key(theater_no,cinema_no,cust_no);
alter table reservation add constraint reservation_theater_no_cinema_no_fk
    foreign key(theater_no,cinema_no) references cinema(theater_no,cinema_no);
alter table reservation add constraint reservation_cust_no_fk
    foreign key(cust_no) references customer(cust_no);    

--극장 샘플 데이터
insert into theater values (1,'롯데','잠실');
insert into theater values (2,'메가','강남');
insert into theater values (3,'대한','잠실');

--고객 샘플 데이터
insert into customer values (3,'홍길동','강남');
insert into customer values (4,'김철수','잠실');
insert into customer values (9,'박영희','강남');

--상영관 샘플 데이터
insert into cinema values (1,1,'어려운 영화',15000,48);
insert into cinema values (3,1,'멋진 영화',7500,120);
insert into cinema values (3,2,'재밌는 영화',8000,110);

--예약 샘플 데이터
insert into reservation values (3,2,3,15,'20200901');
insert into reservation values (3,1,4,16,'20200901');
insert into reservation values (1,1,9,48,'20200901');

commit;




