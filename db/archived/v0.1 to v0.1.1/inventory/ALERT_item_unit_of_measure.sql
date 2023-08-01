 
ALTER TABLE item_unit_of_measure ADD COLUMN default_for_inbound_receiving boolean not null default false;
ALTER TABLE item_unit_of_measure ADD COLUMN default_for_work_order_receiving boolean not null default false;
ALTER TABLE item_unit_of_measure ADD COLUMN tracking_lpn boolean not null default false;

ALTER TABLE item_unit_of_measure ADD COLUMN company_id bigint not null; 
ALTER TABLE item_unit_of_measure modify warehouse_id bigint ; 

update item_unit_of_measure set company_id = 1;
update item_unit_of_measure set warehouse_id = null;


ALTER TABLE item_unit_of_measure ADD COLUMN  case_flag boolean ; 



ALTER TABLE item_unit_of_measure ADD COLUMN  weight_unit VARCHAR(50) ; 
ALTER TABLE item_unit_of_measure ADD COLUMN  length_unit VARCHAR(50) ; 
ALTER TABLE item_unit_of_measure ADD COLUMN  width_unit VARCHAR(50) ; 
ALTER TABLE item_unit_of_measure ADD COLUMN  height_unit VARCHAR(50) ; 