alter table location_group_type ADD COLUMN qc_area  boolean not null default 0;

alter table location_group_type ADD COLUMN customer_return_stage_locations  boolean not null default 0;

alter table location_group_type ADD COLUMN shipped_inventory_locations  boolean not null default 0;
update location_group_type  set shipped_inventory_locations   = 0 where 1=1;