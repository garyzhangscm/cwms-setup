alter table supplier ADD COLUMN user_defined_field_1  VARCHAR(100);
alter table supplier ADD COLUMN user_defined_field_2  VARCHAR(100);
alter table supplier ADD COLUMN user_defined_field_3  VARCHAR(100);
alter table supplier ADD COLUMN user_defined_field_4  VARCHAR(100);
alter table supplier ADD COLUMN user_defined_field_5  VARCHAR(100);


ALTER TABLE supplier ADD COLUMN company_id bigint not null; 
ALTER TABLE supplier modify warehouse_id bigint ; 

update supplier set company_id = 1;
update supplier set warehouse_id = null;
ALTER TABLE supplier ADD COLUMN  quickbook_listid VARCHAR(50) ; 