


DROP TABLE IF EXISTS quickbook_online_configuration;  

CREATE TABLE quickbook_online_configuration (
  quickbook_online_configuration_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id   BIGINT NOT NULL,
  company_id   BIGINT NOT NULL,
  client_id   VARCHAR(100),
  client_secret   VARCHAR(100),  
  webhook_verifier_token   VARCHAR(100),  
  quickbook_online_url    VARCHAR(200),  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
  ); 