 
DROP TABLE IF EXISTS abc_category; 

CREATE TABLE abc_category (
  abc_category_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  warehouse_id BIGINT NOT NULL,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(500) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
); 