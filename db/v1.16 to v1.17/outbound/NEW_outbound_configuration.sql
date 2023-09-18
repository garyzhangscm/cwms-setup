 

DROP TABLE if exists outbound_configuration; 



CREATE TABLE outbound_configuration (
  outbound_configuration_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  short_auto_reallocation   BOOLEAN,
  asynchronous_allocation   BOOLEAN, 
  asynchronous_allocation_pallet_threshold INTEGER , 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
   