 

DROP TABLE IF EXISTS alert_template; 

CREATE TABLE alert_template (
  alert_template_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,  
  type varchar(50) not null, 
  delivery_channel varchar(50) not null, 
  template varchar(5000) not null, 
  read_date DATETIME,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

