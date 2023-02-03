-- ZUNGU KWAZI --
-- LIBRARY MANAGEMENT SYSTEM --
-- SCRIPT WRITTEN IN MySQL WORKBENCH --


 use kwazi_prac; -- My database
 

 -- BOOKS TABLE --
 create table books
 (book_no int primary key, title varchar(50), author varchar(50));
 select * from books;
 
 
 -- READER TABLE --
 create table readers
 (reader_id int primary key, name varchar(20), age int, sex varchar(1) );
 select * from readers;
 
 
 -- BOOK ISSUING TABLE --
 create table issues
 (date_issued date,book_no int ,issued_to int, date_returned date,
 primary key (date_issued,book_no),
 foreign key (book_no) references books(book_no) on delete cascade,
 foreign key (issued_to) references readers(reader_id) on delete cascade); 
 select * from issues;
 
 
 -- STORED PROCEDURES --
 DELIMITER //
 
 -- Procedure for entering books into system --
 create procedure EnterBook(book_no int, title varchar(50), author varchar(50))
 	begin
		insert into books values(book_no, title, author);
 	end //
 
 -- Procedure for entering readers information --
 create procedure EnterReader(reader_id int, name varchar(20), age int, sex varchar(1))
	begin
		insert into readers values(reader_id,name,age,sex);
	end //

-- Procedure for issuing the books --
create procedure IssueBook(date_issued date, book_no int, issued_to int, date_returned date)
	begin
		insert into issues values(date_issued, book_no, issued_to, date_returned);
	end //
 
 DELIMITER ;


 -- DATA QUERYING --
 
 select book_no from issues
 where date_issued like '____-03%';        -- books issued in march
 
 select name,age from readers 
 order by age;                             -- List of readers in ascending order by age
 
 select count(reader_id),sex from readers 
 group by sex;                             -- Reader dispersion by sex
 
 select * from readers limit 5;  -- first 5 readers
 
 select distinct sex from readers; -- how many recorded types of sexes in the data
 
 select * from readers 
 where sex='F' and age>30 order by age; -- female readers older than 30
 
 select max(age),min(age) from readers; -- oldest and youngest reader age in the data
 
 select issues.date_issued, books.title, issues.issued_to
 from issues
 join books
 on issues.book_no=books.book_no; -- join example between issues and books table
 
 select book_no,title as 'Books sold in March 2022' from books where book_no
 in (select book_no from issues 
 where date_issued like '____-03%');  -- nested query for books sold in March viewed by title
 
 select book_no,title as 'Books returned' from books 
 where book_no in
 (select book_no from issues where date_returned is not null); -- books issued and returned
