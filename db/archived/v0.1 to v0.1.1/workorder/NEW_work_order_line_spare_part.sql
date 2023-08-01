-- User

DROP TABLE IF EXISTS work_order_line_spare_part_detail; 
DROP TABLE IF EXISTS work_order_line_spare_part; 

CREATE TABLE work_order_line_spare_part (
  work_order_line_spare_part_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  work_order_line_id BIGINT NOT NULL, 
  name VARCHAR(50) not null,
  description VARCHAR(1000), 
  quantity BIGINT,
  inprocess_quantity  BIGINT,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(work_order_line_id) references work_order_line(work_order_line_id)
);
 
-- User


CREATE TABLE work_order_line_spare_part_detail (
  work_order_line_spare_part_detail_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,   
  client_id BIGINT,
  item_id BIGINT not null,
  inventory_status_id BIGINT not null,
  work_order_line_spare_part_id BIGINT not null,
  quantity BIGINT,
  open_quantity BIGINT,
  inprocess_quantity BIGINT,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(work_order_line_spare_part_id) references work_order_line_spare_part(work_order_line_spare_part_id)
);
 
