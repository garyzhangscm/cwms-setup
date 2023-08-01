


DROP TABLE IF EXISTS unit; 

CREATE TABLE unit (
  unit_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  type   VARCHAR(20) NOT NULL,
  name   VARCHAR(50), 
  description   VARCHAR(100), 
  ratio double,
  base_unit_flag boolean, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
