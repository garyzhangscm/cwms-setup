 

DROP TABLE IF EXISTS master_production_schedule_line; 

CREATE TABLE master_production_schedule_line (
  master_production_schedule_line_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  
  master_production_schedule_id BIGINT not null ,  
  planned_quantity BIGINT not null ,  
  production_line_id BIGINT not null ,   
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(master_production_schedule_id) references master_production_schedule(master_production_schedule_id)
);
 
