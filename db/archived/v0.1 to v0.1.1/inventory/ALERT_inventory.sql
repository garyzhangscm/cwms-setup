 
ALTER TABLE inventory ADD COLUMN inbound_qc_required bool not null default 0;


ALTER TABLE inventory ADD COLUMN customer_return_order_id bigint;
ALTER TABLE inventory ADD COLUMN customer_return_order_line_id bigint;


ALTER TABLE inventory ADD COLUMN client_id bigint;


 