 

DROP TABLE IF EXISTS list_pick_configuration; 

CREATE TABLE list_pick_configuration (
  list_pick_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  sequence BIGINT NOT NULL,  
  warehouse_id BIGINT NOT NULL,
  client_id BIGINT,
  customer_id BIGINT,
  pick_type VARCHAR(50) NOT NULL,
  enabled BOOLEAN NOT NULL,
  max_volume DOUBLE,
  max_weight DOUBLE,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

