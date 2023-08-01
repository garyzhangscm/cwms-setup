DROP TABLE IF EXISTS tractor_schedule; 

CREATE TABLE tractor_schedule (
  tractor_schedule_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL,
  tractor_id BIGINT NOT NULL,   
  check_in_time DATETIME, 
  dispatch_time DATETIME,
  type VARCHAR(20) NOT NULL,
  comment   VARCHAR(2000),  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),  
  foreign key(tractor_id) references tractor(tractor_id)
);
 
