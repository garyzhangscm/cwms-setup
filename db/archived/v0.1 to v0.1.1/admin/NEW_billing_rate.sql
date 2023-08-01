 

DROP TABLE IF EXISTS billing_rate; 

CREATE TABLE billing_rate (
  billing_rate_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT,
  warehouse_id BIGINT,
  client_id BIGINT,
  billable_category VARCHAR(50) NOT NULL,
  rate double not  null,
  billing_cycle VARCHAR(20) not null,
  enabled boolean not null,  
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
