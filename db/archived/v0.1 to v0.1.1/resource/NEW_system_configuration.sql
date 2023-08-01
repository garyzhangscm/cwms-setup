-- User

DROP TABLE IF EXISTS system_configuration;
DROP TABLE IF EXISTS report_printer_configuration;

CREATE TABLE system_configuration (
  system_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,
  warehouse_id BIGINT NOT NULL,
  allow_data_initial boolean not null default false,
  server_side_printing boolean not null default true,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

CREATE TABLE report_printer_configuration (
  report_printer_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL,
  report_type varchar(50) not null,
  criteria_value varchar(1000) not null,
  printer_name varchar(200) not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
