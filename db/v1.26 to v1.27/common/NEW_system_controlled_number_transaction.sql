DROP TABLE if exists system_controlled_number_transaction; 



CREATE TABLE system_controlled_number_transaction (
  system_controlled_number_transaction_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  variable VARCHAR(100)  NOT NULL,
  number VARCHAR(100)  NOT NULL,
  rf_code  VARCHAR(100),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
 