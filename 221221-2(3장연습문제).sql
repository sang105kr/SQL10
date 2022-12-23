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
select sum(saleprice) "�Ѿ�", 
       avg(saleprice) "���", 
       sum(saleprice)/count(saleprice) "���2"
  from orders;
--(10) ���� �̸��� ���� ���ž�
  select t2.name "����", sum(t1.saleprice) "���ž�"
    from orders t1, customer t2
   where t1.custid = t2.custid
group by t1.custid, t2.name;

--(11) ���� �̸��� ���� ������ ���� ���
    select t2.name "�̸�", t3.bookname "������"
      from orders t1, customer t2, book t3
     where t1.custid = t2.custid
       and t1.bookid = t3.bookid;
--(12) ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�
    select t3.orderid "�ֹ���ȣ"
      from orders t3, book t4
     where t3.bookid = t4.bookid
       and t4.price - t3.saleprice = ( select max(t2.price - t1.saleprice)
                                         from orders t1, book t2
                                        where t1.bookid = t2.bookid );
--(13) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
   select t2.name "����"
     from orders t1, customer t2
    where t1.custid = t2.custid
 group by t2.custid, t2.name  
   having avg(t1.saleprice) > ( select avg(saleprice)
                                   from orders );
     
--3 ���缭������ ������ ��ȭ�� ������ ���� SQL ���� �ۼ��Ͻÿ�.
--  (1) �������� ������ ������ ���ǻ�� ���� ���ǻ翡�� ������ ������ ���� �̸�   
select t2.name "����", t3.publisher "���ǻ�", t3.bookname "������" 
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid
   and t1.bookid = t3.bookid
   and t3.publisher in ( select distinct t3.publisher
                           from orders t1, customer t2, book t3
                          where t1.custid = t2.custid
                            and t1.bookid = t3.bookid
                            and t2.name = '������' )
   and t2.name != '������';
--  (2) �� �� �̻��� ���� �ٸ� ���ǻ翡�� ������ ������ ���� �̸�
--case1)
select name
  from customer
 where custid in ( select t1.custid
                     from orders t1, book t2
                    where t1.bookid = t2.bookid 
                 group by t1.custid
                 having count(distinct t2.publisher) >= 2 );
--case2)
select t3.name
  from customer t3
 where ( select count(distinct t2.publisher)
           from orders t1, book t2
          where t1.bookid = t2.bookid 
            and t1.custid = t3.custid ) >= 2 ; 
 
--  (3) ��ü ���� 30% �̻��� ������ ���� 
select bookname
  from book
 where bookid in   (select bookid
                      from orders 
                  group by bookid
                    having count(custid) > (select count(custid) * 0.3
                                              from customer));
  
select t1.bookname
  from book t1
 where (select count(bookid)
          from orders
         where bookid = t1.bookid ) > (select count(custid) * 0.3
                                         from customer); 

   
   
                     