 

DROP TABLE if exists light_mes_configuration; 



CREATE TABLE light_mes_configuration (
  light_mes_configuration_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,
  protocol VARCHAR(10) , 
  host VARCHAR(100) , 
  port VARCHAR(10) ,   
  access_key_id VARCHAR(50) , 
  access_key_secret VARCHAR(50) ,   
  single_light_status_query_url VARCHAR(500) , 
  batch_light_status_query_url VARCHAR(500) , 
  single_light_pulse_query_url VARCHAR(500) , 
  single_machine_detail_query_url VARCHAR(500) , 
  machine_list_query_url VARCHAR(500) ,  
  time_zone VARCHAR(100) , 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
   