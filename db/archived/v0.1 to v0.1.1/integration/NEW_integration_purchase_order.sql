 
DROP TABLE if exists integration_purchase_order_line;
DROP TABLE if exists integration_purchase_order;
    

CREATE TABLE integration_purchase_order (
  integration_purchase_order_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number   VARCHAR(100) NOT NULL,
  company_id BIGINT,
  company_code VARCHAR(100),
  warehouse_id BIGINT,
  warehouse_name VARCHAR(100),
  client_id   BIGINT,
  client_name   VARCHAR(100),
  supplier_id  BIGINT,
  supplier_name  VARCHAR(100),
  allow_unexpected_item boolean not null, 
  error_message VARCHAR(1000),
  status VARCHAR(10) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));

CREATE TABLE integration_purchase_order_line(
  integration_purchase_order_line_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number   VARCHAR(100) NOT NULL,
  company_id BIGINT,
  company_code VARCHAR(100),
  warehouse_id BIGINT,
  warehouse_name VARCHAR(100),
  item_id   BIGINT,
  item_name   VARCHAR(100),
  expected_quantity   BIGINT NOT NULL,
  integration_purchase_order_id BIGINT,  
  status VARCHAR(10) NOT NULL,
  error_message VARCHAR(1000),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(integration_purchase_order_id) references integration_purchase_order(integration_purchase_order_id));
 