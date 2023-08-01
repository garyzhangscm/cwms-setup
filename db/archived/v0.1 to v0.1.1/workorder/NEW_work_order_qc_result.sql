 

DROP TABLE IF EXISTS work_order_qc_result; 

CREATE TABLE work_order_qc_result (
  work_order_qc_result_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number VARCHAR(50) not null , 
  warehouse_id BIGINT not null , 
  work_order_qc_sample_id BIGINT NOT NULL, 
  qc_inspection_result VARCHAR(20),
  qc_username VARCHAR(200), 
  qc_rf_code VARCHAR(200), 
  qc_time datetime,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(work_order_qc_sample_id) references work_order_qc_sample(work_order_qc_sample_id)
);
 
