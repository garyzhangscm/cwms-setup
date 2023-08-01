 

DROP TABLE IF EXISTS role_client_access; 

CREATE TABLE role_client_access (
  role_client_access_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  role_id BIGINT NOT NULL,  
  client_id BIGINT  NOT NULL,      
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

