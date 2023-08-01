alter table location_group ADD COLUMN allow_empty_location  boolean not null default 0;

alter table location_group ADD COLUMN item_volume_tracking_level  nvarchar(20);

alter table location_group ADD COLUMN tracking_location_utilization boolean;



alter table location_group MODIFY  COLUMN inventory_consolidation_strategy nvarchar(30);