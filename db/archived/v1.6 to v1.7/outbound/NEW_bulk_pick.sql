DROP TABLE if exists bulk_pick; 



CREATE TABLE bulk_pick (
  bulk_pick_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number VARCHAR(50) NOT NULL,
  warehouse_id   BIGINT NOT NULL,
  wave_number VARCHAR(50) NOT NULL,
  source_location_id BIGINT  NOT NULL,
  item_id BIGINT  NOT NULL, 
  quantity  BIGINT NOT NULL,
  picked_quantity  BIGINT NOT NULL,
  picking_by_user_id  BIGINT, 
  status  VARCHAR(50) NOT NULL,
  inventory_status_id  BIGINT NOT NULL,
  unit_of_measure_id  BIGINT NOT NULL,
  work_task_id  BIGINT,
  confirm_item_flag BOOLEAN NOT NULL,
  confirm_location_flag BOOLEAN NOT NULL,
  confirm_location_code_flag BOOLEAN NOT NULL,
  confirm_lpn_flag BOOLEAN NOT NULL,
  color  VARCHAR(100),
  product_size  VARCHAR(100),
  style  VARCHAR(100), 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
 