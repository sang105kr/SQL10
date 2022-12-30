--6장 연습문제
--9-1)
select bookname, price
  from book
 where publisher = '이상미디어' ;
--case1) 커서
declare
    cursor c1 is    select bookname, price
                      from book
                     where publisher = '이상미디어' ;
                     
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
            dbms_output.put_line('예외발생 :' || SQLCODE || '-' || SQLERRM);
end;
--case2) 컬렉션사용1
declare
    type book_table_t is table of book%rowtype
        index by binary_integer;
    l_book_t   book_table_t;
begin
    select *
      bulk collect into l_book_t
      from book
     where publisher = '이상미디어'; 
    
    for i in 1..l_book_t.count loop
        dbms_output.put_line(l_book_t(i).bookname || ' ' || l_book_t(i).price);
    end loop;
     

    exception
        when others then
          dbms_output.put_line('예외발생 :' || SQLCODE || '-' || SQLERRM);
end;
--case3) 컬렉션사용(사용자 정의 레코드)
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
     where publisher = '이상미디어'; 
    
    for i in 1..l_book_t.count loop
        dbms_output.put_line(l_book_t(i).bookname || ' ' || l_book_t(i).price);
    end loop;
     

    exception
        when others then
          dbms_output.put_line('예외발생 :' || SQLCODE || '-' || SQLERRM);
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
          dbms_output.put_line('예외발생 :' || SQLCODE || '-' || SQLERRM);
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
    
    DBMS_OUTPUT.PUT_LINE(l_num_t.first); --첫번째 인덱스
    DBMS_OUTPUT.PUT_LINE(l_num_t.last);  --마지막 인덱스
    DBMS_OUTPUT.PUT_LINE(l_num_t.count); --요소 수
--    if l_num_t.exits(1) then
--      DBMS_OUTPUT.PUT_LINE('존재');
--    end if;
--    DBMS_OUTPUT.PUT_LINE(l_num_t.delete(3));
--    DBMS_OUTPUT.PUT_LINE(l_num_t.next(1));
--    DBMS_OUTPUT.PUT_LINE(l_num_t.prior(3));
    l_char_t('a') := '홍길동1';
    l_char_t('b') := '홍길동2';
    l_char_t('c') := '홍길동3';

    dbms_output.put_line(l_char_t('a'));   
    dbms_output.put_line(l_char_t('b'));
    dbms_output.put_line(l_char_t('c'));
    if l_char_t.exists('a') then   -- 'a' 인덱스에 요소 존재 유무
        dbms_output.put_line('존재');
    end if;
    l_char_t.delete('a');  -- 'a' 인덱스 요소 제거
    if l_char_t.exists('a') then   
        dbms_output.put_line('존재');
    else 
        dbms_output.put_line('없음');
    end if;
     dbms_output.put_line(l_char_t.next('a')); --'a'다음요소값을 가져옮
     dbms_output.put_line(l_char_t.prior('a')); --'a'이전요소값을 가져옮
end;


select t2.name, sum(t1.saleprice)
  from orders t1,customer t2
 where t1.custid = t2.custid
group by t2.name;
   
select grade('박지성')
  from dual;

select name "이름", grade(name) "등급"
  from customer;
  
select name "이름", 
       address "주소",
       case when address like '%대한민국%' then '국내거주'
            else '해외거주'
       end "내외국인"
from customer;
  
   select t2.name "이름", 
          nvl(sum(t1.saleprice),0) "판매총액",
          case when sum(t1.saleprice) >= 20000 then '우수'
               else '보통'
          end  "등급"   
     from orders t1, customer t2
    where t1.custid(+) = t2.custid
 group by t2.name
 order by nvl(sum(t1.saleprice),0) desc;
 
 
 select name "이름", exec5_10_2(name) "국내외 거주여부"
   from customer;

  select exec5_10_2(name) "국내외 거주여부", count(*) "인원수"
    from customer
group by exec5_10_2(name);

  select exec5_10_2(name) "국내외 거주여부", count(*) "인원수"
    from customer
group by rollup(exec5_10_2(name));
