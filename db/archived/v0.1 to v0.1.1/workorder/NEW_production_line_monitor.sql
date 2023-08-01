 
DROP TABLE IF EXISTS production_line_monitor_transaction;  
DROP TABLE IF EXISTS production_line_monitor;  

CREATE TABLE production_line_monitor (
  production_line_monitor_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  warehouse_id BIGINT NOT NULL,
  name VARCHAR(50) not null, 
  description VARCHAR(500), 
  production_line_id BIGINT, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(production_line_id) references production_line(production_line_id)
);
  
 
