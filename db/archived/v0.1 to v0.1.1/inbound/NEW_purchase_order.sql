DROP TABLE if exists purchase_order_line;
drop table if exists purchase_order;



CREATE TABLE purchase_order (
  purchase_order_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number   VARCHAR(100) NOT NULL,
  client_id   BIGINT,
  warehouse_id   BIGINT,
  status   VARCHAR(20) not null,
  supplier_id   BIGINT, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));

CREATE TABLE purchase_order_line(
  purchase_order_line_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number   VARCHAR(100) NOT NULL,
  item_id BIGINT,
  warehouse_id   BIGINT,
  expected_quantity   BIGINT NOT NULL, 
  received_quantity   BIGINT NOT NULL,
  purchase_order_id BIGINT NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(purchase_order_id) references purchase_order(purchase_order_id));

ALTER TABLE receipt ADD COLUMN purchase_order_id  BIGINT;
ALTER TABLE receipt ADD FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(purchase_order_id) ;


ALTER TABLE purchase_order_line ADD COLUMN receipt_quantity  BIGINT  NOT NULL;

 

ALTER TABLE receipt_line ADD COLUMN purchase_order_line_id  BIGINT;
ALTER TABLE receipt_line ADD FOREIGN KEY (purchase_order_line_id) REFERENCES purchase_order_line(purchase_order_line_id) ;