-- User

DROP TABLE IF EXISTS data_initial_request; 

CREATE TABLE data_initial_request (
  data_initial_request_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_name VARCHAR(100) NOT NULL,
  company_code VARCHAR(50),
  warehouse_name VARCHAR(100) NOT NULL,
  admin_username VARCHAR(50) NOT NULL,
  request_username VARCHAR(50) NOT NULL,
  status VARCHAR(50) NOT NULL,
  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
