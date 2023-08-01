 

DROP TABLE IF EXISTS easy_post_carrier; 

DROP TABLE IF EXISTS easy_post_configuration; 

CREATE TABLE easy_post_configuration (
  easy_post_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  api_key VARCHAR(250),
  webhook_secret VARCHAR(100),
  use_warehouse_address_as_ship_from_flag boolean not null default 1,
  contactor_firstname   VARCHAR(100),
  contactor_lastname   VARCHAR(100),
  address_country   VARCHAR(100),
  address_state   VARCHAR(100),
  address_county   VARCHAR(100),
  address_city   VARCHAR(100),
  address_district   VARCHAR(100),
  address_line1   VARCHAR(300),
  address_line2   VARCHAR(300),
  address_postcode  VARCHAR(10),
  use_warehouse_address_as_return_flag boolean not null default 1,
  return_contactor_firstname   VARCHAR(100),
  return_contactor_lastname   VARCHAR(100),
  return_address_country   VARCHAR(100),
  return_address_state   VARCHAR(100),
  return_address_county   VARCHAR(100),
  return_address_city   VARCHAR(100),
  return_address_district   VARCHAR(100),
  return_address_line1   VARCHAR(300),
  return_address_line2   VARCHAR(300),
  return_address_postcode  VARCHAR(10),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);


CREATE TABLE easy_post_carrier (
  easy_post_carrier_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  easy_post_configuration_id BIGINT NOT NULL,
  carrier_id BIGINT NOT NULL,
  account_number VARCHAR(250), 
  report_type  VARCHAR(250) NOT NULL, 
  printer_name  VARCHAR(100), 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(easy_post_configuration_id) references easy_post_configuration(easy_post_configuration_id)
);