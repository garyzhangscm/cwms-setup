 
DROP TABLE IF EXISTS qc_inspection_request_inventory; 


CREATE TABLE qc_inspection_request_inventory (
  inventory_id    BIGINT NOT NULL,
  qc_inspection_request_id    BIGINT NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(qc_inspection_request_id) references qc_inspection_request(qc_inspection_request_id),
  foreign key(inventory_id) references inventory(inventory_id)
);
