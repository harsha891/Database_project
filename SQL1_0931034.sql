-------------------------------------
--NAME : HARSHA VARDHAN GANNAMUNENI--
--STUDENT NO : C0931034            --
--PROJECT : TERM 1 PROJECT         --
--TERM : 1                         --
--PROFESSOR : Jim Cooper           --
-------------------------------------

-------------------------------------
-----------CREATE SEQUENCE--------------
-------------------------------------

CREATE SEQUENCE dh_orders_id_seq 
START WITH 1100 INCREMENT BY 2 
NOCACHE;

-------------------------------------
-----------CREATE TABLE--------------
-------------------------------------

CREATE TABLE dh_products(
    productCode INTEGER NOT NULL,
    modelNumber VARCHAR(30) NOT NULL,
    serialNumber VARCHAR(30) NOT NULL,
    brand VARCHAR(20) NOT NULL,
    description VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    capacity DECIMAL(10,2),
    weight DECIMAL(10,2),
    height DECIMAL(10,2),
    width DECIMAL(10,2),
    color VARCHAR(10)
);

CREATE TABLE dh_customers(
    customerId INTEGER
        GENERATED ALWAYS AS IDENTITY
        START WITH 1001 INCREMENT BY 1
        NOCACHE
        NOT NULL,
    firstName VARCHAR(30) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    address VARCHAR(50) NOT NULL,
    emailId VARCHAR(40),
    phoneNumber varchar(10)
);

CREATE TABLE dh_job(
    jobId INTEGER NOT NULL,
    jobTitle VARCHAR(90) NOT NULL,
    salary decimal(10,2) DEFAULT 20000,
    servicePeriod decimal(38,2)
);

CREATE TABLE dh_employee(
    employeeId INTEGER NOT NULL,
    firstName VARCHAR(30) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    sin INTEGER NOT NULL,
    mobileNumber VARCHAR(10) NOT NULL,
    emailId VARCHAR(50) NOT NULL,
    jobId INTEGER,
    managerId INTEGER
);

CREATE TABLE dh_orders(
    orderId INTEGER NOT NULL,
    orderCost DECIMAL(10,2),
    orderDate DATE DEFAULT CURRENT_DATE NOT NULL,
    customerId INTEGER NOT NULL,
    employeeId INTEGER NOT NULL
);

