 

DROP TABLE IF EXISTS work_order_labor_activity_history; 

CREATE TABLE work_order_labor_activity_history (
  work_order_labor_activity_history_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id    BIGINT NOT NULL,
  work_order_labor_id    BIGINT NOT NULL,
  activity_type VARCHAR(50) not null , 
  username VARCHAR(100) not null , 
  original_value VARCHAR(100) , 
  new_value VARCHAR(100) , 
  activity_time datetime, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(work_order_labor_id) references work_order_labor(work_order_labor_id)
);
 
