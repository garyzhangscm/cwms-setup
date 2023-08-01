DROP TABLE if exists operation_type; 



CREATE TABLE operation_type (
  operation_type_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  name VARCHAR(50) NOT NULL,
  description VARCHAR(50) ,
  default_priority INTEGER, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
 