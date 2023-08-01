 

DROP TABLE IF EXISTS alert_subscription; 

CREATE TABLE alert_subscription (
  alert_subscription_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,  
  user_id BIGINT not null, 
  type varchar(50) not null, 
  delivery_channel varchar(50) not null, 
  key_words_list   varchar(2000), 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(user_id) references user_info(user_id)
);

