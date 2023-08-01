 
 
 
ALTER TABLE integration_item_unit_of_measure ADD COLUMN default_for_inbound_receiving BOOLEAN not null default 0; 
ALTER TABLE integration_item_unit_of_measure ADD COLUMN default_for_work_order_receiving BOOLEAN not null default 0; 
ALTER TABLE integration_item_unit_of_measure ADD COLUMN tracking_lpn BOOLEAN not null default 0; 
ALTER TABLE integration_item_unit_of_measure ADD COLUMN default_for_display BOOLEAN not null default 0; 
ALTER TABLE integration_item_unit_of_measure ADD COLUMN case_flag BOOLEAN not null default 0; 
 