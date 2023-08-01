 

DROP TABLE IF EXISTS master_production_schedule; 

CREATE TABLE master_production_schedule (
  master_production_schedule_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number VARCHAR(50) not null , 
  description VARCHAR(2000), 
  warehouse_id BIGINT not null , 
  cutoff_date DATE NOT NULL, 
  item_id BIGINT not null , 
  total_quantity BIGINT not null ,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
