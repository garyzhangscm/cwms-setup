
ALTER TABLE outbound_order_line ADD COLUMN non_allocatable BOOLEAN;


ALTER TABLE outbound_order_line ADD COLUMN color varchar(100); 
ALTER TABLE outbound_order_line ADD COLUMN product_size varchar(100); 
ALTER TABLE outbound_order_line ADD COLUMN style varchar(100);