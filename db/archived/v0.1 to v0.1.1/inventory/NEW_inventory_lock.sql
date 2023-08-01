-- User

DROP TABLE IF EXISTS inventory_lock; 

CREATE TABLE inventory_lock (
  inventory_lock_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL,
  name VARCHAR(50) not null,
  description VARCHAR(1000), 
  allow_pick boolean not null,
  allow_ship boolean not null,
  enabled boolean not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
