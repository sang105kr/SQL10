select t1.*, t2.*, t3.*
  from customer t1, orders t2, book t3;
  
  
select *
  from customer t1, orders t2
 where t1.custid = t2.custid; 

--inner join
--case1)
select *
  from customer t1, orders t2, book t3
 where t2.custid = t1.custid
   and t2.bookid = t3.bookid;
   
--case2)    
select *
  from customer t1 inner join orders t2 
                   on t1.custid = t2.custid
                   inner join book t3
                   on t2.bookid = t3.bookid;
                   
-- left outer join                   
select *
  from customer t1, orders t2
 where t1.custid = t2.custid(+);   

select *
  from customer t1 left outer join orders t2
                   on t1.custid = t2.custid;  
   
-- right outer join   
select *
  from customer t1, orders t2
 where t1.custid(+) = t2.custid;      
 
select *
  from customer t1 right outer join orders t2
                   on t1.custid = t2.custid;    
   
-- full outer join
select *
  from customer t1, orders t2
 where t1.custid = t2.custid(+)  
union 
select *
  from customer t1, orders t2
 where t1.custid(+) = t2.custid;     

select *
  from customer t1 full outer join orders t2
                   on t1.custid = t2.custid;      
   