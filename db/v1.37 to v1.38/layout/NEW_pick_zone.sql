 

DROP TABLE IF EXISTS pick_zone; 

CREATE TABLE pick_zone (
  pick_zone_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  warehouse_id BIGINT NOT NULL,  
  name VARCHAR(100) NOT NULL,  
  description VARCHAR(100) NOT NULL,  
  pickable BOOLEAN NOT NULL,  
  allow_cartonization BOOLEAN NOT NULL,    
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
