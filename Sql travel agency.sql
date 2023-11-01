create database travel_agency;

use travel_agency;
select*from travel_Req;
select*from employee;
--------------------------------------------------------------------------------------------------------------
create table employee (
e_id int primary key identity(1,1),
e_Fname varchar(20) not null,
e_Lname varchar(20),
e_dob date,
e_address varchar(30),
e_contact varchar(20)
);

--------------------------------------------------------------------------------------------------------------
create table travel_Req(
req_id int primary key identity(1,1),
e_id int foreign key references employee(e_id),
loc_From varchar(20),
loc_To varchar(20),
approval_Status varchar(20),
booking_Status varchar(20),
current_Status varchar(20)
);

--------------------------------------------------------------------------------------------------------------

-->Add employees

create or alter procedure add_emp(
@e_Fname varchar(20),
@e_Lname varchar(20),
@e_dob date,
@e_address varchar(30),
@e_contact varchar(20)
)
as
begin
insert into employee 
values(@e_Fname,
@e_Lname,
@e_dob,
@e_address,
@e_contact 
)
end
--------------------------------------------------------------------------------------------------------------
exec add_emp 'Anisha','Dhondge','2004-06-25','Nashik','8010078089';

--------------------------------------------------------------------------------------------------------------
---->delete employee
create or alter procedure delete_emp(@e_id int)
as 
begin
delete from employee where e_id = @e_id
end

---------------------------------------------------------------------------------------------------------------
exec delete_emp 2;

---------------------------------------------------------------------------------------------------------------
-->edit employee
create or alter procedure edit_emp(@e_id int,@E_Fname varchar(20),@e_Lname varchar(20),@e_dob date,@e_address varchar(30),@e_contact varchar(20))
as begin
update employee set e_Fname=@e_Fname,
e_Lname=@e_Lname,
e_dob=@e_dob,
e_address=@e_address,
e_contact=@e_contact
where e_id=@e_id
end
---------------------------------------------------------------------------------------------------------------
exec edit_emp 2,'Snehal','Thoke','2002-01-14','Nashik','8390386019'
---------------------------------------------------------------------------------------------------------------
---->raise request
create or alter procedure raise_req(
@e_id int,
@loc_From varchar(20),
@loc_To varchar(20),
@approval_Status varchar(20),
@booking_Status varchar(20),
@current_Status varchar(20))
as begin
insert into travel_Req values(@e_id,@loc_from,@loc_to,@approval_status,@booking_status,@current_status)
end
----------------------------------------------------------------------------------------------------------------

exec raise_req 3,'Mumbai','pune','Not approved','NA','Open';

----------------------------------------------------------------------------------------------------------------
-->view request
create or alter procedure view_req
as begin
select req_id ,e.e_id, loc_from,loc_to,approval_status ,booking_Status,current_Status,e.e_name 
from employee e inner join travel_Req t
on e.e_id=t.e_id
end
----------------------------------------------------------------------------------------------------------------------
exec view_req 
----------------------------------------------------------------------------------------------------------------------
-->view approved request
create or alter procedure viewapprove_req
as begin
select req_id ,e.e_id, loc_from,loc_to,approval_status ,booking_Status,current_Status, e.e_name 
from employee e inner join travel_Req t
on e.e_id=t.e_id
where current_Status='open' and approval_status='approved'
end
----------------------------------------------------------------------------------------------------------------------
exec viewapprove_req 

----------------------------------------------------------------------------------------------------------------
--->approved req
create or alter procedure approved_req
as
begin
select * from travel_Req where approval_Status='approved'
end
exec approved_req;

----------------------------------------------------------------------------------------------------------------

exec approved_req

----------------------------------------------------------------------------------------------------------------
--->declined req
create or alter procedure Declined_req
as
begin
select * from travel_Req where approval_Status='decline'
end
-----------------------------------------------------------------------------------------------------------------
exec Declined_req;

----------------------------------------------------------------------------------------------------------------
