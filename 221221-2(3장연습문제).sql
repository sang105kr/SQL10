select t1.*
  from book t1
 where t1.price > ( select avg(t2.price)
                      from book t2
                     where t2.publisher = t1.publisher ); 
                     
--���缭���� ���� �䱸�ϴ� ���� ������ ���� SQL ���� �ۼ��Ͻÿ�.
--(5) �������� ������ ������ ���ǻ� ��
select count(t3.publisher) "���ǻ� ��"
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid 
   and t1.bookid = t3.bookid
   and t2.name = '������';
   
select count(t3.publisher) "���ǻ� ��"
  from orders t1 inner join customer t2
                 on t1.custid = t2.custid
                 inner join book t3
                 on t1.bookid = t3.bookid
 where t2.name = '������';

select count(publisher) "���ǻ� ��"
  from book
 where bookid in ( select bookid
                     from orders
                    where custid in ( select custid
                                        from customer
                                       where name = '������'));
select count(publisher) "���ǻ� ��"
  from book
 where bookid in ( select bookid
                     from orders t1, customer t2
                    where t1.custid = t2.custid
                      and t2.name = '������');
                      
--(6) �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
select t3.bookname "�����̸�", 
       t3.price "����", 
       (t3.price - t1.saleprice) "������ �ǳ���������"
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid 
   and t1.bookid = t3.bookid
   and t2.name = '������';

--(7) �������� �������� ���� ������ �̸�
--1)������ minus
select bookname 
  from book
minus
select bookname
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid
   and t1.bookid = t3.bookid
   and t2.name = '������'; 

--2)not in
select bookname 
  from book
 where bookid not in (  select t1.bookid
                          from orders t1, customer t2
                         where t1.custid = t2.custid
                           and t2.name = '������' );
--3) not exists
select t1.bookname
  from book t1
 where not exists ( select t2.bookid
                      from orders t2, customer t3
                     where t2.custid = t3.custid
                       and t2.bookid = t1.bookid 
                       and t3.name = '������' );

--4) left outer join
select distinct t1.bookname
  from book t1, orders t2, customer t3
 where t1.bookid = t2.bookid(+)
   and t2.custid = t3.custid(+)
   and (t3.name <> '������' or t3.name is null);

select distinct t1.bookname
  from book t1 left outer join orders t2
               on t1.bookid = t2.bookid
               left outer join customer t3
               on t2.custid = t3.custid
 where (t3.name <> '������' or t3.name is null);
--���缭���� ��ڿ� �濵�ڰ� �䱸�ϴ� ���� ������ ���� SQL ���� �ۼ��Ͻÿ�.
--(8) �ֹ����� ���� ���� �̸�(�μ����� ���)
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
  




--(9) �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ�
--(10) ���� �̸��� ���� ���ž�
--(11) ���� �̸��� ���� ������ ���� ���
--(12) ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�
--(13) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�

                     