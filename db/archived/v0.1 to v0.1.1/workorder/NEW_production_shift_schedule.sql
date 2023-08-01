 
DROP TABLE IF EXISTS production_shift_schedule;   

CREATE TABLE production_shift_schedule (
  production_shift_schedule_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  warehouse_id BIGINT NOT NULL,
  shift_start_time TIME not null, 
  shift_end_time TIME not null,  
  shift_end_next_day BOOLEAN not null, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
  
 
