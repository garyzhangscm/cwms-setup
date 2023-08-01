DROP TABLE if exists hualei_product; 
 


CREATE TABLE hualei_product (
  hualei_product_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  product_id VARCHAR(50) , 
  name VARCHAR(200) , 
  description VARCHAR(2000) ,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
   