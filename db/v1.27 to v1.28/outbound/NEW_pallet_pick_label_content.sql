DROP TABLE if exists pallet_pick_label_pick_detail; 
DROP TABLE if exists pallet_pick_label_content; 


CREATE TABLE pallet_pick_label_content (
  pallet_pick_label_content_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,    
  number VARCHAR(100)  NOT NULL,
  outbound_order_id   BIGINT ,
  reference_number VARCHAR(100), 
  volume DOUBLE  NOT NULL,
  volume_unit varchar(50), 
  height_unit varchar(50),  
  height DOUBLE  NOT NULL,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(outbound_order_id) references outbound_order(outbound_order_id));
  
CREATE TABLE pallet_pick_label_pick_detail (
  pallet_pick_label_pick_detail_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  pick_id   BIGINT  NOT NULL, 
  pallet_pick_label_content_id    BIGINT  NOT NULL,  
  pick_quantity LONG NOT NULL, 
  case_quantity LONG,  
  case_unit_of_measure_name VARCHAR(100),  
  volume DOUBLE  NOT NULL,  
  volume_unit varchar(50), 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(pick_id) references pick(pick_id),
  foreign key(pallet_pick_label_content_id) references pallet_pick_label_content(pallet_pick_label_content_id));
 