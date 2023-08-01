ALTER TABLE item_family ADD COLUMN company_id bigint not null; 
ALTER TABLE item_family modify warehouse_id bigint ; 

update item_family set company_id = 1;
update item_family set warehouse_id = null;