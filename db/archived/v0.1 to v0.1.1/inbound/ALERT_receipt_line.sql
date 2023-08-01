ALTER TABLE receipt_line ADD COLUMN qc_quantity BIGINT; 
ALTER TABLE receipt_line ADD COLUMN qc_percentage double; 
ALTER TABLE receipt_line ADD COLUMN qc_quantity_requested BIGINT; 


ALTER TABLE receipt_line ADD COLUMN created_time DATETIME;
ALTER TABLE receipt_line ADD COLUMN created_by VARCHAR(50);
ALTER TABLE receipt_line ADD COLUMN last_modified_time DATETIME;
ALTER TABLE receipt_line ADD COLUMN last_modified_by VARCHAR(50);