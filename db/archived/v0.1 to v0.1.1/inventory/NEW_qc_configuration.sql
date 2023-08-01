 
DROP TABLE IF EXISTS qc_configuration; 

CREATE TABLE qc_configuration (
  qc_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  warehouse_id BIGINT NOT NULL,
  qc_pass_inventory_status_id BIGINT NOT NULL,
  qc_fail_inventory_status_id BIGINT NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(qc_pass_inventory_status_id) references inventory_status(inventory_status_id),
  foreign key(qc_fail_inventory_status_id) references inventory_status(inventory_status_id)
); 