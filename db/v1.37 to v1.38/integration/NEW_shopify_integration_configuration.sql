 

DROP TABLE IF EXISTS shopify_integration_configuration; 

CREATE TABLE shopify_integration_configuration (
  shopify_integration_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  company_id BIGINT NOT NULL, 
  client_id BIGINT ,  
  shop VARCHAR(500) NOT NULL,   
  access_token VARCHAR(500) NOT NULL,   
  scope VARCHAR(2000) NOT NULL,   
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
