-- Drop table Stock;
-- Drop table Depot;
-- Drop table product;

CREATE table product
(
    prod_id char(10),
    pname VARCHAR(30),
    price numeric

);

 Alter table Product add constraint pk_product primary key (prod_id);
 Alter table Product add constraint ck_product_price check (price > 0);

INSERT INTO product VALUES('p1','tape','2.5'),('p2','tv','250'),('p3','vcr','80');


CREATE table Depot
(
    dep_id CHAR(10),
    addr VARCHAR(30),
    volume INTEGER

);
    Alter table Depot add constraint pk_depot primary key (dep_id);
    Alter table Depot add constraint ck_depot_volume check (volume >= 0);
   
   

INSERT INTO Depot VALUES('d1','New York','900'),('d2','Syracuse','6000'),('d4','New York','2000');


CREATE table Stock
(
    prod_id character(10),
    dep_id character(10),
    quantity int
);
    Alter table Stock add constraint pk_stock primary key (prod_id,dep_id);
    Alter table Stock add constraint cons 
        FOREIGN KEY (prod_id) REFERENCES product (prod_id);
    Alter table Stock add constraint cons_dep 
        FOREIGN KEY (dep_id) REFERENCES Depot (dep_id);


INSERT INTO Stock VALUES('p1','d1','1000'),('p1','d2','-100'),('p1','d4','1200'),('p3','d1','3000'),('p3','d4','2000'),('p2','d4','1500'),('p2','d1','-400'),('p2','d2','2000');

-- INSERT INTO Stock VALUES ('p17', 'd1', '1000');