 
ALTER TABLE outbound_configuration ADD COLUMN status_allow_order_change_when_upload_file VARCHAR(20);
ALTER TABLE outbound_configuration ADD COLUMN status_allow_order_change_from_integration VARCHAR(20);
ALTER TABLE outbound_configuration ADD COLUMN status_allow_order_change_from_web_ui VARCHAR(20);


ALTER TABLE outbound_configuration ADD COLUMN complete_order_and_shipment_when_complete_wave BOOLEAN;
 
