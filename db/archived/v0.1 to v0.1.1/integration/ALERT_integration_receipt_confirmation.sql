  


alter table integration_receipt_confirmation ADD COLUMN  quickbook_txnid VARCHAR(50) ; 
alter table integration_receipt_line_confirmation ADD COLUMN  quickbook_txnlineid VARCHAR(50) ; 

alter table integration_receipt_confirmation ADD COLUMN  quickbook_vendor_listid VARCHAR(50) ; 
alter table integration_receipt_line_confirmation ADD COLUMN  quickbook_item_listid VARCHAR(50) ; 