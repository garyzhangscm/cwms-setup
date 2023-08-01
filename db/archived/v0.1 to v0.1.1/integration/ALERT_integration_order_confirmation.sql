  


alter table integration_order_confirmation ADD COLUMN  quickbook_txnid VARCHAR(50) ; 
alter table integration_order_line_confirmation ADD COLUMN  quickbook_txnlineid VARCHAR(50) ; 

alter table integration_order_confirmation ADD COLUMN  quickbook_customer_list_id VARCHAR(50) ;  