CREATE TABLE dh_order_lines(
    orderId INTEGER NOT NULL,
    productId INTEGER NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE dh_regions(
    regionId VARCHAR(20) NOT NULL,
    regionName VARCHAR(20) NOT NULL,
    province VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    postCode VARCHAR(20)
);

CREATE TABLE dh_warehouse(
    warehouseId INTEGER NOT NULL,
    warehousePostal VARCHAR(20) NOT NULL,
    regionId VARCHAR(20)
);

CREATE TABLE dh_inventory(
    productId INTEGER NOT NULL,
    warehouseId INTEGER NOT NULL,
    quantity DECIMAL(10,2)
);

-------------------------------------
----------PK CONSTRAINTS-------------
-------------------------------------

ALTER TABLE dh_products
ADD CONSTRAINT dh_productcode_pk
PRIMARY KEY (productCode);

ALTER TABLE dh_customers
ADD CONSTRAINT dh_customerid_pk
PRIMARY KEY (customerId);

ALTER TABLE dh_job
ADD CONSTRAINT dh_jobid_pk
PRIMARY KEY (jobId);

ALTER TABLE dh_employee
ADD CONSTRAINT dh_employeeid_pk
PRIMARY KEY (employeeId);

ALTER TABLE dh_orders
ADD CONSTRAINT dh_orderid_pk
PRIMARY KEY (orderId);

ALTER TABLE dh_order_lines
ADD CONSTRAINT dh_orderlineid_pk
PRIMARY KEY (orderId, productId);

ALTER TABLE dh_regions
ADD CONSTRAINT dh_regionid_pk
PRIMARY KEY (regionId);

ALTER TABLE dh_warehouse
ADD CONSTRAINT dh_warehouseid_pk
PRIMARY KEY (warehouseId);

ALTER TABLE dh_inventory
ADD CONSTRAINT dh_inventoryid_pk
PRIMARY KEY (productId, warehouseId);

-------------------------------------
----------UK CONSTRAINTS-------------
-------------------------------------

ALTER TABLE dh_products
ADD CONSTRAINT dh_products_modelNumber_uk
UNIQUE(modelNumber);

ALTER TABLE dh_products
ADD CONSTRAINT dh_products_serialNumber_uk
UNIQUE(serialNumber);

ALTER TABLE dh_customers
ADD CONSTRAINT dh_customers_emailid_uk
UNIQUE(emailId);

ALTER TABLE dh_customers
ADD CONSTRAINT dh_customers_phonenumber_uk
UNIQUE(phoneNumber);

ALTER TABLE dh_employee
ADD CONSTRAINT dh_employee_sin_uk
UNIQUE(sin);

ALTER TABLE dh_employee
ADD CONSTRAINT dh_employee_emailid_uk
UNIQUE(emailId);

ALTER TABLE dh_warehouse
ADD CONSTRAINT dh_warehouse_postal_uk
UNIQUE(warehousePostal);

-------------------------------------
----------FK CONSTRAINTS-------------
-------------------------------------

ALTER TABLE dh_orders
ADD CONSTRAINT dh_orders_customerId_fk
FOREIGN KEY (customerId)
REFERENCES dh_customers (customerId);

ALTER TABLE dh_orders
ADD CONSTRAINT dh_orders_employeeId_fk
FOREIGN KEY (employeeId)
REFERENCES dh_employee (employeeId);

ALTER TABLE dh_order_lines
ADD CONSTRAINT dh_order_lines_orderId_fk
FOREIGN KEY (orderId)
REFERENCES dh_orders (orderId);

ALTER TABLE dh_order_lines
ADD CONSTRAINT dh_order_lines_productId_fk
FOREIGN KEY (productId)
REFERENCES dh_products (productCode);

ALTER TABLE dh_employee
ADD CONSTRAINT dh_employee_jobId_fk
FOREIGN KEY (jobId)
REFERENCES dh_job (jobId)
ON DELETE SET NULL;

ALTER TABLE dh_employee
ADD CONSTRAINT dh_employee_managerId_fk
FOREIGN KEY (managerId)
REFERENCES dh_employee (employeeId);

ALTER TABLE dh_inventory
ADD CONSTRAINT dh_inventory_productId_fk
FOREIGN KEY (productId)
REFERENCES dh_products (productCode);

ALTER TABLE dh_inventory
ADD CONSTRAINT dh_inventory_warehouseId_fk
FOREIGN KEY (warehouseId)
REFERENCES dh_warehouse (warehouseId);

ALTER TABLE dh_warehouse
ADD CONSTRAINT dh_warehouse_regionId_fk
FOREIGN KEY (regionId)
REFERENCES dh_regions (regionId);

-------------------------------------
-----------DATA CONSTRAINTS----------
-------------------------------------

ALTER TABLE dh_job
ADD CONSTRAINT dh_job_salary_ck
CHECK(salary BETWEEN 20000 AND 150000);

ALTER TABLE dh_job
ADD CONSTRAINT dh_job_servicePeriod_ck
CHECK(servicePeriod >= 0);

ALTER TABLE dh_regions
ADD CONSTRAINT dh_regions_province_ck
CHECK(province IN ('ON', 'MB', 'SK', 'BC', 'AB', 'QC'));

----------------------------------------------------------------
---------------------------INSERTS------------------------------
----------------------------------------------------------------

-- DH_PRODUCTS
INSERT INTO DH_PRODUCTS VALUES (1001, 'FAD504DWD', '101AW4P008', 'Frigidaire', 'Dehumidifiers offer effective humidity control for small space', 'Portable', 2500.89, 459.34, 15.5, 9.6, 5.5, 'White');
INSERT INTO DH_PRODUCTS VALUES (1002, 'HME020031N', '101HL4P999', 'hOmeLabs', 'Dehumidifier for more comfortable and healthier environment.', 'Mini', 1500.00, 150.34, 9.5, 5.6, 3.5, 'Grey');
INSERT INTO DH_PRODUCTS VALUES (1003, 'FAD884DMD', '101AW4O779', 'Frigidaire', 'Dehumidifier offer effective humidity control for LARGE space.', 'Large', 6500.90, 850.34, 20.5, 20.6, 8.5, 'White');
INSERT INTO DH_PRODUCTS VALUES (1004, 'UD501KOJ5', '501LG4K098', 'LG', 'Dehumidifiers offer effective humidity control for medium space', 'Mini', 1200.09, 249.34, 5.5, 4.6, 2.5, 'Black');
INSERT INTO DH_PRODUCTS VALUES (1005, 'UD881KO67', '601LG4K090', 'LG', 'Dehumidifier for more comfort.', 'Commercial', 9900.00, 1050.34, 25.5, 10.6, 8.5, 'Silver');
INSERT INTO DH_PRODUCTS VALUES (1006, 'KSTAD50B', '678KS4W79', 'Keystone', 'powerful moisture removal for a fresher, drier indoor environment.', 'Energy Star', 4500.90, 350.00, 10.5, 5.6, 2.5, 'Brown');
INSERT INTO DH_PRODUCTS VALUES (1007, 'SOLA89I79', '501SL4P108', 'Soleus Air', 'Dehumidifiers offer effective humidity control for medium space', 'Large', 3500.09, 1059.34, 25.5, 9.6, 10.5, 'Red');
INSERT INTO DH_PRODUCTS VALUES (1008, 'HME021E45N', '101HL4S089', 'hOmeLabs', 'Dehumidifier for more comfortable and healthier environment for small space', 'Mini', 910.00, 180.34, 9.0, 2.6, 2.5, 'Grey');
INSERT INTO DH_PRODUCTS VALUES (1009, 'TP50WK09', '411HW4O779', 'Honeywell', 'Dehumidifier offer effective humidity control for LARGE space.', 'Large', 5500.90, 700.00, 22.0, 22.00, 7.5, 'Navy');
INSERT INTO DH_PRODUCTS VALUES (1010, 'HME01EN34', '501HL7098', 'hOmeLabs', 'Dehumidifiers offer effective humidity control for medium space', 'Medium', 1000.09, 600.34, 15.5, 4.6, 3.5, 'White');
INSERT INTO DH_PRODUCTS VALUES (1011, 'UD881KO69', '801HL4K96', 'hOmeLabs', 'Dehumidifier for more comfort for vehicles', 'Portable', 10000.00, 140.00, 10.5, 7.6, 8.85, 'Silver');
INSERT INTO DH_PRODUCTS VALUES (1012, 'SOLA89I58', '978SA4O79', 'Soleus Air', 'Efficient moisture control for a more comfortable home environment.', 'Energy Efficient', 5700.90, 300.00, 18.5, 7.6, 5.5, 'Brown');
INSERT INTO DH_PRODUCTS VALUES (1013, 'DAN567DWD', '111DW4P088', 'Danby', 'Dehumidifiers offer effective humidity control for small space', 'Portable', 2700.89, 409.34, 16.5, 10.6, 4.5, 'White');
INSERT INTO DH_PRODUCTS VALUES (1014, 'HME020731N', '102HL4P988', 'hOmeLabs', 'Dehumidifier for more comfortable and healthier environment.', 'Mini', 1550.00, 150.34, 8.5, 6.6, 7.5, 'Grey');
INSERT INTO DH_PRODUCTS VALUES (1015, 'DAN560DKL', '111DW4P009', 'Danby', 'Dehumidifier offer effective humidity control for LARGE space.', 'Large', 8600.90, 450.34, 18.5, 17.6, 8.5, 'Silver');
INSERT INTO DH_PRODUCTS VALUES (1016, 'DAN00DOL', '111DW4P067', 'Danby', 'Dehumidifiers offer effective humidity control for medium space', 'Mini', 1600.09, 249.34, 5.5, 4.6, 2.5, 'Black');
INSERT INTO DH_PRODUCTS VALUES (1017, 'UD881KO90', '611LG4K90', 'LG', 'Dehumidifier for more comfort.', 'Commercial', 9950.00, 1050.34, 25.5, 10.6, 8.5, 'Silver');
INSERT INTO DH_PRODUCTS VALUES (1018, 'KSTLD90K', '679KS4O79', 'Keystone', 'powerful moisture removal for a fresher, drier indoor environment.', 'Energy Star', 4050.90, 350.00, 10.5, 5.6, 2.5, 'Red');
INSERT INTO DH_PRODUCTS VALUES (1019, 'SOLA89I30', '501SLP190', 'Soleus Air', 'Dehumidifiers offer effective humidity control for medium space', 'Large', 3050.09, 1059.34, 25.5, 9.4, 11.5, 'Red');
INSERT INTO DH_PRODUCTS VALUES (1020, 'DAN060HUY', '111DW8P990', 'Danby', 'Dehumidifier for more comfortable and healthier environment for small space', 'Mini', 950.00, 170.34, 8.0, 3.6, 2.8, 'Grey');
INSERT INTO DH_PRODUCTS VALUES (1021, 'TP50WK80', '517HW4O679', 'Honeywell', 'Dehumidifier offer effective humidity control for LARGE space.', 'Large', 5500.90, 730.00, 20.0, 28.00, 5.5, 'Navy');
INSERT INTO DH_PRODUCTS VALUES (1022, 'HME01EP34', '501HL7097', 'hOmeLabs', 'Dehumidifiers offer effective humidity control for medium space', 'Medium', 1400.09, 550.34, 13.5, 5.6, 3.5, 'White');
INSERT INTO DH_PRODUCTS VALUES (1023, 'DAN160HTF', '101DW8P090', 'Danby', 'Dehumidifier for more comfort for vehicles', 'Portable', 10500.00, 150.00, 9.5, 5.6, 8.8, 'Silver');
INSERT INTO DH_PRODUCTS VALUES (1024, 'SOLO80I48', '978SA4O09', 'Soleus Air', 'Efficient moisture control for a more comfortable home environment.', 'Energy Efficient', 5900.90, 350.00, 17.5, 7.3, 4.5, 'Grey');
INSERT INTO DH_PRODUCTS VALUES (1025, 'TP50WK10', '411HW4O780', 'Honeywell', 'Dehumidifier offer effective humidity control for small space.', 'Small', 2050.90, 156.00, 8.0, 2.00, 3.5, 'Navy');
INSERT INTO DH_PRODUCTS VALUES (1026, 'TP50WK29', '411HW4O809', 'Honeywell', 'Dehumidifier offer effective humidity control for medium space.', 'Medium', 4025.90, 580.00, 13.0, 12.00, 5.5, 'Brown');
INSERT INTO DH_PRODUCTS VALUES (1027, 'TP50W109', '411HW4O079', 'Honeywell', 'Dehumidifier offer effective humidity control for LARGE space.', 'Large', 10000.90, 1348.00, 26.0, 22.00, 9.5, 'White');
INSERT INTO DH_PRODUCTS VALUES (1028, 'SOLA99I82', '501SLJ87I8', 'Soleus Air', 'Portable dehumidifiers offer humidity control', 'Portable', 3070.09, 139.34, 26.5, 10.4, 10.5, 'Red');
INSERT INTO DH_PRODUCTS VALUES (1029, 'SOLA90I82', '501SLJ86I8', 'Soleus Air', 'Dehumidifiers offer humidity control for basement', 'Medium', 3500.09, 550.50, 46.5, 8.4, 9.5, 'Brown');
INSERT INTO DH_PRODUCTS VALUES (1030, 'HME03EP64', '511HL7107', 'hOmeLabs', 'Dehumidifiers offer effective humidity control for medium space', 'Medium', 1450.09, 553.34, 19.5, 5.5, 4.5, 'White');

-- dh_customers

INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Sam', 'Taylor', '999 Willow Ave, Montreal, Canada', 'samtaylor@gmail.com', '5146789012');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Alex', 'Lee', '777 Birch St, Vancouver, Canada', 'alexlee@gmail.com', '6047890123');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Olive', 'Nguyen', '888 Oakwood Dr, Toronto, Canada', 'olivenguyen@yahoo.com', '4168901234');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Johnny', 'Smith', '123 Main St, Toronto, Canada', 'johnnysmith@gmail.com', '1234567890');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Emma', 'Johnson', '456 Elm St, Vancouver, Canada', 'emmajohnson@yahoo.com', '2345678901');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Mike', 'Williams', '789 Oak St, Montreal, Canada', 'mikewilliams@gmail.com', '3456789012');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Sara', 'Brown', '101 Pine St, Calgary, Canada', 'sarabrown@yahoo.com', '4567890123');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Chris', 'Jones', '234 Cedar St, Ottawa, Canada', 'chrisjones@gmail.com', '6135678901');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Jenny', 'Thomas', '555 Cedarwood Ct, Victoria, Canada', 'jennythomas@yahoo.com', '2502345678');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Rob', 'Jackson', '666 Birchwood Dr, St. John, Canada', 'robjackson@gmail.com', '7093456789');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Brit', 'White', '777 Maplewood Dr, Hamilton, Canada', 'britwhite@gmail.com', '9054567890');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Dan', 'Harris', '888 Elmwood Dr, London, Canada', 'danharris@gmail.com', '5195678901');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Amanda', 'Davis', '567 Birch St, Edmonton, Canada', 'amandadavis@gmail.com', '7806789012');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Matt', 'Miller', '890 Walnut St, Quebec City, Canada', 'mattmiller@yahoo.com', '4187890123');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Jess', 'Wilson', '111 Elmwood Ave, Winnipeg, Canada', 'jesswilson@yahoo.com', '2048901234');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Dave', 'Taylor', '222 Maple Ave, Halifax, Canada', 'davetaylor@yahoo.com', '9029012345');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Ash', 'Anderson', '333 Oakwood Dr, Saskatoon, Canada', 'ashanderson@gmail.com', '3060123456');
INSERT INTO dh_customers (firstName, lastName, address, emailId, phoneNumber) VALUES('Jamie', 'Martinez', '444 Pineview Ln, Regina, Canada', 'jamiemartinez@gmail.com', '3061234567');

