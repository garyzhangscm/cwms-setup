 

DROP TABLE IF EXISTS rf_app_version_by_rf_code; 

CREATE TABLE rf_app_version_by_rf_code (
  rf_app_version_by_rf_code_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  rf_id BIGINT NOT NULL,
  rf_app_version_id BIGINT NOT NULL,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(rf_id) references rf_info(rf_id),
  foreign key(rf_app_version_id) references rf_app_version(rf_app_version_id)
);

