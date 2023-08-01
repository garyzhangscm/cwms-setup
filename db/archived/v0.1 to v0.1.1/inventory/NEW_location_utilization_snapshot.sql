 

DROP TABLE IF EXISTS location_utilization_snapshot_detail; 
DROP TABLE IF EXISTS location_utilization_snapshot; 
DROP TABLE IF EXISTS client_location_utilization_snapshot_batch; 
DROP TABLE IF EXISTS location_utilization_snapshot_batch; 

CREATE TABLE location_utilization_snapshot_batch (
  location_utilization_snapshot_batch_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT not null,
  number VARCHAR(50), 
  net_volume double not null, 
  gross_volume double not null,
  total_locations INTEGER,
  start_time DATETIME,
  complete_time DATETIME,
  status VARCHAR(50),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

CREATE TABLE client_location_utilization_snapshot_batch (
  client_location_utilization_snapshot_batch_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  location_utilization_snapshot_batch_id BIGINT NOT NULL,
  warehouse_id BIGINT not null,
  client_id BIGINT,
  net_volume double not null, 
  gross_volume double not null,
  total_locations INTEGER,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(location_utilization_snapshot_batch_id) references location_utilization_snapshot_batch(location_utilization_snapshot_batch_id)
);


CREATE TABLE location_utilization_snapshot (
  location_utilization_snapshot_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  client_location_utilization_snapshot_batch_id BIGINT NOT NULL,
  warehouse_id BIGINT not null,
  item_id BIGINT not null,
  client_id BIGINT,
  net_volume double not null, 
  gross_volume double not null,
  total_locations INTEGER,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),  
  foreign key(item_id) references item(item_id),  
  foreign key(client_location_utilization_snapshot_batch_id) references client_location_utilization_snapshot_batch(client_location_utilization_snapshot_batch_id)
);

CREATE TABLE location_utilization_snapshot_detail (
  location_utilization_snapshot_detail_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  location_utilization_snapshot_id BIGINT not null, 
  net_volume double not null, 
  gross_volume double not null,
  location_id BIGINT,
  location_size DOUBLE,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),  
  foreign key(location_utilization_snapshot_id) references location_utilization_snapshot(location_utilization_snapshot_id)
);