-- dh_job
INSERT INTO dh_job VALUES (101, 'Sales Associate', 35000, 1);
INSERT INTO dh_job VALUES (102, 'Customer Service Representative', 30000, 2);
INSERT INTO dh_job VALUES (103, 'Warehouse Associate', 28000, 1.5);
INSERT INTO dh_job VALUES (402, 'Manager', 80000, 2);
INSERT INTO dh_job VALUES (401, 'District Manager', 98000, 3);
INSERT INTO dh_job VALUES (301, 'Supervisor', 60000, 1.5);
INSERT INTO dh_job VALUES (801, 'Joinee', 60000, 1);

-- dh_employee
INSERT INTO dh_employee VALUES (901, 'Isabella', 'Garcia', 765454321, '6047654543', 'isabella.garcia@gmail.com', 401, NULL);
INSERT INTO dh_employee VALUES (902, 'Liam', 'Martinez', 876554321, '4168765543', 'liam.martinez@gmail.com', 402, 901);
INSERT INTO dh_employee VALUES (903, 'Alice', 'Smith', 987654321, '4169876543', 'alice.smith@yahoo.com', 402, 901);
INSERT INTO dh_employee VALUES (904, 'Olivia', 'Jones', 543210987, '6135432109', 'olivia.jones@gmail.com', 301, 902);
INSERT INTO dh_employee VALUES (905, 'Emma', 'Williams', 765432109, '5147654321', 'emma.williams@yahoo.com', 301, 903);
INSERT INTO dh_employee VALUES (906, 'Robert', 'Johnson', 876543210, '6048765432', 'robert.johnson@gmail.com', 101, 904);
INSERT INTO dh_employee VALUES (907, 'Noah', 'Brown', 654321098, '4036543210', 'noah.brown@gmail.com', 101, 904);
INSERT INTO dh_employee VALUES (908, 'Sophia', 'Miller', 321098765, '4183210987', 'sophia.miller@gmail.com', 101, 905);
INSERT INTO dh_employee VALUES (909, 'Ethan', 'Wilson', 210987654, '2042109876', 'ethan.wilson@yahoo.com', 101, 905);
INSERT INTO dh_employee VALUES (910, 'Mia', 'Taylor', 109876543, '9021098765', 'mia.taylor@gmail.com', 102, 901);
INSERT INTO dh_employee VALUES (911, 'Liam', 'Davis', 432109876, '7804321098', 'liam.davis@gmail.com', 102, 902);
INSERT INTO dh_employee VALUES (912, 'Ava', 'Anderson', 987665432, '3069876543', 'ava.anderson@gmail.com', 102, 901);

