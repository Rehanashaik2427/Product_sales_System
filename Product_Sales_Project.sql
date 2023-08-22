CREATE DATABASE Product_Sales;
USE Product_Sales;

-- CREATE TABLE CUSTOMERS
DROP TABLE IF EXISTS `Customers`;
CREATE TABLE Customers (
    `customerId` INT UNSIGNED NOT NULL AUTO_INCREMENT,`companyName` VARCHAR(255),`contactName` VARCHAR(255),`contactJobtitle` VARCHAR(255),
	`officePhone` VARCHAR(255) NOT NULL,`mobilePhone` VARCHAR(255),`fax` VARCHAR(255),`email` VARCHAR(255),
    `address` VARCHAR(255),`city` VARCHAR(255),`state` VARCHAR(255),`country` VARCHAR(255),`postalCode` INT,
    `salesRepId` INT,`creditlimit` INT,`homepage` VARCHAR(255),
    PRIMARY KEY (`customerId`)
);
DESC Customers;
SHOW CREATE TABLE Customers; 
SHOW INDEX FROM Customers ;

-- insert values into customers
INSERT INTO Customers (`companyName`,`contactName`,`contactJobtitle`,`officePhone`,`mobilePhone`,`fax`,`email`,`address`,`city`,`state`,
`country`,`postalCode`,`salesRepId`,`creditlimit`,`homepage`) VALUES
    ('ABC Corporation', 'John Smith', 'CEO', '123-456-7890', '987-654-3210', '555-123-4567', 'john@example.com', '123 Main St', 'Anytown', 'CA', 'USA', 12345, 101, 10000, 'http://www.abccorp.com'),
    ('XYZ Enterprises', 'Jane Doe', 'CFO', '111-222-3333', '555-555-5555', '555-987-6543', 'jane@example.com', '456 Elm St', 'Somewhere', 'NY', 'USA', 54321, 102, 15000, 'http://www.xyzent.com'),
    ('123 Industries', 'Michael Johnson', 'COO', '444-555-6666', '666-666-6666', '555-789-1234', 'michael@example.com', '789 Oak Ave', 'Everyville', 'TX', 'USA', 67890, 103, 12000, 'http://www.123industries.com'),
    ('Tech Solutions Ltd.', 'Emily Brown', 'CTO', '777-888-9999', '888-888-8888', '555-234-5678', 'emily@example.com', '987 Maple Rd', 'Techville', 'CA', 'USA', 43210, 104, 8000, 'http://www.techsolutions.com'),
    ('Global Innovators', 'David Lee', 'VP of Sales', '222-333-4444', '999-999-9999', '555-345-6789', 'david@example.com', '567 Pine Blvd', 'Innovation City', 'IL', 'USA', 87654, 105, 20000, 'http://www.globalinnovators.com');
SELECT *FROM Customers;

-- EMPLOYEES TABLE
DROP TABLE IF EXISTS `Employees`;
CREATE TABLE Employees (
    employeeid INT UNSIGNED NOT NULL AUTO_INCREMENT,lastname VARCHAR(255),firstName VARCHAR(255),jobTitle VARCHAR(255),
    reportsTo INT UNSIGNED, -- Use INT for foreign key reference
    officePhone VARCHAR(255),mobilePhone VARCHAR(255),email VARCHAR(255), -- Typo: should be `email`
    address VARCHAR(255),city VARCHAR(255),state VARCHAR(255),country VARCHAR(255),postalCode INT,
    homePhone VARCHAR(255),photo BLOB,
    PRIMARY KEY (`employeeid`),
    FOREIGN KEY (`reportsTo`) REFERENCES `employees` (`employeeid`)ON DELETE RESTRICT ON UPDATE CASCADE
);

DESC Employees;
SHOW CREATE TABLE Employees;
SHOW INDEX FROM Employees;
-- INSERT  VALUES
-- Insert values into the employees table
INSERT INTO Employees(`lastname`,`firstName`,`jobTitle`,`reportsTo`,`officePhone`,`mobilePhone`,`email`,`address`,`city`,`state`,`country`,
`postalCode`,`homePhone`,`photo`) VALUES
    ('Doe', 'John', 'Manager', NULL, '123-456-7890', '987-654-3210', 'john@example.com', '123 Main St', 'Anytown', 'CA', 'USA', 12345, '555-789-1234', NULL),
    ('Smith', 'Jane', 'Assistant Manager', 1, '111-222-3333', '555-555-5555', 'jane@example.com', '456 Elm St', 'Somewhere', 'NY', 'USA', 54321, '555-987-6543', NULL),
    ('Doe', 'James', 'Supervisor', 1, '222-333-4444', '666-666-6666', 'james@example.com', '789 Oak St', 'Cityville', 'TX', 'USA', 78901, '555-444-3333', NULL),
    ('Johnson', 'Emily', 'Coordinator', 2, '444-555-6666', '777-777-7777', 'emily@example.com', '890 Maple Ave', 'Townville', 'IL', 'USA', 89012, '555-555-5555', NULL),
    ('Brown', 'David', 'Analyst', 1, '555-666-7777', '888-888-8888', 'david@example.com', '567 Pine Rd', 'Villageville', 'CA', 'USA', 56789, '555-666-7777', NULL);
