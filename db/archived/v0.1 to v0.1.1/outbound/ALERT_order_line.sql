 
ALTER TABLE outbound_order_line ADD COLUMN requested_return_quantity BIGINT; 
ALTER TABLE outbound_order_line ADD COLUMN actual_return_quantity BIGINT; 