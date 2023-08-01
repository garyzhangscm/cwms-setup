ALTER TABLE item ADD COLUMN company_id bigint not null; 
ALTER TABLE item modify warehouse_id bigint ; 

update item set company_id = 1;
update item set warehouse_id = null;


ALTER TABLE item ADD COLUMN  abc_category_id bigint ; 
ALTER TABLE item ADD COLUMN  velocity_id bigint ; 


ALTER TABLE item ADD COLUMN  quickbook_listid VARCHAR(50) ; 