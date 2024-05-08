 

DROP TABLE IF EXISTS file_upload_column_mapping; 

CREATE TABLE file_upload_column_mapping (
  file_upload_column_mapping_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  company_id BIGINT NOT NULL, 
  warehouse_id BIGINT NOT NULL,  
  type VARCHAR(100) NOT NULL,  
  column_name VARCHAR(200) NOT NULL, 
  mapping_to_column_name VARCHAR(200) NOT NULL, 
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);
