 

DROP TABLE IF EXISTS warehouse_configuration; 

CREATE TABLE warehouse_configuration (
  warehouse_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  three_party_logistics_flag boolean not null,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(warehouse_id) references warehouse(warehouse_id)
);

