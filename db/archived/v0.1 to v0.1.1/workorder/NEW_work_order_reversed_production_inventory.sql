 

DROP TABLE IF EXISTS work_order_reversed_production_inventory; 

CREATE TABLE work_order_reversed_production_inventory (
  work_order_reversed_production_inventory_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  work_order_produce_transaction_id BIGINT NOT NULL, 
  lpn VARCHAR(50) not null , 
  quantity BIGINT not null , 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
  foreign key(work_order_produce_transaction_id) references work_order_produce_transaction(work_order_produce_transaction_id)
);
 
