ALTER TABLE receipt ADD COLUMN category VARCHAR(50) NOT NULL DEFAULT 'PURCHASE_ORDER';
ALTER TABLE receipt ADD COLUMN transfer_order_number VARCHAR(50);
ALTER TABLE receipt ADD COLUMN transfer_order_warehouse_id BIGINT;


ALTER TABLE receipt ADD COLUMN check_in_time DATETIME; 
  
ALTER TABLE receipt ADD COLUMN created_time DATETIME;
ALTER TABLE receipt ADD COLUMN created_by VARCHAR(50);
ALTER TABLE receipt ADD COLUMN last_modified_time DATETIME;
ALTER TABLE receipt ADD COLUMN last_modified_by VARCHAR(50);