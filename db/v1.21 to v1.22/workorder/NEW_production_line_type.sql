 

DROP TABLE if exists production_line_type; 



CREATE TABLE production_line_type (
  production_line_type_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,
  name VARCHAR(50) , 
  description VARCHAR(500) , 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
   