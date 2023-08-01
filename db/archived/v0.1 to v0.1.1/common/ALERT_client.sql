alter table client ADD COLUMN user_defined_field_1  VARCHAR(100);
alter table client ADD COLUMN user_defined_field_2  VARCHAR(100);
alter table client ADD COLUMN user_defined_field_3  VARCHAR(100);
alter table client ADD COLUMN user_defined_field_4  VARCHAR(100);
alter table client ADD COLUMN user_defined_field_5  VARCHAR(100);


alter table client ADD COLUMN company_id bigint;

alter table client ADD COLUMN list_pick_enabled_flag  boolean not null default 0;
 