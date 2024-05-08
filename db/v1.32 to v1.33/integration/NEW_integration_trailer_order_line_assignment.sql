DROP TABLE if exists integration_trailer_order_line_assignment; 



CREATE TABLE integration_trailer_order_line_assignment (
  integration_trailer_order_line_assignment_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  company_id   BIGINT ,   
  company_code VARCHAR(100)  ,
  warehouse_id   BIGINT ,   
  warehouse_name VARCHAR(100)  , 
  integration_stop_id BIGINT NOT NULL,
  order_id BIGINT,
  order_number VARCHAR(100) ,
  order_line_id BIGINT,
  order_line_number VARCHAR(100) ,
  status  VARCHAR(10) NOT NULL ,
  insert_time DATETIME,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  error_message VARCHAR(1000),
  foreign key(integration_stop_id) references integration_stop(integration_stop_id));
 