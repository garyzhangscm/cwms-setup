 
ALTER TABLE billing_rate ADD COLUMN billing_rate_by_inventory_age_id BIGINT; 
 

ALTER TABLE billing_rate ADD COLUMN rate_unit varchar(50); 
 

ALTER TABLE billing_rate ADD COLUMN rate_by_quantity BOOLEAN; 
 
