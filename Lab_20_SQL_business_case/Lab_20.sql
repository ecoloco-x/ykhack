CREATE DATABASE lab_mysql;

USE lab_mysql;

/* create empty tables */

CREATE TABLE if not exists cars (
ID INT NOT NULL AUTO_INCREMENT,
VIN VARCHAR(255),
Manufacturer VARCHAR(255),
Model VARCHAR(255),
Year INT,
Color VARCHAR(255),
	PRIMARY KEY (ID)	);

CREATE TABLE Customers (
ID INT NOT NULL AUTO_INCREMENT,
CustomerID INT,
name VARCHAR(255),
phone VARCHAR(255),
email VARCHAR(255),
address VARCHAR(255),
city VARCHAR(255),
state_province VARCHAR(255),
country VARCHAR(255),
postal INT,
	PRIMARY KEY (ID)	);
    

CREATE TABLE Salespersons (
ID INT NOT NULL AUTO_INCREMENT,
StaffID VARchar(255),
Name VARCHAR(255),
store VARCHAR(255),
	PRIMARY KEY (ID)	);
    
CREATE TABLE if not exists invoices (
ID INT NOT NULL AUTO_INCREMENT,
inv_num INT,
date date,
car_id INT,
customer_id INT,
salesperson_id INT,
	primary key (ID),
    foreign key (car_id) references cars (ID)
		on delete cascade,
	foreign key (customer_id) references customers (ID)
		on delete cascade,
	foreign key (salesperson_id) references salespersons (ID)
		on delete cascade
		);
	

/* Cars table*/

-- manually insert first record
INSERT INTO cars values (0, '3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', 2019, 'Blue');

-- insert the rest
INSERT INTO cars (VIN, Manufacturer, Model, Year, Color)
Values 
('ZM8G7BEUQZ97IH46V', 'Peugeot', 'Rifter', 2019, 'Red'),
('RKXVNNIHLVVZOUB4M', 'Ford', 'Fusion', 2018, 'White'),
('HKNDGS7CU31E9Z7JW', 'Toyota', 'RAV4', 2018, 'Silver'),
('DAM41UDN3CHU2WVF6', 'Volvo', 'V60', 2019, 'Gray'),
('DAM41UDN3CHU2WVF6', 'Volvov', 'V60 Cross Country	', 2019, 'Gray');


/* Customers table*/

-- manually insert first record
INSERT INTO customers values (0, 10001, 'Pablo Picasso', '+34 636 17 63 82', null, 'Paseo de la Chopera, 14' , 'Madrid', 'Madrid', 'Spain', 28045);

-- insert the rest
INSERT INTO customers (CustomerID, name, phone, email, address, city, state_province, country, postal)
Values (20001, 'Abraham Lincoln', '+1 305 907 7086',null , '120 SW 8th Stv', 'Miami', 'Florida', '	United States', 33130),
(30001, 'Napoléon Bonaparte', '+33 1 79 75 40 00',null , '40 Rue du Colisée', 'Paris', 'Île-de-France', 'France', 75008);

SELECT * FROM CUSTOMERS;

/* Salespersons table*/

-- manually insert first record
INSERT INTO salespersons 
values (0, '00001', 'Petey Cruiser', 'Madrid');

-- insert the rest
INSERT INTO salespersons (StaffID, Name, store)
values ('00002', 'Anna Sthesia', 'Barcelona'),
('00003', 'Paul Molive', 'Berlin'),
('00004', 'Gail Forcewind', 'Paris'),
('00005', 'Paige Turner', 'Mimia'),
('00006', 'Bob Frapples', 'Mexico City'),
('00007', 'Walter Melon', 'Amsterdam'),
('00008', 'Shonda Leer', 'São Paulo');

select * from lab_mysql.salespersons;

/* Invoices table*/

-- manually insert first record
INSERT INTO invoices 
values (0, 852399038, str_to_date('22-08-2018','%d-%m-%Y'), 0,1,3);

-- insert the rest
INSERT INTO invoices (inv_num, date, car_id, customer_id, salesperson_id)
values (731166526,str_to_date('31-12-2018','%d-%m-%Y') , 3,0,5),
(271135104,str_to_date('22-01-2019','%d-%m-%Y') , 2,2,7) ;

select * from lab_mysql.invoices;


/* BONUS */
# Q1
select * from salespersons;
update salespersons 
set store = 'miami' where ID = 4;

# Q2
select * from customers;
update customers 
set email = 'ppicasso@gmail.com' where ID = 0;
update customers 
set email = 'lincoln@us.gov' where ID = 1;
update customers 
set email = 'hello@napoleon.me' where ID = 2;

# Q3
SELECT * from cars;
delete from cars where ID = 4;
