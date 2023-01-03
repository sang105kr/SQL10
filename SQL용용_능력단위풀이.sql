--1.
select name,address,phone
  from customer
 where address like '%���ѹα�%'; 

set serveroutput on;
exec test_1;

create or replace procedure test_1
--(
    --�Ű�����
--)
as
    --��������
    l_customer_rec customer%rowtype;
    type customer_rec_t is record(
        name    customer.name%type,
        address customer.address%type,
        phone   customer.phone%type
    );
    type customer_table_t is table of customer_rec_t
        index by binary_integer;

    l_customer_t    customer_table_t;

begin
    --���๮
    select name,address,phone
      bulk collect into l_customer_t
      from customer
     where address like '%���ѹα�%'; 

     dbms_output.put_line(
        rpad('�̸�',20,' ') || 
        rpad('�ּ�',40,' ') || 
        rpad('����ó',14,' '));
     for i in 1..l_customer_t.count loop
         dbms_output.put_line(
            rpad(l_customer_t(i).name,20,' ') || 
            rpad(l_customer_t(i).address,40,' ') || 
            rpad(l_customer_t(i).phone,14,' '));
     end loop;

    exception 
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
end;

CREATE OR REPLACE PROCEDURE TEST_1_2 
AS 
    cursor c1 is ( select name,address,phone
                     from customer
                    where address like '%���ѹα�%' );    
    type customer_rec_t is record(
        name    customer.name%type,
        address customer.address%type,
        phone   customer.phone%type
    );                 
   l_customer_rec    customer_rec_t;             
                    
BEGIN
    open c1;
     dbms_output.put_line(
        rpad('�̸�',20,' ') || 
        rpad('�ּ�',40,' ') || 
        rpad('����ó',14,' '));    
    loop
        fetch c1 into l_customer_rec;
        exit when c1%notfound;
         dbms_output.put_line(
            rpad(l_customer_rec.name,20,' ') || 
            rpad(l_customer_rec.address,40,' ') || 
            rpad(l_customer_rec.phone,14,' '));        
    end loop;
    close c1;
    exception 
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
END TEST_1_2;

CREATE OR REPLACE PROCEDURE TEST_1_3 
AS 
    cursor c1 is ( select name,address,phone
                     from customer
                    where address like '%���ѹα�%' );    
    type customer_rec_t is record(
        name    customer.name%type,
        address customer.address%type,
        phone   customer.phone%type
    );                 
   l_customer_rec    customer_rec_t;             
                    
BEGIN
    
     dbms_output.put_line(
        rpad('�̸�',20,' ') || 
        rpad('�ּ�',40,' ') || 
        rpad('����ó',14,' '));    
    for  l_customer_rec in c1  
    loop
         dbms_output.put_line(
            rpad(l_customer_rec.name,20,' ') || 
            rpad(l_customer_rec.address,40,' ') || 
            rpad(l_customer_rec.phone,14,' '));        
    end loop;
    
    exception 
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
END TEST_1_3;

CREATE OR REPLACE PROCEDURE TEST_1_4 
AS   
   type customer_rec_t is record(
       name    customer.name%type,
       address customer.address%type,
       phone   customer.phone%type
   );                 
   l_customer_rec    customer_rec_t;             
                    
BEGIN
    
     dbms_output.put_line(
        rpad('�̸�',20,' ') || 
        rpad('�ּ�',40,' ') || 
        rpad('����ó',14,' '));    
    for  l_customer_rec in ( select name,address,phone
                               from customer
                              where address like '%���ѹα�%' )  
    loop
         dbms_output.put_line(
            rpad(l_customer_rec.name,20,' ') || 
            rpad(l_customer_rec.address,40,' ') || 
            rpad(l_customer_rec.phone,14,' '));        
    end loop;
    
    exception 
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
END TEST_1_4;
--2.
select * from book;
--���� ���� ����üũ
select count(*)
  from book
 where bookname = '�����ͺ��̽�'
   and publisher = '�Ѻ�';  
   
--���ϵ��� ������   
insert into book values(20,'�����ͺ��̽�','�Ѻ�',30000);

--���ϵ��� ������
update book
   set price = 40000
 where bookname = '�����ͺ��̽�'
   and publisher = '�Ѻ�';
   
   
CREATE OR REPLACE PROCEDURE TEST_2(
    p_bookid    book.bookid%type,
    p_bookname  book.bookname%type,
    p_publisher book.publisher%type,
    p_price     book.price%type
)
AS 
    l_cnt   number;    
BEGIN
    --���� ���� ����üũ
    select count(*) into l_cnt
      from book
     where bookname = p_bookname
       and publisher = p_publisher;  
    
    if l_cnt = 0 then
         --���ϵ��� ������   
        insert into book values(p_bookid,p_bookname,p_publisher,p_price);   
    else
        --���ϵ��� ������
        update book
           set price = p_price
         where bookname = p_bookname
           and publisher = p_publisher;    
    end if;

    exception 
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
END TEST_2;

select * from book;   
delete from book where bookid=20;   
commit;
rollback;   

exec test_2(20,'�����ͺ��̽�','�Ѻ�',30000);
exec test_2(20,'�����ͺ��̽�','�Ѻ�',40000);

--3
    select ( select name 
               from customer 
              where custid = t1.custid) "name",
           sum(t2.saleprice) "sum"
      from customer t1, orders t2
     where t1.custid = t2.custid(+) 
  group by t1.custid
  having ( select name 
               from customer 
              where custid = t1.custid) = '������' ;


    select t1.name,
           sum(t2.saleprice) 
      from customer t1, orders t2
     where t1.custid = t2.custid 
  group by t1.name
  having t1.name = '������' ;


    select
           sum(t2.saleprice) "sum"
      from customer t1, orders t2
     where t1.custid = t2.custid 
  group by t1.custid
  having ( select name 
               from customer 
              where custid = t1.custid) = '������' ;

