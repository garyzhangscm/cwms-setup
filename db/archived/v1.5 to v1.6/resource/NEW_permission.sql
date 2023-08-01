 

DROP TABLE IF EXISTS permission; 

CREATE TABLE permission (
  permission_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  menu_id BIGINT NOT NULL, 
  name VARCHAR(100) not null, 
  description VARCHAR(200) not null, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(menu_id) references menu(menu_id) 
);

