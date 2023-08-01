-- User

DROP TABLE IF EXISTS spare_part_detail; 

CREATE TABLE spare_part_detail (
  spare_part_detail_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,   
  client_id BIGINT,
  item_id BIGINT not null,
  spare_part_id BIGINT not null,
  quantity BIGINT,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(spare_part_id) references spare_part(spare_part_id)
);
 
