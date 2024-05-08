 

DROP TABLE IF EXISTS tiktok_seller_shop_integration_configuration; 

CREATE TABLE tiktok_seller_shop_integration_configuration (
  tiktok_seller_shop_integration_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  auth_code VARCHAR(250) NOT NULL,
  company_id BIGINT NOT NULL, 
  client_id BIGINT, 
  access_token VARCHAR(250) NOT NULL,
  access_token_expire_in BIGINT NOT NULL,
  refresh_token VARCHAR(100) NOT NULL,
  refresh_token_expire_in BIGINT NOT NULL,
  open_id VARCHAR(100) NOT NULL,
  seller_name VARCHAR(100) NOT NULL,
  seller_base_region VARCHAR(50) NOT NULL,
  user_type INTEGER NOT NULL,
  auto_refresh_order_time_window_in_minute INTEGER,
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
