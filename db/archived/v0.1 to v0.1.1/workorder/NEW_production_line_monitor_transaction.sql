 

DROP TABLE IF EXISTS production_line_monitor_transaction;  

CREATE TABLE production_line_monitor_transaction (
  production_line_monitor_transaction_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  warehouse_id BIGINT NOT NULL,
  production_line_monitor_id BIGINT NOT NULL, 
  production_line_id BIGINT, 
  cycle_time DOUBLE, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(production_line_monitor_id) references production_line_monitor(production_line_monitor_id),
  foreign key(production_line_id) references production_line(production_line_id)
);
  
 