-- dh_regions
INSERT INTO dh_regions VALUES ('ONO01', 'Eastern', 'ON', 'Ottawa', NULL);
INSERT INTO dh_regions VALUES ('BCV01', 'Western', 'BC', 'Vancouver', NULL);
INSERT INTO dh_regions VALUES ('ALC01', 'Prairie', 'AB', 'Calgary', NULL);
INSERT INTO dh_regions VALUES ('QCM01', 'Central', 'QC', 'Montreal', NULL);
INSERT INTO dh_regions VALUES ('BCV02', 'Pacific', 'BC', 'Victoria', NULL);
INSERT INTO dh_regions VALUES ('MNW01', 'Northern', 'MB', 'Winnipeg', NULL);
INSERT INTO dh_regions VALUES ('ONT02', 'Southern', 'ON', 'Toronto', NULL);
INSERT INTO dh_regions VALUES ('SKR01', 'Western', 'SK', 'Regina', NULL);
INSERT INTO dh_regions VALUES ('ALE02', 'Central', 'AB', 'Edmonton', NULL);
INSERT INTO dh_regions VALUES ('BCN03', 'Pacific', 'BC', 'Nanaimo', NULL);

-- dh_warehouse
INSERT INTO dh_warehouse VALUES (101, 'K1A 0B1', 'ONO01');
INSERT INTO dh_warehouse VALUES (102, 'V6C 3E3', 'BCV01');
INSERT INTO dh_warehouse VALUES (103, 'T1X 0L5', 'ALC01');
INSERT INTO dh_warehouse VALUES (104, 'T2P 2T3', 'ALC01');
INSERT INTO dh_warehouse VALUES (105, 'H2Y 1V4', 'QCM01');
INSERT INTO dh_warehouse VALUES (106, 'S4P 2Z5', 'SKR01');
INSERT INTO dh_warehouse VALUES (107, 'V8W 3C8', 'BCV02');
INSERT INTO dh_warehouse VALUES (108, 'R3C 3A3', 'MNW01');
INSERT INTO dh_warehouse VALUES (109, 'M5H 2N2', 'ONT02');
INSERT INTO dh_warehouse VALUES (110, 'V9R 5J4', 'BCN03');

