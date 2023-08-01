DROP TABLE if exists hualei_shipping_label_format_by_product; 

DROP TABLE if exists hualei_configuration; 



CREATE TABLE hualei_configuration (
  hualei_configuration_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  customer_id VARCHAR(50) , 
  customer_userid VARCHAR(50) , 
  create_order_protocol VARCHAR(10) , 
  create_order_host VARCHAR(100) , 
  create_order_port VARCHAR(10) , 
  create_order_endpoint VARCHAR(500) , 
  print_label_protocol VARCHAR(10) , 
  print_label_host VARCHAR(100) , 
  print_label_port VARCHAR(10) , 
  print_label_endpoint VARCHAR(500) ,  
  default_cargo_type VARCHAR(50) , 
  default_customs_clearance VARCHAR(50) , 
  default_customs_declaration VARCHAR(50) , 
  default_duty_type VARCHAR(50) ,
  default_from VARCHAR(50) ,
  default_is_fba VARCHAR(50) ,
  default_order_returnsign VARCHAR(50) , 
  default_hs_code VARCHAR(50) , 
  default_invoice_title VARCHAR(50) , 
  default_sku VARCHAR(50) , 
  default_sku_code VARCHAR(50) , 
  weight_unit VARCHAR(20) , 
  length_unit VARCHAR(20) , 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
  
  
CREATE TABLE hualei_shipping_label_format_by_product (
  hualei_shipping_label_format_by_product_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  product_id VARCHAR(20) , 
  shipping_label_format VARCHAR(50) , 
  tracking_info_url VARCHAR(500) , 
  hualei_configuration_id   BIGINT NOT NULL,     
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(hualei_configuration_id) references hualei_configuration(hualei_configuration_id)
  );
 