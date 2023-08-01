DROP TABLE if exists outbound_order_billable_activity; 



CREATE TABLE outbound_order_billable_activity (
  outbound_order_billable_activity_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  billable_activity_type_id BIGINT NOT NULL,
  activity_time DATETIME  NOT NULL,
  warehouse_id   BIGINT NOT NULL,
  client_id   BIGINT ,
  outbound_order_id   BIGINT NOT NULL,
  rate   DOUBLE,
  amount   DOUBLE,
  total_charge   DOUBLE  NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(outbound_order_id) references outbound_order(outbound_order_id));
 