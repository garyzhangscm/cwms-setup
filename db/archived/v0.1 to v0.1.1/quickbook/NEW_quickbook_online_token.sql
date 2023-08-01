


DROP TABLE IF EXISTS quickbook_online_token;  

CREATE TABLE quickbook_online_token (
  quickbook_online_token_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id   BIGINT NOT NULL,
  company_id   BIGINT NOT NULL,
  realm_id   VARCHAR(100),
  authorization_code   VARCHAR(100),
  token   VARCHAR(1000),
  refresh_token   VARCHAR(100),
  last_token_request_time DATETIME,
  last_cdc_call_time  VARCHAR(50),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
  ); 