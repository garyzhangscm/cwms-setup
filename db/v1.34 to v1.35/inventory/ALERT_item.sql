 
ALTER TABLE item ADD COLUMN tracking_inventory_attribute_1_flag BOOLEAN not null default false;
ALTER TABLE item ADD COLUMN default_inventory_attribute_1 VARCHAR(200);

ALTER TABLE item ADD COLUMN tracking_inventory_attribute_2_flag BOOLEAN not null default false;
ALTER TABLE item ADD COLUMN default_inventory_attribute_2 VARCHAR(200);

ALTER TABLE item ADD COLUMN tracking_inventory_attribute_3_flag BOOLEAN not null default false;
ALTER TABLE item ADD COLUMN default_inventory_attribute_3 VARCHAR(200);

ALTER TABLE item ADD COLUMN tracking_inventory_attribute_4_flag BOOLEAN not null default false;
ALTER TABLE item ADD COLUMN default_inventory_attribute_4 VARCHAR(200);

ALTER TABLE item ADD COLUMN tracking_inventory_attribute_5_flag BOOLEAN not null default false;
ALTER TABLE item ADD COLUMN default_inventory_attribute_5 VARCHAR(200);

update item set tracking_inventory_attribute_1_flag = false;
update item set tracking_inventory_attribute_2_flag = false;
update item set tracking_inventory_attribute_3_flag = false;
update item set tracking_inventory_attribute_4_flag = false;
update item set tracking_inventory_attribute_5_flag = false;