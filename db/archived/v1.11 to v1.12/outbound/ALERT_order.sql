 

ALTER TABLE outbound_order ADD COLUMN ship_to_contactor_phone_number VARCHAR(50); 


ALTER TABLE outbound_order ADD COLUMN cancel_requested BOOLEAN; 
ALTER TABLE outbound_order ADD COLUMN cancel_requested_time DATETIME; 
ALTER TABLE outbound_order ADD COLUMN cancel_requested_username VARCHAR(100); 
   