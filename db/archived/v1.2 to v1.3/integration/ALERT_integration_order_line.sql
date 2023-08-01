ALTER TABLE integration_order_line ADD COLUMN item_quickbook_list_id VARCHAR(50) ;
ALTER TABLE integration_order_line ADD COLUMN non_allocatable BOOLEAN;