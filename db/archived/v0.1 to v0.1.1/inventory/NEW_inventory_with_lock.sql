-- User

DROP TABLE IF EXISTS inventory_with_lock; 

CREATE TABLE inventory_with_lock (
  inventory_with_lock_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL,
  inventory_id BIGINT NOT NULL,
  inventory_lock_id BIGINT NOT NULL,
  comment VARCHAR(2000) not null,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(inventory_id) references inventory(inventory_id),
  foreign key(inventory_lock_id) references inventory_lock(inventory_lock_id)
);
 
