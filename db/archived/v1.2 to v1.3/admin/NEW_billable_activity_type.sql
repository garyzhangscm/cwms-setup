 

DROP TABLE IF EXISTS billable_activity_type; 

CREATE TABLE billable_activity_type (
  billable_activity_type_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL, 
  name VARCHAR(50) NOT NULL,  
  description VARCHAR(2000),   
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
