alter table billing_request_line ADD COLUMN rate DOUBLE;

alter table billing_request_line ADD COLUMN document_number VARCHAR(500);
alter table billing_request_line ADD COLUMN item_name VARCHAR(100);
 
 
 
 