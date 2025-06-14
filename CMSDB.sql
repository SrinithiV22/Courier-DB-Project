create database CMS;
use CMS;

--creating tables

create table Users(
UserID INT PRIMARY KEY,  
Name VARCHAR(255) not null,  
Email VARCHAR(255) UNIQUE,
Password VARCHAR(255) not null,  
ContactNumber VARCHAR(20),  
Address TEXT  
);

create table Courier(
CourierID INT PRIMARY KEY,  
SenderName VARCHAR(255) not null,  
SenderAddress TEXT,  
ReceiverName VARCHAR(255) not null,  
ReceiverAddress TEXT,  
Weight DECIMAL(5, 2),  
Status VARCHAR(50),  
TrackingNumber VARCHAR(20) UNIQUE,  
DeliveryDate DATE,
UserID INT,
FOREIGN KEY (UserID) REFERENCES Users(UserID));  

create table CourierServices  
(ServiceID INT PRIMARY KEY,  
ServiceName VARCHAR(100) not null,  
Cost DECIMAL(8, 2));

create table Employee  
(EmployeeID INT PRIMARY KEY,  
EName VARCHAR(255),  
Email VARCHAR(255) UNIQUE,  
ContactNumber VARCHAR(20),  
Roles VARCHAR(50),  
Salary DECIMAL(10, 2));

create table Location 
(LocationID INT PRIMARY KEY,  
LocationName VARCHAR(100),  
Address TEXT);

create table Payment 
(PaymentID INT PRIMARY KEY,  
CourierID INT,  
LocationId INT,  
Amount DECIMAL(10, 2),  
PaymentDate DATE,  
FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),  
FOREIGN KEY (LocationID) REFERENCES Location(LocationID));

-- DEFINING RELATIONSHIPS
/*USERS TO COURIER : ONE TO MANY
COURIER TO PAYMENT: ONE TO MANY
LOCATION TO PAYMENT: ONE TO MANY
COURIER TO COURIERSERVICES:MANY TO ONE
*/

INSERT INTO Users (UserID, Name, Email, Password, ContactNumber, Address) VALUES
(1, 'Akshaya', 'akshk@gmail.com', 'ak123', '9845623178', '12 Barati Street, Chennai'),
(2, 'Roshini', 'rosh@yahoo.com', 'rosh456', '9889800321', '45 Nehru Road, Mumbai'),
(3, 'Arjun', 'arjun@outlook.com', 'aju789', '9900112233', '78 Sivaji, Hyderabad'),
(4, 'Sai', 'sai@gmail.com', 'nir321', '7569022311', '67 MGR road, Coimbatore'),
(5, 'Sri', 's22@gmail.com', 'nithi555', '7569220304', '89 Janaki, Pune');

INSERT INTO Courier (CourierID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate, UserID) VALUES
(1, 'Akshaya', '12 Barati Street, Chennai', 'Vishaka', '23 Residency Road, Bangalore', 3.5, 'In Transit', 'TRK123456', '2025-06-15', 1),
(2, 'Roshini', '45 Nehru Road, Mumbai', 'Harish', '11 Ellis Bridge, Ahmedabad', 2.2, 'Delivered', 'TRK234567', '2025-06-10', 2),
(3, 'Arjun', '78 Sivaji, Hyderabad', 'Swetha', '33 Salt Lake, Kolkata', 1.8, 'Pending', 'TRK345678', '2025-06-18', 3),
(4, 'Sai', '67 MGR road, Coimbatore', 'Sri','89 Janaki, Pune', 5.0, 'Dispatched', 'TRK456789', '2025-06-14', 4),
(5, 'Sri', '89 Janaki, Pune', 'Sai','67 MGR road, Coimbatore' , 4.1, 'Delivered', 'TRK567890', '2025-06-09', 5),
(6, 'Sanju', '32 Gandhi Street, Chennai', 'Sathish', '77 Adyar, Chennai', 2.6, 'In Transit', 'TRK678901', '2025-06-17', 1);

INSERT INTO CourierServices (ServiceID, ServiceName, Cost) VALUES
(1, 'Express Delivery', 150.00),
(2, 'Standard Delivery', 100.00),
(3, 'Same-Day Delivery', 250.00),
(4, 'Overnight Delivery', 300.00),
(5, 'Economy Delivery', 80.00);

