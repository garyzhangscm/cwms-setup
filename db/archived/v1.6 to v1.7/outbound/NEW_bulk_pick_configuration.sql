DROP TABLE if exists bulk_pick_configuration; 



CREATE TABLE bulk_pick_configuration (
  bulk_pick_configuration_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  pick_sort_direction VARCHAR(50) ,
  enabled_for_outbound BOOLEAN NOT NULL,
  enabled_for_work_order BOOLEAN NOT NULL,
  release_to_work_task BOOLEAN NOT NULL,
  work_task_priority INTEGER,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
 