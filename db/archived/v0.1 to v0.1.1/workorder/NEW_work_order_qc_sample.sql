 

DROP TABLE IF EXISTS work_order_qc_sample; 

CREATE TABLE work_order_qc_sample (
  work_order_qc_sample_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number VARCHAR(50) not null , 
  warehouse_id BIGINT not null , 
  production_line_assignment_id BIGINT NOT NULL, 
  image_urls VARCHAR(2000),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),  
  foreign key(production_line_assignment_id) references production_line_assignment(production_line_assignment_id)
);
 