INSERT INTO Employee (EmployeeID, EName, Email, ContactNumber, Roles, Salary) VALUES
(1, 'Suganthaan', 'sui@courier.in', '9999988888', 'Delivery Agent', 28000.00),
(2, 'Shruthikaa', 'suruthi@courier.in', '9876778899', 'Customer Support', 32000.00),
(3, 'Thirumalai', 'ak@courier.in', '9001122233', 'Pickup Agent', 25000.00),
(4, 'Thanu', 'power@courier.in', '9334455667', 'Operations Manager', 40000.00),
(5, 'Tiana', 'tian@courier.in', '9012345678', 'Warehouse Staff', 22000.00);


INSERT INTO Location (LocationID, LocationName, Address) VALUES
(1, 'Chennai Hub', 'Guindy Industrial Estate, Chennai'),
(2, 'Mumbai Hub', 'Andheri East, Mumbai'),
(3, 'Hyderabad Hub', 'HiTech City, Hyderabad'),
(4, 'Delhi Hub', 'Connaught Place, Delhi'),
(5, 'Kolkata Hub', 'Park Street, Kolkata');

INSERT INTO Payment (PaymentID, CourierID, LocationID, Amount, PaymentDate) VALUES
(1, 1, 1, 300.00, '2025-06-15'),
(2, 2, 2, 150.00, '2025-06-10'),
(3, 3, 3, 200.00, '2025-06-18'),
(4, 4, 4, 275.00, '2025-06-14'),
(5, 5, 5, 220.00, '2025-06-09'),
(6, 6, 1, 180.00, '2025-06-17');

/* TASK 2*/
--1
select * from users;
--2
select c.courierid,c.sendername,c.receivername,c.trackingnumber,c.status,c.deliverydate,c.weight from courier c 
join users u on c.userid = u.userid where u.name = 'akshaya';
--3
select * from Courier;

alter table courier
add employeeid int;

alter table courier
add constraint fk_courier_employee
foreign key (employeeid) references employee(employeeid);

update courier set employeeid = 1 where courierid = 1;
update courier set employeeid = 2 where courierid = 2;
update courier set employeeid = 3 where courierid = 3;
update courier set employeeid = 4 where courierid = 4;
update courier set employeeid = 5 where courierid = 5;
update courier set employeeid = 1 where courierid = 6;

--4,5
select * FROM Courier c 
where courierID=3;

--6
select * from courier c
where status<>'delivered';

--7
select * from courier c
where deliverydate=cast(getdate() as date);

--8
select * from courier c
where status='In transit'

--9
select sendername,count(*) as totalpackages
from courier c
group by sendername;

--10
select sendername,avg(datediff(day,getdate(),deliverydate)) as avgdeliverytime
from courier
group by sendername;

--11
select * from courier where weight between 2.0 and 4.0

--12
select * from employee where ename like '%john%'

--13
select c.* from courier c
join payment p on c.courierid = p.courierid
where p.amount > 50

/*TASK 3*/

--14
select count(*) from courier c
group by employeeID

--15
select locationid,sum(amount) from payment 
group by locationid

--16
select locationname,count(*) from courier c 
join payment p on c.courierID=p.courierID 
join location l on p.locationID=l.locationID  
where c.status='delivered'
group by locationname

--17
select top 1 courierid, avg(datediff(day, deliverydate, getdate())) as avgdeliverytime
from courier
group by courierid
order by avgdeliverytime desc;

--18
select locationname,sum(amount) from location l
join payment p on l.locationid=p.locationid
group by l.locationname
having sum(amount)<200.0;

--19
select sum(amount) from payment
group by locationid

--20
select p.courierid, sum(p.amount) as totalpayment
from payment p
where p.locationid = 1
group by p.courierid
having sum(p.amount) > 1000;

--21
select p.courierid, sum(p.amount) as totalpayment
from payment p
where p.paymentdate > '2025-06-01'
group by p.courierid
having sum(p.amount) > 1000;

--22
select p.locationid, sum(p.amount) as totalreceived
from payment p
where p.paymentdate < '2025-06-30'
group by p.locationid
having sum(p.amount) > 5000

