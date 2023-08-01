 

DROP TABLE IF EXISTS billable_activity; 

CREATE TABLE billable_activity (
  billable_activity_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT,
  warehouse_id BIGINT,
  client_id BIGINT,
  billable_category VARCHAR(50) NOT NULL,
  billable_activity_type_id BIGINT, 
  activity_time  datetime,
  amount double NOT NULL,
  rate double,
  total_charge double,
  document_number VARCHAR(500),
  item_name VARCHAR(100),
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
