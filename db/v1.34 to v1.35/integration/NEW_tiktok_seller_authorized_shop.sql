 

DROP TABLE IF EXISTS tiktok_seller_authorized_shop; 

CREATE TABLE tiktok_seller_authorized_shop (
  tiktok_seller_authorized_shop_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  auth_code VARCHAR(250) NOT NULL,
  company_id BIGINT NOT NULL, 
  client_id BIGINT,   
  shop_id VARCHAR(50) NOT NULL, 
  name VARCHAR(250) NOT NULL,
  region VARCHAR(20) NOT NULL,
  type VARCHAR(100) NOT NULL,
  cipher VARCHAR(250) NOT NULL,
  code VARCHAR(250) NOT NULL,
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
