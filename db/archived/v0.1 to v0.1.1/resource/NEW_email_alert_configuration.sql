 

DROP TABLE IF EXISTS email_alert_configuration; 

CREATE TABLE email_alert_configuration (
  email_alert_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,
  host varchar(200) not null,
  port INTEGER not null,
  username varchar(200),
  password varchar(200),  
  send_from_email varchar(200),
  transport_protocol varchar(200) not null,
  auth_flag bool not null,
  starttls_enable_flag bool not null,
  debug_flag bool not null,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

