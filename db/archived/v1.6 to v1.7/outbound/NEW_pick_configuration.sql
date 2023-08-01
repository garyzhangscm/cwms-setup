DROP TABLE if exists pick_configuration; 



CREATE TABLE pick_configuration (
  pick_configuration_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,    
  release_to_work_task BOOLEAN NOT NULL,
  work_task_priority INTEGER,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
 