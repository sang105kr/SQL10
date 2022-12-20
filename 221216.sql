select * from book;
select bookname, publisher from book;

select bookname,publisher
  from book
 where price <> 10000;
 
select address, phone 
  from customer
 where name = '김연아'; 
 
select * 
  from customer;
  
select * 
  from book
 where price between 20000 and 30000;
 
 select * 
  from book
 where not(price >= 20000 and price <= 30000);

select * from customer;

select name
  from customer
 where phone is not null; 
 
-- 도서명이 축구로 시작하는 도서 
select *
  from book
 where bookname like '%축구%';  

-- 정렬
  select * 
    from book
order by bookname asc;

  select * 
    from book
order by price desc, publisher asc;


select * from book;

  select publisher, min(price)
    from book
group by publisher;

select * from orders;

select sum(saleprice) "총매출액", 
       avg(saleprice) "평균매출액", 
       max(saleprice) "최대판매액", 
       min(saleprice) "최소판매액"
  from orders;
  
  
select count(custid) "고객수"
  from customer;
  
select count(bookid) "2만원이상인 도서수"
  from book
 where price >= 20000; 
 
-- 출판사 개수 구하기 
select * from book;

select count(distinct publisher) 
  from book;
  
  
select * from customer;  

select count(*)
  from customer;

select count(custid)
  from customer;
  
select count(phone)
  from customer;  
  


select custid, count(*)
  from orders
 where saleprice >= 8000 
group by custid
having count(*) >= 2
order by custid;

  
  
  
  
  
  
  
  








 
 
  
  
 
 

