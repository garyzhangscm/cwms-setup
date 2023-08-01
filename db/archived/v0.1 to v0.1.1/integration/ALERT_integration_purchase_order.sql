 
alter table integration_purchase_order ADD COLUMN  quickbook_txnid VARCHAR(50) ; 
alter table integration_purchase_order_line ADD COLUMN  quickbook_txnlineid VARCHAR(50) ; 