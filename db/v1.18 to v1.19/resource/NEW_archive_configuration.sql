 

DROP TABLE if exists archive_configuration; 



CREATE TABLE archive_configuration (
  archive_configuration_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  inventory_archive_enabled   BOOLEAN,
  removed_inventory_archive_days   INTEGER,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
   