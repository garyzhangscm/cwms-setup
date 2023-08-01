 

ALTER TABLE integration_order_line  ADD COLUMN allocate_by_receipt_number VARCHAR(100);  

ALTER TABLE integration_order_line  ADD COLUMN parcel_insured BOOLEAN;  
ALTER TABLE integration_order_line  ADD COLUMN parcel_insured_amount_per_unit DOUBLE;
ALTER TABLE integration_order_line  ADD COLUMN parcel_signature_required BOOLEAN;  