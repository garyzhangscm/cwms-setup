 

DROP TABLE IF EXISTS printer_type; 

CREATE TABLE printer_type (
  printer_type_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,  
  name varchar(50) not null, 
  description varchar(50) not null,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

