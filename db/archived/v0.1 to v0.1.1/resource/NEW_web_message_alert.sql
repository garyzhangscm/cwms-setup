 

DROP TABLE IF EXISTS web_message_alert; 

CREATE TABLE web_message_alert (
  web_message_alert_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,  
  alert_id BIGINT NOT NULL,  
  user_id BIGINT not null, 
  read_flag   boolean not null default 0,
  read_date DATETIME,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(alert_id) references alert(alert_id),
  foreign key(user_id) references user_info(user_id)
);

