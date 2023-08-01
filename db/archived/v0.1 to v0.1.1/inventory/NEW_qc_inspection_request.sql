 
DROP TABLE IF EXISTS qc_inspection_request; 

CREATE TABLE qc_inspection_request (
  qc_inspection_request_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  inventory_id BIGINT,
  qc_inspection_result VARCHAR(200),
  qc_username VARCHAR(200), 
  qc_time datetime,
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50),
  foreign key(inventory_id) references inventory(inventory_id)
);
 

ALTER TABLE qc_inspection_request ADD COLUMN number VARCHAR(25) not null;
ALTER TABLE qc_inspection_request ADD COLUMN warehouse_id BIGINT not null;
ALTER TABLE qc_inspection_request ADD COLUMN work_order_qc_sample_id BIGINT;
ALTER TABLE qc_inspection_request ADD COLUMN qc_rf_code VARCHAR(50);


  ALTER TABLE qc_inspection_request ADD COLUMN qc_quantity BIGINT;


 