

DROP TABLE if exists hualei_shipment_response_child; 
DROP TABLE if exists hualei_shipment_response; 

DROP TABLE if exists hualei_shipment_request_order_invoice_parameters; 
DROP TABLE if exists hualei_shipment_request_order_volume_parameters; 
DROP TABLE if exists hualei_shipment_request_parameters; 
DROP TABLE if exists hualei_shipment_request; 
 
  
CREATE TABLE hualei_shipment_request (
  hualei_shipment_request_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  get_tracking_number VARCHAR(1) ,  
  status VARCHAR(20)  NOT NULL,  
  outbound_order_id  BIGINT, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50), 
  foreign key(outbound_order_id) references outbound_order(outbound_order_id));
  
CREATE TABLE hualei_shipment_request_parameters (
  hualei_shipment_request_parameters_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  cargo_type VARCHAR(10) , 
  consignee_address VARCHAR(100) , 
  consignee_city VARCHAR(50) , 
  consignee_name VARCHAR(100) , 
  consignee_postcode VARCHAR(20) , 
  consignee_state VARCHAR(20) , 
  consignee_telephone VARCHAR(20) , 
  country VARCHAR(20) , 
  customer_id VARCHAR(20) , 
  customer_userid VARCHAR(20) , 
  customs_clearance VARCHAR(10) , 
  customs_declaration VARCHAR(10) , 
  duty_type VARCHAR(20) , 
  ship_from VARCHAR(200) , 
  is_fba VARCHAR(10) , 
  order_customer_invoice_code VARCHAR(20) , 
  order_piece int, 
  order_return_sign VARCHAR(10) , 
  product_id VARCHAR(20) , 
  weight double, 
  weight_unit   VARCHAR(50) , 
  hualei_shipment_request_id  BIGINT NOT NULL ,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(hualei_shipment_request_id) references hualei_shipment_request(hualei_shipment_request_id));
  
CREATE TABLE hualei_shipment_request_order_invoice_parameters (
  hualei_shipment_request_order_invoice_parameters_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  box_no VARCHAR(20) , 
  hs_code VARCHAR(20) , 
  invoice_amount DOUBLE , 
  invoice_pcs DOUBLE , 
  invoice_title VARCHAR(100) , 
  invoice_weight DOUBLE , 
  weight_unit   VARCHAR(50) , 
  sku VARCHAR(100) , 
  sku_code VARCHAR(100) ,  
  hualei_shipment_request_parameters_id   BIGINT NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(hualei_shipment_request_parameters_id) references hualei_shipment_request_parameters(hualei_shipment_request_parameters_id));
  
CREATE TABLE hualei_shipment_request_order_volume_parameters (
  hualei_shipment_request_order_volume_parameters_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  box_no VARCHAR(20) , 
  child_no VARCHAR(20) , 
  volume_height DOUBLE , 
  volume_length DOUBLE, 
  volume_width DOUBLE , 
  volume_weight DOUBLE , 
  length_unit   VARCHAR(50) , 
  weight_unit   VARCHAR(50) , 
  hualei_shipment_request_parameters_id   BIGINT NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(hualei_shipment_request_parameters_id) references hualei_shipment_request_parameters(hualei_shipment_request_parameters_id));
  
  
 
 
 
CREATE TABLE hualei_shipment_response (
  hualei_shipment_response_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  ack VARCHAR(10) ,  
  attr1 VARCHAR(100) ,  
  attr2 VARCHAR(100) ,  
  delay_type VARCHAR(100) ,  
  is_change_numbers VARCHAR(10) , 
  is_delay VARCHAR(10) ,  
  is_remote VARCHAR(10) ,  
  is_residential VARCHAR(10) ,  
  message VARCHAR(1000) ,  
  order_id VARCHAR(20) ,  
  order_private_code VARCHAR(100) ,  
  order_transfer_code VARCHAR(100) ,  
  order_price_trial_amount VARCHAR(50) ,  
  order_price_trial_currency VARCHAR(50) ,  
  post_customer_name VARCHAR(100) ,  
  product_track_no_api_type VARCHAR(100) ,  
  reference_number VARCHAR(100) ,  
  return_address VARCHAR(1000) ,  
  tracking_number VARCHAR(200) , 
  hualei_shipment_request_id  BIGINT NOT NULL ,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(hualei_shipment_request_id) references hualei_shipment_request(hualei_shipment_request_id));


CREATE TABLE hualei_shipment_response_child (
  hualei_shipment_response_child_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  child_number VARCHAR(100) ,  
  label_info VARCHAR(100) ,  
  hualei_shipment_response_id  BIGINT NOT NULL,   
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(hualei_shipment_response_id) references hualei_shipment_response(hualei_shipment_response_id));
