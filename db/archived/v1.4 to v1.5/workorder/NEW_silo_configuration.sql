 

DROP TABLE IF EXISTS silo_configuration; 

CREATE TABLE silo_configuration (
  silo_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL, 
  web_api_protocol VARCHAR(50) NOT NULL,
  web_api_url VARCHAR(200) NOT NULL,
  web_api_username VARCHAR(100) NOT NULL,
  web_api_password VARCHAR(100) NOT NULL, 
  enabled BOOLEAN NOT NULL, 
  inventory_information_from_wms BOOLEAN not NULL,
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
