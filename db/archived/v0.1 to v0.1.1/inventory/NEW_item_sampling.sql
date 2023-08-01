-- User

DROP TABLE IF EXISTS item_sampling; 

CREATE TABLE item_sampling (
  item_sampling_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL,
  number VARCHAR(50) not null,
  description VARCHAR(1000),
  image_urls VARCHAR(2000),
  item_id BIGINT not null,
  enabled boolean not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_id) references item(item_id)
);
 
