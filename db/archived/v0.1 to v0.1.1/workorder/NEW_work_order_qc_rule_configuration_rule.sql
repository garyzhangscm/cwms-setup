-- User

DROP TABLE IF EXISTS work_order_qc_rule_configuration_rule; 

CREATE TABLE work_order_qc_rule_configuration_rule (
  work_order_qc_rule_configuration_rule_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  qc_rule_id BIGINT NOT NULL, 
  work_order_qc_rule_configuration_id BIGINT  NOT NULL,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),  
  foreign key(work_order_qc_rule_configuration_id) references work_order_qc_rule_configuration(work_order_qc_rule_configuration_id)
);
  