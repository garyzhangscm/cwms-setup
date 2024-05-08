 
ALTER TABLE receipt_line ADD COLUMN inventory_attribute_1 VARCHAR(200);
ALTER TABLE receipt_line ADD COLUMN inventory_attribute_2 VARCHAR(200);
ALTER TABLE receipt_line ADD COLUMN inventory_attribute_3 VARCHAR(200);
ALTER TABLE receipt_line ADD COLUMN inventory_attribute_4 VARCHAR(200);
ALTER TABLE receipt_line ADD COLUMN inventory_attribute_5 VARCHAR(200);


ALTER TABLE receipt_line ADD COLUMN inventory_status_id BIGINT;