-- dh_inventory
INSERT INTO dh_inventory VALUES (1001, 101, 50);
INSERT INTO dh_inventory VALUES (1002, 101, 75);
INSERT INTO dh_inventory VALUES (1015, 102, 10);
INSERT INTO dh_inventory VALUES (1003, 103, 80);
INSERT INTO dh_inventory VALUES (1013, 104, 60);
INSERT INTO dh_inventory VALUES (1002, 103, 50);
INSERT INTO dh_inventory VALUES (1004, 105, 43);
INSERT INTO dh_inventory VALUES (1027, 102, 100);
INSERT INTO dh_inventory VALUES (1001, 102, 35);
INSERT INTO dh_inventory VALUES (1019, 104, 30);
INSERT INTO dh_inventory VALUES (1011, 108, 50);
INSERT INTO dh_inventory VALUES (1002, 108, 75);
INSERT INTO dh_inventory VALUES (1021, 102, 15);
INSERT INTO dh_inventory VALUES (1003, 101, 30);
INSERT INTO dh_inventory VALUES (1030, 104, 60);
INSERT INTO dh_inventory VALUES (1027, 105, 50);
INSERT INTO dh_inventory VALUES (1001, 109, 25);
INSERT INTO dh_inventory VALUES (1026, 102, 15);
INSERT INTO dh_inventory VALUES (1001, 103, 20);
INSERT INTO dh_inventory VALUES (1030, 105, 60);
INSERT INTO dh_inventory VALUES (1004, 109, 50);
INSERT INTO dh_inventory VALUES (1010, 101, 50);
INSERT INTO dh_inventory VALUES (1002, 106, 15);
INSERT INTO dh_inventory VALUES (1009, 103, 25);
INSERT INTO dh_inventory VALUES (1008, 104, 10);
INSERT INTO dh_inventory VALUES (1003, 110, 19);
INSERT INTO dh_inventory VALUES (1018, 101, 50);
INSERT INTO dh_inventory VALUES (1020, 102, 100);
INSERT INTO dh_inventory VALUES (1012, 103, 85);
INSERT INTO dh_inventory VALUES (1001, 104, 35);
INSERT INTO dh_inventory VALUES (1005, 101, 50);
INSERT INTO dh_inventory VALUES (1006, 101, 75);
INSERT INTO dh_inventory VALUES (1007, 102, 10);
INSERT INTO dh_inventory VALUES (1022, 103, 80);
INSERT INTO dh_inventory VALUES (1006, 104, 60);
INSERT INTO dh_inventory VALUES (1006, 103, 50);
INSERT INTO dh_inventory VALUES (1007, 105, 43);
INSERT INTO dh_inventory VALUES (1028, 103, 100);
INSERT INTO dh_inventory VALUES (1005, 102, 35);
INSERT INTO dh_inventory VALUES (1021, 104, 30);
INSERT INTO dh_inventory VALUES (1030, 108, 50);
INSERT INTO dh_inventory VALUES (1006, 108, 75);
INSERT INTO dh_inventory VALUES (1019, 102, 15);
INSERT INTO dh_inventory VALUES (1022, 101, 30);
INSERT INTO dh_inventory VALUES (1029, 104, 60);
INSERT INTO dh_inventory VALUES (1019, 105, 50);
INSERT INTO dh_inventory VALUES (1005, 109, 25);
INSERT INTO dh_inventory VALUES (1028, 102, 15);
INSERT INTO dh_inventory VALUES (1005, 103, 20);
INSERT INTO dh_inventory VALUES (1011, 105, 60);
INSERT INTO dh_inventory VALUES (1029, 109, 50);
INSERT INTO dh_inventory VALUES (1026, 101, 50);
INSERT INTO dh_inventory VALUES (1006, 106, 15);
INSERT INTO dh_inventory VALUES (1025, 103, 25);
INSERT INTO dh_inventory VALUES (1014, 104, 10);
INSERT INTO dh_inventory VALUES (1023, 110, 19);
INSERT INTO dh_inventory VALUES (1024, 101, 50);
INSERT INTO dh_inventory VALUES (1017, 102, 100);
INSERT INTO dh_inventory VALUES (1016, 103, 85);
INSERT INTO dh_inventory VALUES (1005, 104, 35);

