--콘솔출력 표시
set serveroutput on;

--프로시저 생성

--프로시저 실행1
exec getPhoneNumberOfCustumer('박지성');

--프로시저 실행2

declare
    l_phone customer.phone%type;
begin
    getPhoneNumberOfCustumer2('박지성',l_phone);
    dbms_output.put_line(l_phone);
end;


--함수정의
select getLastName(name) "성"
  from customer
 where name = '박지성';


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
            dbms_output.put_line('예외발생 : ' || SQLCODE || '-' || SQLERRM);
end;

set VERIFY off; -- pl/sql에서 &를 이용한 치환 변수를 사용할때 치환되기 전후의 상세값을 표현
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
            dbms_output.put_line('예외발생 : ' || SQLCODE || '-' || SQLERRM);
end;

declare
    -- 사용자 레코드타입 정의
    type  customer_record_type is record(
        address customer.address%type,
        phone   customer.phone%type
    );
    -- 위에서 정의된 타입으로 변수 선언
    l_customer_rec customer_record_type;

begin
    select address, phone 
      into l_customer_rec
      from customer
     where custid = &custid; 

    dbms_output.put_line(l_customer_rec.address || l_customer_rec.phone);
    exception
        when others then
            dbms_output.put_line('예외발생 : ' || SQLCODE || '-' || SQLERRM);
end;

-- table type
declare
    -- 사용자 정의 레코드타입 정의
    type  customer_record_type is record(
        address customer.address%type,
        phone   customer.phone%type
    );
    -- 사용자 정의 테이블 타입
    type customer_table_type is table of customer_record_type
       index by binary_integer;
    
    -- 위에서 정의된 타입으로 변수 선언
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
            dbms_output.put_line('예외발생 : ' || SQLCODE || '-' || SQLERRM);
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
            dbms_output.put_line('예외발생 : ' || SQLCODE || '-' || SQLERRM);
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
         dbms_output.put_line('예외발생 : ' || SQLCODE || '-' || SQLERRM);
end;














