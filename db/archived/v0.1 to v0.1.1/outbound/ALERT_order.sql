ALTER TABLE outbound_order ADD COLUMN category VARCHAR(50) NOT NULL DEFAULT 'SALES_ORDER';
ALTER TABLE outbound_order ADD COLUMN transfer_receipt_number VARCHAR(50);
ALTER TABLE outbound_order ADD COLUMN transfer_receipt_warehouse_id BIGINT;


ALTER TABLE outbound_order ADD COLUMN stage_location_id BIGINT;


ALTER TABLE outbound_order ADD COLUMN complete_time datetime;
ALTER TABLE shipment ADD COLUMN complete_time datetime;


alter table outbound_order ADD COLUMN  quickbook_txnid VARCHAR(50) ; 

alter table outbound_order_line ADD COLUMN  quickbook_txnlineid VARCHAR(50) ; 
alter table outbound_order ADD COLUMN  quickbook_customer_list_id VARCHAR(50) ; 