-- dh_orders and dh_order_lines
--------------- ORDER WITH 1 PRODUCT
INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 5001.78, '2024-03-03', 1001, 901)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1001, 2, 2500.89)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 1500.00, '2024-02-03', 1002, 902)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1002, 1, 1500.00)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 13001.80, '2024-03-04', 1003, 901)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1003, 2, 6500.90)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 9900.00, '2024-03-05', 1006, 903)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1005, 1, 9900.00)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 9900.00, '2024-02-03', 1001, 904)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1005, 1, 9900.00)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 5500.90, '2024-03-03', 1013, 904)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1009, 1, 5500.90)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 2000.18, '2024-02-29', 1017, 908)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1010, 2, 1000.09)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 9950.00, '2024-01-30', 1010, 901)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1017, 1, 9950.00)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 1450.09, '2023-12-23', 1018, 909)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1030, 1, 1450.09)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 2900.10, '2024-02-23', 1009, 905)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1030, 2, 1450.09)
SELECT 1 FROM DUAL;

--------------- ORDER WITH 2 PRODUCTs
INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 6451.87, '2024-03-03', 1001, 901)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1030, 1, 1450.09)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1001, 2, 2500.89)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 2050.90, '2024-02-03', 1002, 902)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1021, 1, 5500.90)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1002, 1, 1500.00)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 16400.90, '2024-03-04', 1003, 901)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1005, 1, 9900.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1003, 2, 6500.90)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 10850.00, '2024-03-05', 1006, 903)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1020, 1, 950.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1005, 1, 9900.00)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 28400.90, '2024-02-03', 1001, 904)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1005, 2, 9900.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1015, 1, 8600.90)
SELECT 1 FROM DUAL;
--
INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 6500.99, '2024-03-03', 1013, 904)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1009, 1, 5500.90)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1010, 1, 1000.09)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 1950.09, '2024-02-29', 1017, 908)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1010, 2, 1000.09)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1020, 2, 950.00)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 8570.99, '2024-01-30', 1010, 901)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1009, 1, 5500.90)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1028, 1, 3070.09)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 11950.18, '2023-12-23', 1010, 909)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1017, 1, 9950.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1010, 2, 1000.09)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 4900.36, '2024-02-23', 1018, 905)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1010, 2, 1000.09)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1030, 2, 1450.09)
SELECT 1 FROM DUAL;

