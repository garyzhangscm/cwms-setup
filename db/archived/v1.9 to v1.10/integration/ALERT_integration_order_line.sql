 

ALTER TABLE integration_order_line ADD COLUMN hualei_product_id VARCHAR(100); 
 
ALTER TABLE integration_order_line ADD COLUMN auto_request_shipping_label BOOLEAN not null default 0; 

ALTER TABLE integration_order_line ADD COLUMN color varchar(100); 
ALTER TABLE integration_order_line ADD COLUMN product_size varchar(100); 
ALTER TABLE integration_order_line ADD COLUMN style varchar(100);
