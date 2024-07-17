 

DROP TABLE IF EXISTS inbound_receiving_configuration; 

CREATE TABLE inbound_receiving_configuration (
  inbound_receiving_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  supplier_id BIGINT,
  item_family_id BIGINT,
  item_id BIGINT,
  warehouse_id BIGINT,
  company_id BIGINT NOT NULL,
  standard_pallet_size DOUBLE,
  estimate_pallet_count_by_size BOOLEAN,  
  estimate_pallet_count_by_receipt_line_cubic_meter BOOLEAN,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