--------------- ORDER WITH 3 PRODUCTs
INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 7951.87, '2024-03-03', 1001, 901)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1030, 1, 1450.09)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1001, 2, 2500.89)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1002, 1, 1500.00)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 3450.99, '2024-02-03', 1002, 902)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1021, 1, 5500.90)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1002, 1, 1500.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1022, 1, 1400.09)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 19101.79, '2024-03-04', 1003, 901)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1005, 1, 9900.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1003, 2, 6500.90)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1013, 1, 2700.89)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 17350.90, '2024-03-05', 1006, 903)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1020, 1, 950.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1005, 1, 9900.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1003, 1, 6500.90)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 38401.80, '2024-02-03', 1001, 904)


INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1027, 1, 10000.90)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1005, 2, 9900.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1015, 1, 8600.90)
SELECT 1 FROM DUAL;
--
INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 16400.99, '2024-03-03', 1013, 904)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1005, 1, 9900.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1009, 1, 5500.90)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1010, 1, 1000.09)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 3550.18, '2024-02-29', 1017, 908)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1016, 2, 1600.09)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1010, 2, 1000.09)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1020, 2, 950.00)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 11471.17, '2024-01-30', 1010, 901)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1009, 1, 5500.90)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1028, 1, 3070.09)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1030, 2, 1450.09)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 17451.08, '2023-12-23', 1010, 909)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1017, 1, 9950.00)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1010, 2, 1000.09)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1021, 1, 5500.90)
SELECT 1 FROM DUAL;
--

INSERT ALL
INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 13501.26, '2024-02-23', 1018, 905)

INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1015, 1, 8600.90)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1010, 2, 1000.09)
INTO dh_order_lines VALUES (dh_orders_id_seq.CURRVAL, 1030, 2, 1450.09)
SELECT 1 FROM DUAL;


----------------------------------------------------------------
--------------------DATA CONSTRAINT TESTING---------------------
----------------------------------------------------------------

----------------------------------------------------------------
----------------------DATA TYPE CONSTRAINT----------------------

------EXPECTED RESULT : ERROR FOR INVALID DATA TYPE - integer
INSERT INTO dh_warehouse VALUES ('1A2', 'K1A 0B1', 'ONO01');
------RESULT : ORA-01722: invalid number

------EXPECTED RESULT : ERROR FOR INVALID DATE TYPE - '2024'
INSERT INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 2900.10, '2024', 1009, 905);
------RESULT : ORA-01840: input value not long enough for date format.

----------------------------------------------------------------
----------------------NULL CONSTRAINT---------------------------

------EXPECTED RESULT : INSERTION FAIL BECAUSE NULL VALUE AT FIRST NAME COLUMN
INSERT INTO dh_customers(firstName, lastName, address, emailId, phoneNumber) VALUES (NULL, 'Taylor', '999 Willow Ave, Montreal, Canada', 'saanthataylor@gmail.com', '514678012');
------RESULT : ORA-01400: cannot insert NULL into ("WKSP_DBPRACTICELAMBTON"."DH_CUSTOMERS"."FIRSTNAME")

----------------------------------------------------------------
----------------------DEFAULT CONSTRAINT------------------------

------EXPECTED RESULT : INSERTION SUCCESSFUL WITH DEFAULT DATE AS CURRENT
INSERT INTO dh_orders VALUES (dh_orders_id_seq.NEXTVAL, 9000.00, DEFAULT, 1001, 907);
------RESULT : 1 row(s) inserted.

----------------------------------------------------------------
----------------------PRIMARY KEY CONSTRAINT--------------------

--------------------on DH_PRODUCTS
----VALID DATA :
------EXPECTED RESULT : ROW INSERTION SUCCESSFUL
INSERT INTO DH_PRODUCTS VALUES (1031, 'HME03EP4', '511H7107', 'hOmeLabs', 'Dehumidifiers offer effective humidity control for medium space', 'Medium', 1450.09, 553.34, 19.5, 5.5, 4.5, 'White');
------RESULT : 1 row(s) inserted.

----DUPLICATE PRIMARY KEY
------EXPECTED RESULT : FAILED TO INSERT BELOW RECORD
INSERT INTO DH_PRODUCTS VALUES (1031, 'HME03EP4', '511H7107', 'hOmeLabs', 'Dehumidifiers offer effective humidity control for medium space', 'Medium', 1450.09, 553.34, 19.5, 5.5, 4.5, 'White');
------RESULT : ORA-00001: unique constraint (WKSP_DBPRACTICELAMBTON.DH_PRODUCTCODE_PK) violated

---------------------on dh_inventory
----VALID DATA :
------EXPECTED RESULT : ROW INSERTION SUCCESSFUL
INSERT INTO dh_inventory VALUES (1001, 106, 50);
------RESULT : 1 row(s) inserted.

----DUPLICATE PRIMARY KEY
------EXPECTED RESULT : FAILED TO INSERT BELOW RECORD
INSERT INTO dh_inventory VALUES (1001, 106, 50);
------RESULT : ORA-00001: unique constraint (WKSP_DBPRACTICELAMBTON.DH_INVENTORYID_PK) violated