/*Task 4*/

--23
select *
from payment p
inner join courier c on p.courierid = c.courierid;

-- 24
select *
from payment p
inner join location l on p.locationid = l.locationid;

-- 25
select *
from payment p
inner join courier c on p.courierid = c.courierid
inner join location l on p.locationid = l.locationid;

-- 26
select p.*, c.sendername, c.receivername, c.trackingnumber
from payment p
join courier c on p.courierid = c.courierid;

-- 27
select courierid, sum(amount) as totalamount
from payment
group by courierid;

-- 28
select *
from payment
where paymentdate = '2025-06-15';

-- 29
select p.paymentid, c.*
from payment p
join courier c on p.courierid = c.courierid;

-- 30
select p.*, l.locationname
from payment p
join location l on p.locationid = l.locationid;

-- 31
select courierid, sum(amount) as totalpayment
from payment
group by courierid;

-- 32
select *
from payment
where paymentdate between '2025-06-10' and '2025-06-17';

-- 33
select u.*, c.*
from users u
full outer join courier c on u.userid = c.userid;

-- 34
select c.*, cs.*
from courier c
full outer join courierservices cs on c.serviceid = cs.serviceid;
-----
alter table payment
add employeeid int;

update payment set employeeid = 1 where paymentid = 1;
update payment set employeeid = 2 where paymentid = 2;
update payment set employeeid = 3 where paymentid = 3;
update payment set employeeid = 4 where paymentid = 4;
update payment set employeeid = 5 where paymentid = 5;
update payment set employeeid = 1 where paymentid = 6;
------
-- 35
select e.*, p.*
from employee e
full outer join payment p on e.employeeid = p.employeeid;

-- 36
select *
from users u
cross join courierservices cs;

-- 37
select *
from employee e
cross join location l;

-- 38
select courierid, sendername, senderaddress from courier;

-- 39
select courierid, receivername, receiveraddress from courier;

-- 40
select c.*, cs.servicename, cs.cost
from courier c
join courierservices cs on c.serviceid = cs.serviceid;

-- 41
select e.employeeid, e.ename, count(c.courierid) as numcouriers
from employee e
left join courier c on e.employeeid = c.employeeid
group by e.employeeid, e.ename;

-- 42
select l.locationid, l.locationname, sum(p.amount) as totalpayments
from location l
join payment p on l.locationid = p.locationid
group by l.locationid, l.locationname;

-- 43
select *
from courier
where sendername = 'akshaya';

-- 44
select roles, count(*) as numemployees
from employee
group by roles
having count(*) > 1;

-- 45
select p.*
from payment p
join courier c on p.courierid = c.courierid
where cast(c.senderaddress as varchar(max)) = '12 barati street, chennai';

-- 46
select *
from courier
where cast(senderaddress as varchar(max)) = '12 barati street, chennai';

-- 47
select e.employeeid, e.ename, count(c.courierid) as deliveries
from employee e
join courier c on e.employeeid = c.employeeid
group by e.employeeid, e.ename;
-----
alter table courier
add serviceid int;
-----
update courier
set serviceid = 5
where weight <= 2;
update courier
set serviceid = 2
where weight > 2 and weight <= 3.5;
update courier
set serviceid = 1
where weight > 3.5;
-----
-- 48
select c.courierid, cs.cost, sum(p.amount) as paidamount
from courier c
join courierservices cs on c.serviceid = cs.serviceid
join payment p on c.courierid = p.courierid
group by c.courierid, cs.cost
having sum(p.amount) > cs.cost;

/*task 5- SCOPE*/
--49
select * 
from courier 
where weight > (select avg(weight) from courier);

--50
select ename 
from employee 
where salary > (select avg(salary) from employee);

--51
select sum(cost) as totalcost
from courierservices
where cost < (select max(cost) from courierservices);

--52
select c.* 
from courier c
where c.courierid in (select courierid from payment);

--53
select distinct l.locationid,l.locationname,cast(l.address as varchar(255)) as address
from location l
join payment p on l.locationid = p.locationid
where p.amount = (select max(amount) from payment);

--54
select * 
from courier
where weight > all (
    select weight 
    from courier 
    where sendername = 'sri'
);







