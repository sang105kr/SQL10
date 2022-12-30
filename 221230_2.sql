--�ܼ���� ǥ��
set serveroutput on;

--���ν��� ����

--���ν��� ����1
exec getPhoneNumberOfCustumer('������');

--���ν��� ����2

declare
    l_phone customer.phone%type;
begin
    getPhoneNumberOfCustumer2('������',l_phone);
    dbms_output.put_line(l_phone);
end;


--�Լ�����
select getLastName(name) "��"
  from customer
 where name = '������';


declare
    l_custid    customer.custid%type;
    l_name      customer.name%type;
    l_address    customer.address%type;
    l_phone    customer.phone%type;
begin
    select custid,name,address,phone 
      into l_custid,l_name,l_address,l_phone
      from customer
     where custid = &custid; 

    dbms_output.put_line(l_custid || l_name || l_address || l_phone);
    exception
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
end;

set VERIFY off; -- pl/sql���� &�� �̿��� ġȯ ������ ����Ҷ� ġȯ�Ǳ� ������ �󼼰��� ǥ��
declare
    l_customer    customer%rowtype;

begin
    select * 
      into l_customer
      from customer
     where custid = &custid; 

    dbms_output.put_line(l_customer.custid || l_customer.name || l_customer.address || l_customer.phone);
    exception
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
end;

declare
    -- ����� ���ڵ�Ÿ�� ����
    type  customer_record_type is record(
        address customer.address%type,
        phone   customer.phone%type
    );
    -- ������ ���ǵ� Ÿ������ ���� ����
    l_customer_rec customer_record_type;

begin
    select address, phone 
      into l_customer_rec
      from customer
     where custid = &custid; 

    dbms_output.put_line(l_customer_rec.address || l_customer_rec.phone);
    exception
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
end;

-- table type
declare
    -- ����� ���� ���ڵ�Ÿ�� ����
    type  customer_record_type is record(
        address customer.address%type,
        phone   customer.phone%type
    );
    -- ����� ���� ���̺� Ÿ��
    type customer_table_type is table of customer_record_type
       index by binary_integer;
    
    -- ������ ���ǵ� Ÿ������ ���� ����
    l_customer_t customer_table_type;

begin
    select address, phone 
      bulk collect into l_customer_t
      from customer; 

    for i in 1..l_customer_t.count loop  
        dbms_output.put_line(l_customer_t(i).address || l_customer_t(i).phone);
    end loop;
    
    exception
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
end;



declare
    type customer_table_t is table of customer%rowtype
        index by BINARY_INTEGER;
        
    l_customer_t   customer_table_t;
begin

    select * bulk collect into l_customer_t
      from customer;

    for i in 1..l_customer_t.count loop
        dbms_output.put_line(l_customer_t(i).custid || l_customer_t(i).name || l_customer_t(i).address || l_customer_t(i).phone);
    end loop;

    exception
        when others then
            dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
end;


declare

    type customer_table_t is table of customer.name%type;
    
    l_customer_name_t  customer_table_t;
begin

    select name bulk collect into l_customer_name_t
      from customer;

    for i in 1..l_customer_name_t.count loop
        dbms_output.put_line(i || '-' || l_customer_name_t(i));
    end loop;
    
    exception
        when others then
         dbms_output.put_line('���ܹ߻� : ' || SQLCODE || '-' || SQLERRM);
end;