CREATE OR REPLACE FUNCTION GRADE(
    p_name      customer.name%type
)
RETURN VARCHAR2 
AS 
   l_sum   number; 
   l_grade varchar2(6);
BEGIN
    select sum(t2.saleprice) 
      into l_sum     
      from customer t1, orders t2
     where t1.custid = t2.custid(+)
  group by t1.custid
    having ( select name 
               from customer 
              where custid = t1.custid) = p_name ;
    if l_sum >= 30000 then
        l_grade := '���'; 
    else
        l_grade := '�Ϲ�';
    end if;

  RETURN l_grade;   
  exception 
    when no_data_found then
        dbms_output.put_line('ã�����ϴ� ���� �����ϴ�2');
        l_grade := '����';
        return l_grade;
    when others then
        dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
END GRADE;

--�Լ����� �׽�Ʈ2
var g_grade varchar2;
exec :g_grade := grade('�ڼ���'); 
print g_grade;

--4.
select name, grade(name)
  from customer;
  
--5.
    select t1.custid, t1.name, count(*), nvl(sum(t2.saleprice),0)
      from customer t1, orders t2
     where t1.custid = t2.custid(+)  
  group by t1.custid, t1.name;    

CREATE OR REPLACE PROCEDURE TEST_5 
AS 
    cursor c1 is (
        select t1.custid                custid, 
               t1.name                  name, 
               count(*)                 cnt, 
               nvl(sum(t2.saleprice),0) sum
          from customer t1, orders t2
         where t1.custid = t2.custid(+)  
      group by t1.custid, t1.name ); 

BEGIN
  dbms_output.put_line( 
    rpad('���̵�',10, ' ') || 
    rpad('����',20, ' ') || 
    rpad('������',10, ' ') || 
    rpad('���ž�',10, ' '));
  for rec in c1 loop
    dbms_output.put_line( 
        rpad(rec.custid,10, ' ') || 
        rpad(rec.name,20, ' ') || 
        rpad(rec.cnt,10, ' ') || 
        rpad(rec.sum,10, ' '));
  end loop;

  exception 
    when others then
        dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
END TEST_5;

--6.
--1)���̺����
drop table orders_log;
create table orders_log(
  no            number,             --�⺻Ű
  orderid       number(2),          --�ֹ���ȣ
  old_custid    number(2),          --old
  old_bookid    number(2),
  old_saleprice number(8),
  old_orderdate date,
  new_custid    number(2),          --now
  new_bookid    number(2),
  new_saleprice number(8),
  new_orderdate date,
  udate         timestamp,                --�����Ͻ�
  event_type    varchar2(10)       --'inserting, updating, deleting'
);
alter table orders_log add constraint orders_log_no primary key(no);

--2) ������ ����
create sequence orders_log_no_seq;


CREATE OR REPLACE TRIGGER TEST_6 
AFTER DELETE OR INSERT OR UPDATE ON ORDERS 
FOR EACH ROW 
DECLARE
 --��������
BEGIN
    if inserting then
        insert into orders_log values (
            orders_log_no_seq.nextval, 
            :new.orderid, 
            :old.custid, :old.bookid, :old.saleprice, :old.orderdate,
            :new.custid, :new.bookid, :new.saleprice, :new.orderdate,
            systimestamp, 'inserting');
            
    elsif updating then
        insert into orders_log values (
            orders_log_no_seq.nextval, 
            :old.orderid, 
            :old.custid, :old.bookid, :old.saleprice, :old.orderdate,
            :new.custid, :new.bookid, :new.saleprice, :new.orderdate,
            systimestamp, 'updating');
    elsif deleting then
        insert into orders_log values (
            orders_log_no_seq.nextval, 
            :old.orderid, 
            :old.custid, :old.bookid, :old.saleprice, :old.orderdate,
            :new.custid, :new.bookid, :new.saleprice, :new.orderdate,
            systimestamp, 'deleting');
    end if;
    
END;

--3) order���̺� insert,upate,delete�غ���
select * from orders;
--insert
insert into orders values (20,1,1,30000,sysdate); 
insert into orders values (21,2,2,20000,sysdate); 
--update
update orders
   set bookid = 3, saleprice = 30000
 where orderid = 21;
 update orders
   set bookid = 3, saleprice = 40000
 where orderid = 21;
--delete
delete from orders where orderid = 21;
select * from orders;
select * from orders_log;
delete from orders_log;
commit;
rollback;

select *
  from orders_log
 where orderid = 21
order by udate;


--7.
    select nvl(t3.publisher,'�Ѱ�') "���ǻ�", 
           nvl(t2.name,'�Ұ�') "����", 
           sum(t1.saleprice) "�Ǹž�"
      from orders t1, customer t2, book t3
     where t1.custid = t2.custid
       and t1.bookid = t3.bookid
  group by rollup(t3.publisher, t2.name)
  order by t3.publisher, t2.name;       

--8.
    select t1.publisher "���ǻ�" , nvl(sum(t2.saleprice),0) "���Ǹűݾ�",
           rank() over(order by nvl(sum(t2.saleprice),0) desc) "����"
      from book t1,orders t2
     where t1.bookid = t2.bookid(+)
  group by t1.publisher ;      

  
  