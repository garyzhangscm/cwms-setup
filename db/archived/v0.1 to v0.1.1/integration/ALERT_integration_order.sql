ALTER TABLE integration_order ADD COLUMN category VARCHAR(50) NOT NULL DEFAULT 'SALES_ORDER';
ALTER TABLE integration_order ADD COLUMN transfer_receipt_warehouse_id BIGINT; 
ALTER TABLE integration_order ADD COLUMN transfer_receipt_warehouse_name VARCHAR(50); 


alter table integration_order ADD COLUMN  quickbook_txnid VARCHAR(50) ; 
alter table integration_order_line ADD COLUMN  quickbook_txnlineid VARCHAR(50) ; 
alter table integration_order ADD COLUMN  quickbook_customer_list_id VARCHAR(50) ; 