 

DROP TABLE IF EXISTS alert; 

CREATE TABLE alert (
  alert_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,    
  type varchar(50) not null,  
  key_words varchar(2000) not null, 
  title varchar(2000) not null, 
  message varchar(11000) not null, 
  error_message varchar(1000), 
  status varchar(50) not null, 
  last_sent_time DATETIME,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

