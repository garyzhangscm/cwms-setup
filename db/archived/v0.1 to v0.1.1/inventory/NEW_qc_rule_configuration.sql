-- User

DROP TABLE IF EXISTS qc_rule_configuration; 

CREATE TABLE qc_rule_configuration (
  qc_rule_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  warehouse_id BIGINT NOT NULL,
  item_id BIGINT, 
  inventory_status_id BIGINT,
  supplier_id BIGINT,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
alter table qc_rule_configuration ADD COLUMN item_family_id  BIGINT;
alter table qc_rule_configuration ADD COLUMN sequence  BIGINT not null;