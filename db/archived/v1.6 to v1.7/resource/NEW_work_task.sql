DROP TABLE if exists work_task; 



CREATE TABLE work_task (
  work_task_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  number  VARCHAR(100)  NOT NULL, 
  type   VARCHAR(100)  NOT NULL,   
  status VARCHAR(100)   NOT NULL,  
  priority INTEGER,  
  skip_count INTEGER NOT NULL DEFAULT 0,
  source_location_id BIGINT,  
  destination_location_id BIGINT,
  reference_number VARCHAR(100)   NOT NULL,  
  operation_type_id BIGINT , 
  assigned_user_id BIGINT, 
  assigned_role_id BIGINT, 
  assigned_working_team_id BIGINT, 
  current_user_id BIGINT, 
  complete_user_id BIGINT, 
  start_time DATETIME, 
  complete_time DATETIME, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),  
  foreign key(operation_type_id) references operation_type(operation_type_id),  
  foreign key(assigned_user_id) references user_info(user_id),  
  foreign key(assigned_role_id) references role(role_id),  
  foreign key(assigned_working_team_id) references working_team(working_team_id),  
  foreign key(current_user_id) references user_info(user_id),  
  foreign key(complete_user_id) references user_info(user_id));
 