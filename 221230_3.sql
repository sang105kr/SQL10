--6�� ��������
--9-1)
select bookname, price
  from book
 where publisher = '�̻�̵��' ;
--case1) Ŀ��
declare
    cursor c1 is    select bookname, price
                      from book
                     where publisher = '�̻�̵��' ;
                     
    l_bookname  book.bookname%type;
    l_price     book.price%type;
begin
    open c1;
    loop
        fetch c1 into l_bookname, l_price;
        exit when c1%notfound;
        dbms_output.put_line(l_bookname || '  ' || l_price);
    end loop;
    close c1;
    exception
        when others then
            dbms_output.put_line('���ܹ߻� :' || SQLCODE || '-' || SQLERRM);
end;
--case2) �÷��ǻ��1
declare
    type book_table_t is table of book%rowtype
        index by binary_integer;
    l_book_t   book_table_t;
begin
    select *
      bulk collect into l_book_t
      from book
     where publisher = '�̻�̵��'; 
    
    for i in 1..l_book_t.count loop
        dbms_output.put_line(l_book_t(i).bookname || ' ' || l_book_t(i).price);
    end loop;
     

    exception
        when others then
          dbms_output.put_line('���ܹ߻� :' || SQLCODE || '-' || SQLERRM);
end;
--case3) �÷��ǻ��(����� ���� ���ڵ�)
declare
    type book_rec_t is record(
        bookname book.bookname%type,
        price    book.price%type
    );

    type book_table_t is table of book_rec_t
        index by binary_integer;
        
    l_book_t   book_table_t;
begin
    select bookname, price
      bulk collect into l_book_t
      from book
     where publisher = '�̻�̵��'; 
    
    for i in 1..l_book_t.count loop
        dbms_output.put_line(l_book_t(i).bookname || ' ' || l_book_t(i).price);
    end loop;
     

    exception
        when others then
          dbms_output.put_line('���ܹ߻� :' || SQLCODE || '-' || SQLERRM);
end;




declare
    type t_t is table of varchar2(10) index by BINARY_INTEGER;
    l_t t_t;
begin
    l_t(0) := '1';
    l_t(1) := '2';
     dbms_output.put_line(l_t(0));
    exception
        when others then
          dbms_output.put_line('���ܹ߻� :' || SQLCODE || '-' || SQLERRM);
end;

select publisher, count(*)
  from book
group by publisher  ;

set verify off;
declare
    type num_table_t is table of number
        index by binary_integer;
    
    type char_table_t is table of varchar2(20)
        index by varchar2(64);    
        
    l_num_t     num_table_t;
    l_char_t    char_table_t;
begin
    l_num_t(1) := 10;
    l_num_t(2) := 20;
    l_num_t(3) := 30;
    for i in l_num_t.first..l_num_t.last loop
        DBMS_OUTPUT.PUT_LINE(l_num_t(i));
    end loop;
    
    DBMS_OUTPUT.PUT_LINE(l_num_t.first); --ù��° �ε���
    DBMS_OUTPUT.PUT_LINE(l_num_t.last);  --������ �ε���
    DBMS_OUTPUT.PUT_LINE(l_num_t.count); --��� ��
--    if l_num_t.exits(1) then
--      DBMS_OUTPUT.PUT_LINE('����');
--    end if;
--    DBMS_OUTPUT.PUT_LINE(l_num_t.delete(3));
--    DBMS_OUTPUT.PUT_LINE(l_num_t.next(1));
--    DBMS_OUTPUT.PUT_LINE(l_num_t.prior(3));
    l_char_t('a') := 'ȫ�浿1';
    l_char_t('b') := 'ȫ�浿2';
    l_char_t('c') := 'ȫ�浿3';

    dbms_output.put_line(l_char_t('a'));   
    dbms_output.put_line(l_char_t('b'));
    dbms_output.put_line(l_char_t('c'));
    if l_char_t.exists('a') then   -- 'a' �ε����� ��� ���� ����
        dbms_output.put_line('����');
    end if;
    l_char_t.delete('a');  -- 'a' �ε��� ��� ����
    if l_char_t.exists('a') then   
        dbms_output.put_line('����');
    else 
        dbms_output.put_line('����');
    end if;
     dbms_output.put_line(l_char_t.next('a')); --'a'������Ұ��� ������
     dbms_output.put_line(l_char_t.prior('a')); --'a'������Ұ��� ������
end;


select t2.name, sum(t1.saleprice)
  from orders t1,customer t2
 where t1.custid = t2.custid
group by t2.name;
   
select grade('������')
  from dual;

select name "�̸�", grade(name) "���"
  from customer;
  
select name "�̸�", 
       address "�ּ�",
       case when address like '%���ѹα�%' then '��������'
            else '�ؿܰ���'
       end "���ܱ���"
from customer;
  
   select t2.name "�̸�", 
          nvl(sum(t1.saleprice),0) "�Ǹ��Ѿ�",
          case when sum(t1.saleprice) >= 20000 then '���'
               else '����'
          end  "���"   
     from orders t1, customer t2
    where t1.custid(+) = t2.custid
 group by t2.name
 order by nvl(sum(t1.saleprice),0) desc;
 
 
 select name "�̸�", exec5_10_2(name) "������ ���ֿ���"
   from customer;

  select exec5_10_2(name) "������ ���ֿ���", count(*) "�ο���"
    from customer
group by exec5_10_2(name);

  select exec5_10_2(name) "������ ���ֿ���", count(*) "�ο���"
    from customer
group by rollup(exec5_10_2(name));
