 

DROP TABLE IF EXISTS rf_app_version; 

CREATE TABLE rf_app_version (
  rf_app_version_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,
  version_number varchar(10) not null,
  file_name varchar(100) not null,
  file_size BIGINT not null,
  release_note varchar(10000) not null,
  is_latest_version bool not null,
  release_date DATETIME,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

