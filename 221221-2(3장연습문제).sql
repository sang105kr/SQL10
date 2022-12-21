select t1.*
  from book t1
 where t1.price > ( select avg(t2.price)
                      from book t2
                     where t2.publisher = t1.publisher ); 
                     
--마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--(5) 박지성이 구매한 도서의 출판사 수
select count(t3.publisher) "출판사 수"
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid 
   and t1.bookid = t3.bookid
   and t2.name = '박지성';
   
select count(t3.publisher) "출판사 수"
  from orders t1 inner join customer t2
                 on t1.custid = t2.custid
                 inner join book t3
                 on t1.bookid = t3.bookid
 where t2.name = '박지성';

select count(publisher) "출판사 수"
  from book
 where bookid in ( select bookid
                     from orders
                    where custid in ( select custid
                                        from customer
                                       where name = '박지성'));
select count(publisher) "출판사 수"
  from book
 where bookid in ( select bookid
                     from orders t1, customer t2
                    where t1.custid = t2.custid
                      and t2.name = '박지성');
                      
--(6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select t3.bookname "도서이름", 
       t3.price "가격", 
       (t3.price - t1.saleprice) "정가와 판내가격차이"
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid 
   and t1.bookid = t3.bookid
   and t2.name = '박지성';

--(7) 박지성이 구매하지 않은 도서의 이름
--1)차집합 minus
select bookname 
  from book
minus
select bookname
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid
   and t1.bookid = t3.bookid
   and t2.name = '박지성'; 

--2)not in
select bookname 
  from book
 where bookid not in (  select t1.bookid
                          from orders t1, customer t2
                         where t1.custid = t2.custid
                           and t2.name = '박지성' );
--3) not exists
select t1.bookname
  from book t1
 where not exists ( select t2.bookid
                      from orders t2, customer t3
                     where t2.custid = t3.custid
                       and t2.bookid = t1.bookid 
                       and t3.name = '박지성' );

--4) left outer join
select distinct t1.bookname
  from book t1, orders t2, customer t3
 where t1.bookid = t2.bookid(+)
   and t2.custid = t3.custid(+)
   and (t3.name <> '박지성' or t3.name is null);

select distinct t1.bookname
  from book t1 left outer join orders t2
               on t1.bookid = t2.bookid
               left outer join customer t3
               on t2.custid = t3.custid
 where (t3.name <> '박지성' or t3.name is null);
--마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
--(8) 주문하지 않은 고객의 이름(부속질의 사용)
--1) not exists
select t1.name
  from  customer t1
 where not exists ( select *
                      from orders t2
                     where t2.custid = t1.custid ) ;
--2) not in
select t1.name
  from customer t1
 where t1.custid not in ( select t2.custid
                            from orders t2 );
--3) left outer join
select t1.name
  from customer t1 , orders t2
 where t1.custid = t2.custid(+)
   and t2.orderid is null;
   
select t1.name
  from customer t1 left outer join orders t2
                   on t1.custid = t2.custid
 where t2.orderid is null; 
  




--(9) 주문 금액의 총액과 주문의 평균 금액
--(10) 고객의 이름과 고객별 구매액
--(11) 고객의 이름과 고객이 구매한 도서 목록
--(12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
--(13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름

                     