CREATE TABLE Product (
	productId int NOT NULL,
	productName varchar(50),
	categoryName varchar(50),
	packageDesc varchar(50),
	price decimal(9,2),
	PRIMARY KEY (ProductId)
);

CREATE TABLE Customer (
	customerId int NOT NULL PRIMARY KEY,
	password VARCHAR(20) NOT NULL,
	cname VARCHAR(50) NOT NULL,
	street VARCHAR(50),
	city VARCHAR(20),
	state VARCHAR(2),
	zipcode VARCHAR(10),
	phone VARCHAR(10),
	email VARCHAR(30) NOT NULL
);

CREATE TABLE Orders (
	orderId int NOT NULL PRIMARY KEY,
	customerId int,
	totalAmount decimal(9,2),
	CONSTRAINT FK_Orders_Customer FOREIGN KEY (customerId) REFERENCES Customer(customerId)
);

CREATE TABLE OrderedProduct (
	orderId int NOT NULL,
	productId int NOT NULL,
	quantity int,
	price decimal(9,2),
	PRIMARY KEY (OrderId, ProductId),
	CONSTRAINT FK_OrderedProduct_Order FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
	CONSTRAINT FK_OrderedProduct_Product FOREIGN KEY (ProductId) REFERENCES Product (ProductId)
);

INSERT INTO Product(productId,productName,categoryName,packageDesc,price)
	VALUES(1234,'Power Bank','Battery','Box',799.00),(4444,'IPhone','Mobile','Box',80099.00);

INSERT INTO Product(productId,productName,categoryName,packageDesc,price)
	VALUES(9876,'Power Adapter','Electro','Box',999.00),(5544,'RPi','Microcontroller','Box',4099.00);


INSERT INTO Customer(customerId,password,cname,street,city,state,zipcode,phone,email)
	VALUES(54,'happy','Robert Brown','Downing Street','London','UK','123456','9876543210','brown@gmail.com');

INSERT INTO Customer(customerId,password,cname,street,city,state,zipcode,phone,email)
	VALUES(46,'delight','TS Eliot','Dalal Street','Mumbai','MH','897651','9787654490','ts@yahoo.com');


INSERT INTO Orders(orderId,customerId,totalAmount)
	VALUES(125,54,0),(101,46,0);

INSERT INTO OrderedProduct(orderId,productId,quantity,price)
	VALUES(125,4444,0,80099.00),(101,1234,0,799.00);

/*3.1*/
DELIMITER $$
CREATE TRIGGER OrderedProduct_trigger
AFTER UPDATE ON OrderedProduct FOR EACH ROW
BEGIN
       UPDATE Orders
       SET totalAmount=NEW.price*NEW.quantity
       WHERE orderId=NEW.orderId;
END;
$$
DELIMITER ;

UPDATE OrderedProduct
	SET quantity=10,price=80099.00
	WHERE orderId=125 AND productId=4444;

UPDATE OrderedProduct
	SET quantity=5,price=700.00
	WHERE orderId=101 AND productId=1234;

/*3.2*/
DELIMITER $$
CREATE TRIGGER Orders_trigger
BEFORE DELETE ON Customer FOR EACH ROW
BEGIN
       DELETE FROM Orders
       WHERE customerId=OLD.customerId;
END;
$$
DELIMITER ;

/*3.2*/
DELIMITER $$
CREATE TRIGGER OrderedProduct_delete_trigger
BEFORE DELETE ON Orders FOR EACH ROW
BEGIN
       DELETE FROM OrderedProduct
       WHERE orderId=OLD.orderId;
END;
$$
DELIMITER ;

DELETE FROM Customer
	WHERE customerId=54;
