


DROP TABLE IF EXISTS customer_return_order_line; 
DROP TABLE IF EXISTS customer_return_order; 

CREATE TABLE customer_return_order (
  customer_return_order_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number   VARCHAR(100) NOT NULL,
  client_id   BIGINT,
  warehouse_id   BIGINT,
  rma_number VARCHAR(100),
  tracking_number VARCHAR(100),
  customer_id BIGINT,
  category VARCHAR(20), 
  status  VARCHAR(20), 
  allow_unexpected_item boolean not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
  );

CREATE TABLE customer_return_order_line(
  customer_return_order_line_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number   VARCHAR(100) NOT NULL,
  item_id BIGINT,
  warehouse_id   BIGINT,
  expected_quantity   BIGINT NOT NULL,
  received_quantity   BIGINT NOT NULL,
  customer_return_order_id BIGINT,
  over_receiving_quantity  BIGINT NOT NULL,
  over_receiving_percent  DOUBLE NOT NULL,  
  qc_quantity  bigint NOT NULL,
  qc_percentage  DOUBLE NOT NULL,
  qc_quantity_requested  bigint NOT NULL,
  outbound_order_line_id  bigint,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(customer_return_order_id) references customer_return_order(customer_return_order_id));