 

DROP TABLE IF EXISTS billing_request; 

CREATE TABLE billing_request (
  billing_request_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT,
  warehouse_id BIGINT,
  client_id BIGINT,
  number VARCHAR(50) NOT NULL,
  billable_category VARCHAR(50) NOT NULL,
  rate double not  null,
  billing_cycle VARCHAR(20) not null,
  total_amount double,  
  total_charge double,  
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
