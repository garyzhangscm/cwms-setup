ALTER TABLE item ADD COLUMN non_inventory_item BOOLEAN;

ALTER TABLE item ADD COLUMN tracking_color_flag BOOLEAN not null default 0;
ALTER TABLE item ADD COLUMN default_color varchar(100);
ALTER TABLE item ADD COLUMN tracking_product_size_flag BOOLEAN not null default 0;
ALTER TABLE item ADD COLUMN default_product_size varchar(100);
ALTER TABLE item ADD COLUMN tracking_style_flag BOOLEAN not null default 0;
ALTER TABLE item ADD COLUMN default_style varchar(100);


ALTER TABLE item ADD COLUMN receiving_rate_by_unit DOUBLE;
ALTER TABLE item ADD COLUMN shipping_rate_by_unit DOUBLE;
ALTER TABLE item ADD COLUMN handling_rate_by_unit DOUBLE;