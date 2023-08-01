 

DROP TABLE IF EXISTS work_order_labor; 

CREATE TABLE work_order_labor (
  work_order_labor_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id    BIGINT NOT NULL,
  production_line_id    BIGINT NOT NULL,
  username VARCHAR(50) not null , 
  last_check_in_time datetime, 
  last_check_out_time datetime, 
  labor_status VARCHAR(20),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(production_line_id) references production_line(production_line_id)
);
 
