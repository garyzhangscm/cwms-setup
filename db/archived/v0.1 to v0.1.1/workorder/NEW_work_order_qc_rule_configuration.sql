-- User

DROP TABLE IF EXISTS work_order_qc_rule_configuration; 

CREATE TABLE work_order_qc_rule_configuration (
  work_order_qc_rule_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  warehouse_id BIGINT NOT NULL, 
  production_line_id BIGINT, 
  work_order_id BIGINT, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),  
  foreign key(work_order_id) references work_order(work_order_id),
  foreign key(production_line_id) references production_line(production_line_id)
);
  
  
  ALTER TABLE work_order_qc_rule_configuration ADD COLUMN qc_quantity BIGINT;