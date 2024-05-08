 

DROP TABLE IF EXISTS billing_rate_by_inventory_age; 

CREATE TABLE billing_rate_by_inventory_age (
  billing_rate_by_inventory_age_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT,
  warehouse_id BIGINT,
  client_id BIGINT,
  start_inventory_age INTEGER NOT NULL,
  end_inventory_age INTEGER not  null, 
  enabled boolean not null,  
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
