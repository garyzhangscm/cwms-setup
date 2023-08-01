DROP TABLE if exists receipt_billable_activity; 



CREATE TABLE receipt_billable_activity (
  receipt_billable_activity_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  billable_activity_type_id BIGINT NOT NULL,
  activity_time DATETIME  NOT NULL,
  warehouse_id   BIGINT NOT NULL,
  client_id   BIGINT ,
  receipt_id   BIGINT NOT NULL,
  rate   DOUBLE,
  amount   DOUBLE,
  total_charge   DOUBLE  NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(receipt_id) references receipt(receipt_id));
 