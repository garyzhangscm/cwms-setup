alter table unit_of_measure drop index name;



ALTER TABLE unit_of_measure ADD COLUMN company_id bigint not null; 
ALTER TABLE unit_of_measure modify warehouse_id bigint ; 

update unit_of_measure set company_id = 1;
update unit_of_measure set warehouse_id = null;