 

DROP TABLE IF EXISTS work_order_line_consume_lpn_transaction; 

CREATE TABLE work_order_line_consume_lpn_transaction (
  work_order_line_consume_lpn_transaction_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  work_order_line_consume_transaction_id BIGINT NOT NULL,
  lpn VARCHAR(100),
  quantity BIGINT not null , 
  consumed_quantity BIGINT not null , 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
  foreign key(work_order_line_consume_transaction_id) references work_order_line_consume_transaction(work_order_line_consume_transaction_id)
);
 
