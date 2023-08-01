-- User

DROP TABLE IF EXISTS data_transfer_request; 

CREATE TABLE data_transfer_request (
  data_transfer_request_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,
  number VARCHAR(50) not null,
  description VARCHAR(100),
  status VARCHAR(50) NOT NULL,
  type VARCHAR(50) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
