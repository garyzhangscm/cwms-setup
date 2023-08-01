 

ALTER TABLE outbound_order_line ADD COLUMN hualei_product_id VARCHAR(100); 
 
ALTER TABLE outbound_order_line ADD COLUMN auto_request_shipping_label BOOLEAN not null default 0; 