SELECT *FROM employees ;

-- CREATE SHIPPERS TABLE
CREATE TABLE SHIPPERS (
    shipperId INT  AUTO_INCREMENT,companyName VARCHAR(255),contactName VARCHAR(255),contactPhone VARCHAR(255),
    PRIMARY KEY (`shipperId`)
);
DESC SHIPPERS ;
SHOW CREATE TABLE SHIPPERS;
SHOW INDEX FROM SHIPPERS;

-- INSERT VALUES
INSERT INTO SHIPPERS (`companyName`,`contactName`,`contactPhone`) VALUES
    ('ShipCo', 'John Smith', '123-456-7890'),
    ('Fast Shipping', 'Jane Doe', '111-222-3333'),
    ('Express Logistics', 'Michael Johnson', '444-555-6666'),
    ('Global Freight', 'Emily Brown', '777-888-9999'),
    ('Swift Transports', 'David Lee', '555-444-3333');
SELECT *FROM SHIPPERS;

-- CREATE ORDERS TABLE
CREATE TABLE ORDERS (
    orderId INT  AUTO_INCREMENT,customerId INT UNSIGNED,employeeId INT UNSIGNED,
    orderedDate DATE,requiredDate DATE,orderStatus VARCHAR(255),
    shippedDate DATE,shipperId INT,shipToName VARCHAR(255),shipToAddress VARCHAR(255),shipToCity VARCHAR(255),shipToCountry VARCHAR(255),shipToPostalCode INT,
    PRIMARY KEY (`orderId`),
    FOREIGN KEY (`customerId`) REFERENCES `Customers` (`customerId`) ,
    FOREIGN KEY (`employeeId`) REFERENCES `employees` (`employeeId`),
    FOREIGN KEY (`shipperId`) REFERENCES `SHIPPERS` (`shipperId`)
);
DESC ORDERS ;
SHOW CREATE TABLE ORDERS;
SHOW INDEX FROM ORDERS;

-- insert values into orders
INSERT INTO ORDERS (
    customerId, employeeId, orderedDate, requiredDate, orderStatus,
    shippedDate, shipperId, shipToName, shipToAddress, shipToCity, shipToCountry, shipToPostalCode
) VALUES
    (1, 1, '2023-08-20', '2023-08-30', 'Pending', '2023-08-25', 1, 'John Doe', '123 Main St', 'Anytown', 'USA', 12345),
    (2, 2, '2023-08-21', '2023-08-31', 'Processing', '2023-08-26', 2, 'Jane Smith', '456 Elm St', 'Somewhere', 'USA', 54321),
    (4, 4, '2023-08-23', '2023-09-02', 'Delivered', '2023-08-28', 4, 'Emily Brown', '987 Maple Rd', 'Techville', 'USA', 43210),
    (5, 5, '2023-08-24', '2023-09-03', 'Pending', NULL, NULL, 'David Lee', '567 Pine Blvd', 'Innovation City', 'USA', 87654),
    (3, 3, '2023-08-22', '2023-09-01', 'Shipped', '2023-08-27', 3, 'Michael Johnson', '789 Oak Ave', 'Everyville', 'USA', 67890);
SELECT *FROM ORDERS;

-- create PRODUCTS table
drop table if exists `products`;
CREATE TABLE products (
    productCode INT PRIMARY KEY,name VARCHAR(255),description TEXT,
    suggestedUnitPrice DECIMAL(10, 2),buyUnitPrice DECIMAL(10, 2),
    unitsInStock INT,unitsOnOrder INT,recorderLevel INT,supplierId INT
);
 DESC products;
 SHOW CREATE TABLE products; 
SHOW INDEX FROM  products ;

-- INSERT VALUES INTO PRODUCTS TABLE
INSERT INTO products (
    `productCode`,`name`,`description`,`suggestedUnitPrice`,`buyUnitPrice`,
    `unitsInStock`,`unitsOnOrder`,`recorderLevel`,`supplierId`
) VALUES	
	    (201, 'Laptop  ', 'Powerful laptop with high performance features.', 899.99, 750.00, 100, 5, 15, 4),
		(202, 'Refrigerator  ', 'Large capacity fridge with advanced cooling technology.', 1299.99, 1100.00, 50, 2, 10, 5),
		(204, 'Classic Watch', 'Elegant wristwatch with timeless design.', 199.99, 150.00, 100, 10, 20, 7),
		(205, 'Coffee Grinder', 'Versatile grinder for coffee beans and spices.', 49.99, 40.00, 25, 5, 10, 8),
		(203, 'Television ', 'High-definition TV with smart features and large screen.', 799.99, 700.00, 30, 3, 8, 6);
