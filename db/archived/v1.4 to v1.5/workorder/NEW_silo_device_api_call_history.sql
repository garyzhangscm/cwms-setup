 

DROP TABLE IF EXISTS silo_device_api_call_history; 

CREATE TABLE silo_device_api_call_history (
  silo_device_api_call_history_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL, 
  web_api_call_timestamp BIGINT NOT NULL,
  location_name VARCHAR(200) ,
  name VARCHAR(200) ,
  device_id BIGINT ,  
  material VARCHAR(200) ,
  item_name VARCHAR(200),
  distance DOUBLE,
  timestamp BIGINT,
  status_code VARCHAR(200) ,
  token VARCHAR(300) , 
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
