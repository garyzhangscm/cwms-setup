 

ALTER TABLE allocation_transaction_history ADD COLUMN allocate_by_receipt_number VARCHAR(100); 
  
ALTER TABLE allocation_transaction_history ADD COLUMN color VARCHAR(100); 
ALTER TABLE allocation_transaction_history ADD COLUMN style VARCHAR(100); 
ALTER TABLE allocation_transaction_history ADD COLUMN product_size VARCHAR(100); 
