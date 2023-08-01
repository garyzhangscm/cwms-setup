-- User

DROP TABLE IF EXISTS department; 

CREATE TABLE department (
  department_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,
  name varchar(100) not null,
  description varchar(200) not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

