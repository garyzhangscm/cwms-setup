 
ALTER TABLE item_package_type ADD COLUMN default_flag boolean not null default false;

 
 
ALTER TABLE item_package_type ADD COLUMN company_id bigint not null; 
ALTER TABLE item_package_type modify warehouse_id bigint ; 

update item_package_type set company_id = 1;
update item_package_type set warehouse_id = null;