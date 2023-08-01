-- User

DROP TABLE IF EXISTS data_transfer_request_detail; 

CREATE TABLE data_transfer_request_detail (
  data_transfer_request_detail_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  sequence int NOT NULL, 
  description VARCHAR(100),
  status VARCHAR(50) NOT NULL,
  tables_name VARCHAR(50) NOT NULL,
  data_transfer_request_id bigint not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(data_transfer_request_id) references data_transfer_request(data_transfer_request_id)
);
