-- User

DROP TABLE IF EXISTS spare_part; 

CREATE TABLE spare_part (
  spare_part_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  company_id BIGINT NOT NULL,
  warehouse_id BIGINT,
  number VARCHAR(50) not null,
  description VARCHAR(1000),
  client_id BIGINT,
  item_id BIGINT not null,
  quantity BIGINT,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
