
drop table if exists cycle_count_batch;
drop table if exists cycle_count_result;
drop table if exists cycle_count_request;
drop table if exists audit_count_result;
drop table if exists audit_count_request;


DROP TABLE if exists inventory_snapshot_configuration;
DROP TABLE if exists inventory_snapshot_detail;
DROP TABLE if exists inventory_snapshot;

DROP TABLE if exists inventory_movement;
DROP TABLE if exists inventory;
DROP TABLE if exists inventory_adjustment_request;
DROP TABLE if exists inventory_adjustment_threshold;
DROP TABLE if exists inventory_activity;
drop table if exists inventory_status;
DROP TABLE IF EXISTS item_unit_of_measure;
DROP TABLE IF EXISTS item_package_type;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS item_family;


DROP TABLE IF EXISTS movement_path_detail;
DROP TABLE IF EXISTS movement_path;



CREATE TABLE item_family (
  item_family_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name   VARCHAR(100) NOT NULL,
  warehouse_id BIGINT NOT NULL,
  description   VARCHAR(100) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));

 


CREATE TABLE item(
  item_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name   VARCHAR(100) NOT NULL,
  description   VARCHAR(2000) NOT NULL,
  warehouse_id BIGINT NOT NULL,
  client_id BIGINT,
  item_family_id BIGINT,
  unit_cost double,
  allow_cartonization boolean not null default 0,
  allow_allocation_by_lpn boolean not null default 0,
  allocation_round_up_strategy_type VARCHAR(20),
  allocation_round_up_strategy_value double,
  tracking_volume_flag boolean not null default 0,
  tracking_lot_number_flag boolean not null default 0,
  tracking_manufacture_date_flag boolean not null default 0,
  shelf_life_days INT default 0,
  tracking_expiration_date_flag boolean not null default 0,
  image_url   VARCHAR(2000),
  thumbnail_url   VARCHAR(2000),
  active_flag boolean not null default 1,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_family_id) references item_family(item_family_id));

CREATE TABLE item_package_type(
  item_package_type_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name   VARCHAR(100) NOT NULL,
  description   VARCHAR(100) NOT NULL,
  item_id BIGINT NOT NULL,
  warehouse_id BIGINT NOT NULL,
  client_id BIGINT,
  supplier_id BIGINT,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_id) references item(item_id));

CREATE TABLE item_unit_of_measure (
  item_unit_of_measure_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  item_package_type_id BIGINT NOT NULL,
  unit_of_measure_id BIGINT NOT NULL,
  warehouse_id BIGINT NOT NULL,
  quantity INT not null,
  weight double not null,
  length double not null,
  width double not null,
  height double not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_package_type_id) references item_package_type(item_package_type_id));

create table inventory_status(
  inventory_status_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name   VARCHAR(100) NOT NULL,
  warehouse_id BIGINT NOT NULL,
  description   VARCHAR(100) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

CREATE TABLE inventory(
  inventory_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  lpn   VARCHAR(100) NOT NULL,
  location_id    BIGINT NOT NULL,
  pick_id    BIGINT,
  allocated_by_pick_id    BIGINT,
  item_id BIGINT not null,
  warehouse_id BIGINT NOT NULL,
  item_package_type_id BIGINT not null,
  quantity bigint not null,
  inventory_status_id bigint not null,
  virtual_inventory boolean not null default 0,
  receipt_id BIGINT,
  receipt_line_id BIGINT,
  work_order_id BIGINT,
  work_order_line_id BIGINT,
  work_order_by_product_id BIGINT,
  locked_for_adjust  boolean not null default 0,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_id) references item(item_id),
  foreign key(item_package_type_id) references item_package_type(item_package_type_id),
  foreign key(inventory_status_id) references inventory_status(inventory_status_id)
);

CREATE TABLE inventory_adjustment_request(
  inventory_adjustment_request_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  inventory_id      BIGINT,
  lpn   VARCHAR(100) NOT NULL,
  location_id    BIGINT NOT NULL,
  item_id BIGINT not null,
  item_package_type_id BIGINT not null,
  warehouse_id BIGINT NOT NULL,
  quantity bigint not null,
  new_quantity bigint not null,
  inventory_status_id bigint not null,
  virtual_inventory boolean,
  inventory_quantity_change_type   VARCHAR(20) NOT NULL,
  status   VARCHAR(20) NOT NULL,
  requested_by_username VARCHAR(50) NOT NULL,
  requested_by_datetime datetime not null ,
  processed_by_username VARCHAR(50),
  processed_by_datetime datetime ,
  document_number VARCHAR(200),
  comment VARCHAR(2000),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_id) references item(item_id),
  foreign key(item_package_type_id) references item_package_type(item_package_type_id),
  foreign key(inventory_status_id) references inventory_status(inventory_status_id)
);



