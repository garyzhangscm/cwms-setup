 

ALTER TABLE purchase_order modify status VARCHAR(20) not null,
 
alter table purchase_order ADD COLUMN  quickbook_txnid VARCHAR(50) ; 
alter table purchase_order_line ADD COLUMN  quickbook_txnlineid VARCHAR(50) ; 