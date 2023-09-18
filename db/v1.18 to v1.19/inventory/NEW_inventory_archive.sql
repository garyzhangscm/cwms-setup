 

DROP TABLE if exists inventory_archive; 



CREATE TABLE inventory_archive (
  inventory_archive_id      BIGINT NOT NULL PRIMARY KEY, 
  lpn VARCHAR(100),
  location_id   BIGINT,   
  pick_id   BIGINT,   
  allocated_by_pick_id   BIGINT,   
  item_id   BIGINT,   
  warehouse_id   BIGINT,   
  item_package_type_id   BIGINT,   
  quantity   BIGINT,   
  inventory_status_id   BIGINT,  
  virtual_inventory   BOOLEAN,
  receipt_id   BIGINT,    
  receipt_line_id   BIGINT,   
  work_order_id   BIGINT,   
  work_order_line_id   BIGINT,   
  work_order_by_product_id   BIGINT,    
  locked_for_adjust   BOOLEAN, 
  create_inventory_transaction_id   BIGINT,  
  inbound_qc_required   BOOLEAN, 
  customer_return_order_id   BIGINT,  
  customer_return_order_line_id   BIGINT,  
  client_id   BIGINT,  
  color VARCHAR(50),
  product_size VARCHAR(50),
  style VARCHAR(50),
  fifo_date DATETIME, 
  reason_code_id   BIGINT,
  archived_date  DATETIME NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
   