CREATE TABLE inventory_adjustment_threshold(
  inventory_adjustment_threshold_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  item_id BIGINT,
  client_id BIGINT,
  item_family_id BIGINT,
  inventory_quantity_change_type VARCHAR(20),
  warehouse_id BIGINT NOT NULL,
  user_id BIGINT,
  role_id BIGINT,
  quantity_threshold BIGINT,
  cost_threshold    double,
  enabled    boolean not null default 0,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_id) references item(item_id),
  foreign key(item_family_id) references item_family(item_family_id)
);


CREATE TABLE inventory_activity(
  inventory_activity_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  transaction_id  VARCHAR(20) NOT NULL,
  transaction_group_id  VARCHAR(20) NOT NULL,
  lpn   VARCHAR(100) NOT NULL,
  location_id    BIGINT NOT NULL,
  pick_id    BIGINT,
  item_id BIGINT not null,
  warehouse_id BIGINT NOT NULL,
  item_package_type_id BIGINT not null,
  quantity bigint not null,
  inventory_status_id bigint not null,
  virtual_inventory boolean not null default 0,
  receipt_id BIGINT,
  type VARCHAR(20) NOT NULL,
  activity_datetime datetime not null ,
  username VARCHAR(50) NOT NULL,
  value_type VARCHAR(50),
  from_value VARCHAR(50),
  to_value VARCHAR(50),
  document_number VARCHAR(50),
  comment VARCHAR(2000),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_id) references item(item_id),
  foreign key(item_package_type_id) references item_package_type(item_package_type_id),
  foreign key(inventory_status_id) references inventory_status(inventory_status_id)
);

CREATE TABLE inventory_movement(
  inventory_movement_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  inventory_id    BIGINT NOT NULL,
  location_id    BIGINT not null,
  warehouse_id BIGINT NOT NULL,
  sequence INT not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(inventory_id) references inventory(inventory_id)
);


create table cycle_count_batch(
  cycle_count_batch_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  batch_id VARCHAR(100) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
create table cycle_count_request(
  cycle_count_request_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  batch_id VARCHAR(100) NOT NULL,
  warehouse_id BIGINT NOT NULL,
  location_id BIGINT NOT NULL,
  status VARCHAR(20) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

create table audit_count_request(
  audit_count_request_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  batch_id VARCHAR(100) NOT NULL,
  warehouse_id BIGINT NOT NULL,
  location_id BIGINT NOT NULL,  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

create table cycle_count_result(
  cycle_count_result_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  batch_id VARCHAR(100) NOT NULL,
  location_id BIGINT NOT NULL,
  warehouse_id BIGINT NOT NULL,
  item_id BIGINT,
  quantity int NOT NULL,
  count_quantity int NOT NULL,
  audit_count_request_id BIGINT,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_id) references item(item_id)
);

create table audit_count_result(
  audit_count_result_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  batch_id VARCHAR(100) NOT NULL,
  location_id BIGINT NOT NULL,
  warehouse_id BIGINT NOT NULL,
  inventory_id BIGINT,
  lpn   VARCHAR(100) ,
  item_id BIGINT,
  quantity int not null,
  count_quantity int NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(item_id) references item(item_id)
);


CREATE TABLE movement_path(
  movement_path_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_location_id    BIGINT,
  from_location_group_id    BIGINT,
  warehouse_id BIGINT NOT NULL,
  to_location_id BIGINT,
  to_location_group_id BIGINT,
  sequence INT not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);


CREATE TABLE movement_path_detail(
  movement_path_detail_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  movement_path_id    BIGINT NOT NULL,
  hop_location_id    BIGINT,
  hop_location_group_id BIGINT,
  warehouse_id BIGINT NOT NULL,
  sequence INT not null,
  strategy VARCHAR(20)  not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(movement_path_id) references movement_path(movement_path_id)
);


CREATE TABLE inventory_snapshot_configuration(
  inventory_snapshot_configuration_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id    BIGINT NOT NULL,
  cron VARCHAR(20)  not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

CREATE TABLE inventory_snapshot(
  inventory_snapshot_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id    BIGINT NOT NULL,
  batch_number VARCHAR(50)  not null,
  status VARCHAR(50)  not null,
  start_time DATETIME,
  complete_time DATETIME,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

CREATE TABLE inventory_snapshot_detail(
  inventory_snapshot_detail_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  inventory_snapshot_id    BIGINT NOT NULL,
  item_id BIGINT not null,
  item_package_type_id BIGINT not null,
  inventory_status_id bigint not null,
  location_group_type_id bigint not null,
  quantity bigint not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(inventory_snapshot_id) references inventory_snapshot(inventory_snapshot_id),
  foreign key(item_id) references item(item_id),
  foreign key(item_package_type_id) references item_package_type(item_package_type_id),
  foreign key(inventory_status_id) references inventory_status(inventory_status_id)
);