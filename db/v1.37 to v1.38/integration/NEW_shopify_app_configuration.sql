 

DROP TABLE IF EXISTS shopify_app_configuration; 

CREATE TABLE shopify_app_configuration (
  shopify_app_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  url VARCHAR(1000) NOT NULL,   
  shopify_app_client_id  VARCHAR(200) NOT NULL, 
  shopify_app_client_secret  VARCHAR(200) NOT NULL, 
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
