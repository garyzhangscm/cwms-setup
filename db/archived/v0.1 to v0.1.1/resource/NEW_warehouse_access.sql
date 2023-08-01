 

DROP TABLE IF EXISTS warehouse_access; 

CREATE TABLE warehouse_access (
  warehouse_access_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,    
  user_id BIGINT NOT NULL,   
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(user_id) references user_info(user_id)
);

