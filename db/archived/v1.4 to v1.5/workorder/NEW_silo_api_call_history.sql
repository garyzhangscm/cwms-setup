 

DROP TABLE IF EXISTS silo_api_call_history; 

CREATE TABLE silo_api_call_history (
  silo_api_call_history_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL, 
  method VARCHAR(50) NOT NULL,
  parameters VARCHAR(500),
  response NVARCHAR(20000), 
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
