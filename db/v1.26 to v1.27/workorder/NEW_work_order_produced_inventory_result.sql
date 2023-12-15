DROP TABLE if exists work_order_produced_inventory_result; 



CREATE TABLE work_order_produced_inventory_result (
  work_order_produced_inventory_result_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  work_order_produced_inventory_id   BIGINT NOT NULL,   
  lpn VARCHAR(100)  NOT NULL,
  result BOOLEAN NOT NULL,
  error_message  VARCHAR(2000),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
 