----------------------------------------------------------------
----------------------UNIQUE KEY CONSTRAINT---------------------

--------------------on dh_employee
----VALID DATA :
------EXPECTED RESULT : ROW INSERTION SUCCESSFUL
INSERT INTO dh_employee VALUES (913, 'Anaa', 'Anison', 997660432, '306987643', 'ava1.anderson@gmail.com', 102, 901);
------RESULT : 1 row(s) inserted.

----DUPLICATE DATA FOR SIN COLUMN
------EXPECTED RESULT : ROW INSERTION FAILED BECAUSE OF UNIQUE KEY - SIN
INSERT INTO dh_employee VALUES (914, 'Anaa', 'Anison', 997660432, '306987643', 'ava1.anderson@gmail.com', 102, 901);
------RESULT : ORA-00001: unique constraint (WKSP_DBPRACTICELAMBTON.DH_EMPLOYEE_SIN_UK) violated

-----------------------------------------------------------------
----------------------FOREIGN KEY CONSTRAINT---------------------

--------------------on dh_employee jobId
----VALID DATA :
------EXPECTED RESULT : ROW INSERTION SUCCESSFUL
INSERT INTO dh_employee VALUES (915, 'kate', 'Will', 987065402, '309876543', 'kate.Will@gmail.com', 801, 901);
------RESULT : 1 row(s) inserted.

----INVALID DATA FOR FOREING KEY JOBID:
------EXPECTED RESULT : ROW INSERTION SHOULD FAIL
INSERT INTO dh_employee VALUES (916, 'katy', 'Millet', 987069402, '359876543', 'katy.Millet@gmail.com', 1010, 901);
------RESULT : ORA-02291: integrity constraint (WKSP_DBPRACTICELAMBTON.DH_EMPLOYEE_JOBID_FK) violated - parent key not found

--------------------on dh_employee managerId

--INVALID MANAGER ID VALUE
------EXPECTED RESULT : ROW INSERTION SHOULD FAIL
INSERT INTO dh_employee VALUES (916, 'katy', 'Millet', 987069402, '359876543', 'katy.Millet@gmail.com', 801, 1001);
------RESULT : ORA-02291: integrity constraint (WKSP_DBPRACTICELAMBTON.DH_EMPLOYEE_MANAGERID_FK) violated - parent key not found

--------------------on dh_inventory productId

-- INVALID PRODUCT ID VALUE
------EXPECTED RESULT : ROW INSERTION SHOULD FAIL
INSERT INTO dh_inventory VALUES (1033, 104, 30);
------RESULT : ORA-02291: integrity constraint (WKSP_DBPRACTICELAMBTON.DH_INVENTORY_PRODUCTID_FK) violated - parent key not found

--------------------on dh_order_lines ORDERID

-- INVALID ORDER ID VALUE
------EXPECTED RESULT : ROW INSERTION SHOULD FAIL
INSERT INTO dh_order_lines VALUES (1, 1009, 1, 5500.90);
------RESULT : ORA-02291: integrity constraint (WKSP_DBPRACTICELAMBTON.DH_ORDER_LINES_ORDERID_FK) violated - parent key not found

--------------------on dh_employee  ON DELETE

DELETE dh_job WHERE jobId=801;
------RESULT : jobId IN dh_employee WILL BE NULL FOR JOBID 801

-----------------------------------------------------------
----------------------CHECK CONSTRAINT---------------------

--------------------on dh_job

--- EXPECTED RESULT : INSERTION FAILURE BECAUSE SALARY LESS THAN 20000 CHECK
INSERT INTO dh_job VALUES (802, 'Joinee', 12000, 1);
--- RESULT : ORA-02290: check constraint (WKSP_DBPRACTICELAMBTON.DH_JOB_SALARY_CK) violated

--- EXPECTED RESULT : INSERTION FAILURE BECAUSE SALARY GREATER THAN 150000 CHECK
INSERT INTO dh_job VALUES (802, 'Joinee', 200000, 1);
--- RESULT : ORA-02290: check constraint (WKSP_DBPRACTICELAMBTON.DH_JOB_SALARY_CK) violated

--- EXPECTED RESULT : INSERTION FAILURE BECAUSE SERVICE PERIOD LESS THAN 0
INSERT INTO dh_job VALUES (802, 'Joinee', 20000, -1);
--- RESULT : ORA-02290: check constraint (WKSP_DBPRACTICELAMBTON.DH_JOB_SERVICEPERIOD_CK) violated

--------------------on dh_regions

--- EXPECTED RESULT : INSERTION FAILURE BECAUSE PROVINCE IS NOT IN ('ON', 'MB', 'SK', 'BC', 'AB', 'QC')
INSERT INTO dh_regions VALUES ('BCN03', 'Pacific', 'NL', 'Nanaimo', NULL);
--- RESULT : ORA-02290: check constraint (WKSP_DBPRACTICELAMBTON.DH_REGIONS_PROVINCE_CK) violated