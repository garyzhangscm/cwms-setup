 
ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_1_enabled BOOLEAN not null default false;
ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_1_display_name VARCHAR(200);

ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_2_enabled BOOLEAN not null default false;
ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_2_display_name VARCHAR(200);

ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_3_enabled BOOLEAN not null default false;
ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_3_display_name VARCHAR(200);

ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_4_enabled BOOLEAN not null default false;
ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_4_display_name VARCHAR(200);

ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_5_enabled BOOLEAN not null default false;
ALTER TABLE inventory_configuration ADD COLUMN inventory_attribute_5_display_name VARCHAR(200);
 

update inventory_configuration set inventory_attribute_1_enabled = false;
update inventory_configuration set inventory_attribute_2_enabled = false;
update inventory_configuration set inventory_attribute_3_enabled = false;
update inventory_configuration set inventory_attribute_4_enabled = false;
update inventory_configuration set inventory_attribute_5_enabled = false;