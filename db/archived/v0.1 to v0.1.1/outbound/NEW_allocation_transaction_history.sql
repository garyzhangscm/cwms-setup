 

DROP TABLE IF EXISTS allocation_transaction_history; 

CREATE TABLE allocation_transaction_history (
  allocation_transaction_history_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  number varchar(20) not null,  
  transaction_group_id varchar(20) not null,
  order_number varchar(100), 
  shipment_line_id BIGINT,
  work_order_number varchar(20),
  work_order_id BIGINT,
  item_name varchar(100),
  item_id BIGINT, 
  location_name varchar(100),
  location_id BIGINT,
  total_required_quantity BIGINT,
  current_required_quantity BIGINT, 
  total_inventory_quantity BIGINT,
  total_available_quantity BIGINT,
  total_allocated_quantity BIGINT,
  already_allocated_quantity BIGINT,
  is_skipped_flag boolean,
  is_allocated_by_lpn_flag boolean,
  is_round_up_flag boolean,  
  username  VARCHAR(100) NOT NULL ,
  message  VARCHAR(2000),	 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(shipment_line_id) references shipment_line(shipment_line_id)
);

