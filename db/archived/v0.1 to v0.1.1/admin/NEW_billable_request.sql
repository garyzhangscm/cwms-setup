 

DROP TABLE IF EXISTS billable_request; 

CREATE TABLE billable_request (
  billable_request_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT,
  warehouse_id BIGINT,
  service_name VARCHAR(50) NOT NULL,
  web_api_endpoint VARCHAR(200) NOT NULL,
  request_method VARCHAR(50),
  request_parameters VARCHAR(2000),
  request_body VARCHAR(2000),
  username VARCHAR(50) NOT NULL,
  token VARCHAR(100) NOT NULL,
  transaction_id VARCHAR(50) NOT NULL,
  rate double not null,
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
