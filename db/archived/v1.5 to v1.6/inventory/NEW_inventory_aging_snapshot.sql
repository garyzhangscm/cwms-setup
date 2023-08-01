 

DROP TABLE IF EXISTS inventory_aging_snapshot_detail; 
DROP TABLE IF EXISTS client_inventory_aging_snapshot; 
DROP TABLE IF EXISTS inventory_aging_snapshot;  

CREATE TABLE inventory_aging_snapshot (
  inventory_aging_snapshot_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT not null,
  number VARCHAR(50), 
  start_time DATETIME,
  complete_time DATETIME,
  status VARCHAR(50),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

CREATE TABLE client_inventory_aging_snapshot (
  client_inventory_aging_snapshot_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  inventory_aging_snapshot_id BIGINT NOT NULL,
  warehouse_id BIGINT not null,
  client_id BIGINT,
  average_age_in_days BIGINT not null, 
  average_age_in_weeks BIGINT not null, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(inventory_aging_snapshot_id) references inventory_aging_snapshot(inventory_aging_snapshot_id)
);


CREATE TABLE inventory_aging_snapshot_detail (
  inventory_aging_snapshot_detail_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  client_inventory_aging_snapshot_id BIGINT NOT NULL, 
  inventory_id BIGINT not null,
  lpn VARCHAR(100) not null,
  client_id BIGINT,
  quantity BIGINT not null,
  age_in_days BIGINT not null DEFAULT 0,
  age_in_weeks BIGINT not null DEFAULT 0,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),   
  foreign key(client_inventory_aging_snapshot_id) references client_inventory_aging_snapshot(client_inventory_aging_snapshot_id)
);
 