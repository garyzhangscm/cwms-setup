DROP TABLE if exists work_task_configuration; 



CREATE TABLE work_task_configuration (
  work_task_configuration_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  source_location_group_type_id   BIGINT ,   
  source_location_group_id   BIGINT , 
  source_location_id   BIGINT , 
  destination_location_group_type_id   BIGINT , 
  destination_location_group_id   BIGINT , 
  destination_location_id   BIGINT , 
  work_task_type VARCHAR(50) NOT NULL,
  operation_type_id VARCHAR(50) NOT NULL,
  priority INTEGER , 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
 