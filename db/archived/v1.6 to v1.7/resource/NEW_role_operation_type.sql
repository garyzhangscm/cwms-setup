DROP TABLE if exists role_operation_type; 



CREATE TABLE role_operation_type (
  role_operation_type_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  role_id    BIGINT NOT NULL,
  operation_type_id    BIGINT NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(role_id) references role(role_id),
  foreign key(operation_type_id) references operation_type(operation_type_id));
 