 
ALTER TABLE inbound_receiving_configuration ADD COLUMN status_allow_receipt_change_when_upload_file VARCHAR(20);
ALTER TABLE inbound_receiving_configuration ADD COLUMN status_allow_receipt_change_from_integration VARCHAR(20);
ALTER TABLE inbound_receiving_configuration ADD COLUMN status_allow_receipt_change_from_web_ui VARCHAR(20);
 
