 

DROP TABLE IF EXISTS item_default_package_uom; 
DROP TABLE IF EXISTS inventory_configuration; 

CREATE TABLE inventory_configuration (
  inventory_configuration_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,
  warehouse_id BIGINT NOT NULL,
  lpn_validation_rule VARCHAR(250),
  new_item_auto_generate_default_package_type boolean,
  new_item_default_package_type_name VARCHAR(50),
  new_item_default_package_type_description VARCHAR(250),  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 

CREATE TABLE item_default_package_uom (
  item_default_package_uom_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  inventory_configuration_id BIGINT NOT NULL,
  unit_of_measure_id BIGINT NOT NULL,
  quantity INT not null,
  weight double not null,
  weight_unit VARCHAR(50),
  length double not null,
  length_unit VARCHAR(50),
  width double not null,
  width_unit VARCHAR(50),
  height double not null,
  height_unit VARCHAR(50),
  default_for_inbound_receiving boolean not null default false, 
  default_for_work_order_receiving boolean not null default false, 
  tracking_lpn boolean not null default false,
  case_flag  boolean not null default false,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(inventory_configuration_id) references inventory_configuration(inventory_configuration_id)
);
  