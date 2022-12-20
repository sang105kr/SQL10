--[�򰡹���] 
--1. ���� �̸�, �ּ�, ����ó�� ���̽ÿ�.
select name "�̸�", address "�ּ�", phone "����ó"
  from customer;
--2. ���ѹα��� �����ϴ� ���� ���̽ÿ�.
select name "�̸�", address "�ּ�"
  from customer
 where address like '%���ѹα�%'; 
--3. ����ó�� ���� ���� �̸��� ���̽ÿ�.
select name "�̸�", phone "����ó"
  from customer
 where phone is null; 
--4. �������� ����ϴ� ���ǻ��� �� ������ ���̽ÿ�.
select count(distinct publisher) "���ǻ� �Ѱ���"
  from book;
--5. ���� ���� ���������� �����ϴ� ������ ���̽ÿ�.
select bookname "������"
  from book
 where bookname like '%����%';
--6. �ֹ��Ǽ�, ����Ǹž�, �ִ��Ǹž�, �ּ��Ǹž�, �� �Ǹž��� ���̽ÿ�.
select count(orderid) "�ֹ��Ǽ�", 
       avg(saleprice) "����Ǹž�", 
       max(saleprice) "�ִ��Ǹž�", 
       min(saleprice) "�ּ��Ǹž�", 
       sum(saleprice) "�� �Ǹž�"
  from orders;
--7. ���ǻ纰 �����Ǽ��� ������������ ���̽ÿ�.
  select publisher "���ǻ�", count(bookid) "�����Ǽ�"
    from book
group by publisher
order by count(bookid) desc;
--8. ���ǻ纰 ���� �Ǽ�, �ְ���, ��������, ���������� ���� ���ǻ� �̸������� ���̽ÿ�.
  select publisher "���ǻ�", 
         count(bookid) "�����Ǽ�", 
         max(price) "�ְ���", 
         min(price) "��������", 
         sum(price) "���������� ��"
    from book
group by publisher
order by publisher;
--9. ���������� ���� ��� ������ ���� �ѵ����� �������̸� ���̽ÿ�.
select max(price) "���� ��� ���� ����", 
       min(price) "���� �� ��������",  
       max(price)-min(price) "����"
  from book;

--10. �� �� ���ŰǼ��� 2ȸ �̻��� ����ȣ, ���ŰǼ��� ���ŰǼ� ������ ���̽ÿ�.
  select custid "����ȣ", count(orderid) "���ŰǼ�"
    from orders
group by custid 
having count(orderid) >= 2
order by  count(orderid);

--11. 2020�� 7�� 4��~7�� 7�� ���̿� �ֹ� ���� ������ ������ ������ �ֹ���ȣ�� ���̽ÿ�.
select orderid "������ �ֹ���ȣ"
  from orders
 where not (orderdate between '20200704' and '20200707');
select orderid "������ �ֹ���ȣ"
  from orders
 where not (orderdate >= '20200704' and orderdate <= '20200707');
select orderid "������ �ֹ���ȣ"
  from orders
 where orderdate < '20200704' or orderdate > '20200707';
--12. �ֹ����ں� ������� ����� ������������ ���̽ÿ�.
  select orderdate "�ֹ�����", sum(saleprice) "�����"
    from orders
group by orderdate
order by sum(saleprice) desc;

--13. 2020�� 7��2�� ���Ŀ� �ֹ��Ϻ� ������� 20000���� �ʰ��ϴ� �ֹ����ڸ� �ֱ� ���ڼ� ���̽ÿ�.
  select orderdate "�ֹ�����", sum(saleprice) "�����"
    from orders
   where orderdate > '20200702'   
group by orderdate
having sum(saleprice) > 20000
order by orderdate desc;
--14. ���ǻ纰 �����Ǽ��� 2�� �̻��� ���ǻ縦 ���̽ÿ�.
    select publisher "���ǻ�", count(bookid) "�����Ǽ�"
      from book
  group by publisher
  having count(bookid) >= 2;

--15. ���ο� ������ �Ʒ� �԰� �Ǿ���. �߰��� ����� ���̽ÿ�.
--    ���� : �����ͺ��̽�, ���ǻ� : �Ѻ�, ���� : 30000
insert into book values(11,'�����ͺ��̽�','�Ѻ�',30000);
commit;
select * from book;
--16. ���ǻ� �����ѹ̵��� ���������ǻ确�� �̸��� �ٲ����. ����� ����� ���̽ÿ�.
update book
   set publisher = '�������ǻ�'
 where publisher = '���ѹ̵��';  
commit; 
select * from book;
--17. �½����� ���ǻ� ������ ������ 10% �λ��Ͽ���. ����� ����� ���̽ÿ�.
update book
   set price = price * 1.1   -- price + price * 0.1
 where publisher = '�½�����';   
commit;
select * from book;
--18. �߽ż� ���� �ּҰ� �����ѹα� ��ꡱ���� ����Ǿ���. ����� ����� ���̽ÿ�.
update customer
   set address = '���ѹα� ���'
 where name = '�߽ż�';
commit; 
select * from customer;
--19. ��ȭ��ȣ�� ���� ���� �����ϰ� �ݿ��� ����� ���̽ÿ�.
delete from customer
      where phone is null;
commit;
select * from customer;
--20. ���������� ���� �����ؾ� �Ѵ�. ������ �� �� ��� ������ �ۼ��Ͻÿ�.
delete from customer where name = '������';
--�ڽ� ���̺��� �����̺� ������ ���� Ʃ��(��)�� �����ϰ� �־� ���� ���Ἲ �������ǿ� ����ȴ�.

