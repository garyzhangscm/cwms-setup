 

DROP TABLE IF EXISTS master_production_schedule_line_date; 

CREATE TABLE master_production_schedule_line_date (
  master_production_schedule_line_date_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  master_production_schedule_line_id BIGINT not null ,  
  planned_quantity BIGINT not null ,  
  planned_date DATE not null ,   
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(master_production_schedule_line_id) references master_production_schedule_line(master_production_schedule_line_id)
);
 
