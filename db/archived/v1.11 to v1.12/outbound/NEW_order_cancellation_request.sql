 

DROP TABLE if exists order_cancellation_request; 



CREATE TABLE order_cancellation_request (
  order_cancellation_request_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  outbound_order_id   BIGINT NOT NULL,   
  cancel_requested_time DATETIME , 
  cancel_requested_username VARCHAR(100) , 
  request_result VARCHAR(25) , 
  message VARCHAR(2000) , 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
   