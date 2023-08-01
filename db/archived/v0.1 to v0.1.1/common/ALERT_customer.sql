alter table customer ADD COLUMN user_defined_field_1  VARCHAR(100);
alter table customer ADD COLUMN user_defined_field_2  VARCHAR(100);
alter table customer ADD COLUMN user_defined_field_3  VARCHAR(100);
alter table customer ADD COLUMN user_defined_field_4  VARCHAR(100);
alter table customer ADD COLUMN user_defined_field_5  VARCHAR(100);


ALTER TABLE customer ADD COLUMN company_id bigint not null; 
ALTER TABLE customer modify warehouse_id bigint ; 

update customer set company_id = 1;
update customer set warehouse_id = null;



alter table customer ADD COLUMN list_pick_enabled_flag  boolean not null default 0;
ALTER TABLE customer ADD COLUMN  quickbook_listid VARCHAR(50) ; 
 