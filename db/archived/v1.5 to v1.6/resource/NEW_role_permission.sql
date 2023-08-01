 

DROP TABLE IF EXISTS role_permission; 

CREATE TABLE role_permission (
  role_permission_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  role_id BIGINT NOT NULL, 
  permission_id BIGINT NOT NULL, 
  allow_access BOOLEAN not null, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(role_id) references role(role_id) ,
  foreign key(permission_id) references permission(permission_id) 
);

