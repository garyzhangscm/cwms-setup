DROP TABLE IF EXISTS quickbook_webhook_history;  

CREATE TABLE quickbook_webhook_history (
  quickbook_webhook_history_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id   BIGINT,
  company_id   BIGINT,
  realm_id   VARCHAR(100),
  signature   VARCHAR(500),
  payload   VARCHAR(15000),
  status   VARCHAR(100),
  error_message   VARCHAR(500),
  processed_time DATETIME, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
  ); 