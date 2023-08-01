


DROP TABLE IF EXISTS inbound_qc_configuration; 

CREATE TABLE inbound_qc_configuration (
  inbound_qc_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  supplier_id BIGINT,
  item_family_id BIGINT,
  item_id BIGINT,
  warehouse_id BIGINT,
  company_id BIGINT NOT NULL,
  qc_quantity_per_receipt BIGINT,
  qc_percentage double,  
  from_inventory_status_id BIGINT,
  to_inventory_status_id BIGINT NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
