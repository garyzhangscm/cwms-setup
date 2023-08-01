 

DROP TABLE IF EXISTS rf_configuration; 

CREATE TABLE rf_configuration (
  rf_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  rf_code varchar(10),  
  work_order_validate_partial_lpn_pick bool not null, 
  work_order_pick_to_production_line_in_stage bool not null, 
  receiving_receive_to_stage bool not null, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