SELECT * FROM  products;


-- PRODUCTDETAILS

CREATE TABLE PRODUCTDETAILS (
    productCode INT PRIMARY KEY ,moreDescription TEXT,image Blob,comment TEXT,htmlDescription TEXT,
    FOREIGN KEY (`productCode`) REFERENCES `PRODUCTS` (`productCode`)ON DELETE RESTRICT ON UPDATE CASCADE
);
DESC PRODUCTDETAILS;
 SHOW CREATE TABLE PRODUCTDETAILS; 
SHOW INDEX FROM PRODUCTDETAILS ;
truncate table productdetails;
-- INSERT VALUES INTO PRODUCTDETAILS TABLE
INSERT INTO PRODUCTDETAILS (`productCode`, `moreDescription`, `image`, `comment`, `htmlDescription`) VALUES
    (201, 'laptop is worthable and its working also good and it is very useful nowadays', 'https://images.unsplash.com/photo-1618424181497-157f25b6ddd5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bGFwdG9wJTIwY29tcHV0ZXJ8ZW58MHx8MHx8fDA%3D&w=1000&q=80', 
    'Laptop comment', '<p>HTML description for Laptop</p>'),
    (202, ' A refrigerator is a household appliance that is used to store and preserve perishable food items', 
    'data:image/jpeg;base64,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', 
    'Refrigerator comment', '<p>HTML description for Refrigerator</p>'),
    (204, 'A classic watch is a timeless and elegant accessory that serves both as a functional timekeeping device and a stylish fashion statement', 
    'watch_image.jpg', 'Watch comment', '<p>HTML description for Classic Watch</p>'),
    (205, 'A coffee grinder is a kitchen appliance designed to grind coffee beans into various levels of coarseness, allowing you to brew fresh coffee with optimal flavor and aroma', 
    'grinder_image.jpg', 'Grinder comment', '<p>HTML description for Coffee Grinder</p>'),
    (203, 'A television is a technological marvel that brings audiovisual content into our lives', '
    tv_image.jpg', 'Television comment', '<p>HTML description for Television</p>');
select *from PRODUCTDETAILS;



-- create table suuplies
CREATE TABLE supplies (
    supplierId INT auto_increment,companyName VARCHAR(255),contactName VARCHAR(255),contactJobTitle VARCHAR(255),
    phoneOffice VARCHAR(255),phoneMobile VARCHAR(255),fax VARCHAR(255),email VARCHAR(255),
    address VARCHAR(255),city VARCHAR(255),country VARCHAR(255),postalCode VARCHAR(255),homepage VARCHAR(255),
    PRIMARY KEY (supplierId)
);
drop table supplies;
DESC supplies;
 SHOW CREATE TABLE supplies; 
SHOW INDEX FROM supplies ;

-- insert values

INSERT INTO supplies (
    companyName, contactName, contactJobTitle,phoneOffice, phoneMobile, fax, email,address, city, country, postalCode, homepage
) VALUES
    ('ABC Suppliers', 'John Smith', 'CEO', '123-456-7890', '987-654-3210', '555-123-4567', 'john@example.com', 
    '123 Main St', 'Anytown', 'USA', '12345', 'http://www.abcsuppliers.com'),
    
    ('XYZ Enterprises', 'Jane Doe', 'Sales Manager', '111-222-3333', '555-555-5555', '555-987-6543', 'jane@example.com', 
    '456 Elm St', 'Somewhere', 'USA', '54321', 'http://www.xyzenterprises.com'),
    
    ('123 Industries', 'Michael Johnson', 'Product Manager', '444-555-6666', '666-666-6666', '555-789-1234', 'michael@example.com', 
    '789 Oak Ave', 'Everyville', 'USA', '67890', 'http://www.123industries.com'),
    
    ('Tech Solutions Ltd.', 'Emily Brown', 'CTO', '777-888-9999', '888-888-8888', '555-234-5678', 'emily@example.com', 
    '987 Maple Rd', 'Techville', 'USA', '43210', 'http://www.techsolutions.com'),
    
    ('Global Innovators', 'David Lee', 'VP of Sales', '222-333-4444', '999-999-9999', '555-345-6789', 'david@example.com', 
    '567 Pine Blvd', 'Innovation City', 'USA', '87654', 'http://www.globalinnovators.com');

SELECT *FROM supplies;

-- create table 
CREATE TABLE ProductSupplier (
    productCode INT,supplierId INT,notes TEXT,
    FOREIGN KEY (productCode) REFERENCES products(productCode) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (supplierId) REFERENCES supplies(supplierId) ON DELETE RESTRICT ON UPDATE CASCADE
);
DESC ProductSupplier;
 SHOW CREATE TABLE ProductSupplier; 
SHOW INDEX FROM ProductSupplier ;
-- insert values  ProductSupplier
INSERT INTO ProductSupplier (productCode, supplierId, notes)
VALUES
    (201, 1, 'High-quality laptops supplier'),
    (202, 2, 'Refrigerator supplier for home appliances'),
    (203, 3, 'Television supplier with various models'),
    (204, 4, 'Watch manufacturer for classic designs'),
    (205, 5, 'Supplier of coffee grinders for kitchen appliances');

SELECT * FROM ProductSupplier;

DROP TABLE IF EXISTS OrderLines;
CREATE TABLE OrderLines (
    orderId INT ,
     productCode INT, -- Match data type with products table
    quantity INT,
    unitPrice DECIMAL(10, 2),
    lineNumber INT,
    PRIMARY KEY (orderId,productCode ),
    FOREIGN KEY (orderId) REFERENCES ORDERS (orderId),
    FOREIGN KEY (productCode) REFERENCES products (productCode) -- Reference products table
);

DESC OrderLines;
SHOW CREATE TABLE OrderLines; 
SHOW INDEX FROM OrderLines ;
INSERT INTO OrderLines (orderId, productCode, quantity, unitPrice, lineNumber)VALUES
    (1, 201, 5, 20.00, 1),
    (2, 202, 3, 15.50, 1),
    (4, 204, 2, 12.75, 1),
    (5, 205, 4, 18.25, 2),
    (3, 203, 1, 25.00, 1);
SELECT *FROM OrderLines;


-- CREATE TABLE INVOICES
DROP TABLE IF EXISTS Invoices;
CREATE TABLE Invoices (
    invoiceId INT UNSIGNED NOT NULL AUTO_INCREMENT,
    orderId INT,
    invoiceDate DATE,
    invoiceStatus VARCHAR(255),
    PRIMARY KEY (invoiceId),
    FOREIGN KEY (orderId) REFERENCES ORDERS (orderId)
);
DESC Invoices;
SHOW CREATE TABLE Invoices; 
SHOW INDEX FROM Invoices;
INSERT INTO Invoices (orderId, invoiceDate, invoiceStatus)
VALUES
    (1, '2023-08-15', 'Paid'),
    (2, '2023-08-16', 'Pending'),
    (4, '2023-08-17', 'Paid'),
    (5, '2023-08-18', 'Pending'),
    (3, '2023-08-19', 'Paid');
SELECT *FROM Invoices;

DROP TABLE IF EXISTS InvoiceLines;
CREATE TABLE InvoiceLines (
    invoiceId INT UNSIGNED,productCode INT,unitPrice DECIMAL(10, 2),unitsShipped INT,lineNumber INT,
    PRIMARY KEY (invoiceId, productCode),
    FOREIGN KEY (invoiceId) REFERENCES Invoices (invoiceId),
    FOREIGN KEY (productCode) REFERENCES products (productCode)
);
DESC InvoiceLines;
SHOW CREATE TABLE InvoiceLines; 
SHOW INDEX FROM InvoiceLines;

-- insert values
INSERT INTO InvoiceLines (invoiceId, productCode, unitPrice, unitsShipped, lineNumber)
VALUES
    (1, 201, 20.00, 5, 1),
    (2, 202, 15.50, 3, 2),
    (3, 204, 12.75, 2, 1),
    (4, 205, 18.25, 4, 1),
    (5, 203, 25.00, 1, 1);

SELECT *FROM InvoiceLines;

-- create table payments
DROP TABLE IF EXISTS Payments;
CREATE TABLE Payments (
    orderId INT ,paymentDate DATE,amount DECIMAL(10, 2),checkNumber VARCHAR(255),
    PRIMARY KEY (orderId),
    FOREIGN KEY (orderId) REFERENCES ORDERS (orderId)
);
DESC Payments ;
SHOW CREATE TABLE Payments; 
SHOW INDEX FROM Payments;

-- insert values into Payments
INSERT INTO Payments (orderId, paymentDate, amount, checkNumber)
VALUES
    (1, '2023-08-15', 100.00, 'CHK12345'),
    (2, '2023-08-16', 75.50, 'CHK67890'),
    (4, '2023-08-17', 120.25, 'CHK54321'),
    (5, '2023-08-18', 90.75, 'CHK98765'),
    (3, '2023-08-19', 50.00, 'CHK24680');
    
SELECT *FROM Payments;