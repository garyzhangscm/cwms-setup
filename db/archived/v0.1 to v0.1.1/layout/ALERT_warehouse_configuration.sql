alter table warehouse_configuration ADD COLUMN list_pick_enabled_flag  boolean not null default 0;
 
alter table warehouse_configuration ADD COLUMN printing_strategy  varchar(50);
 
alter table warehouse_configuration ADD COLUMN new_lpn_print_label_at_receiving_flag  boolean not null default 0;
alter table warehouse_configuration ADD COLUMN new_lpn_print_label_at_producing_flag  boolean not null default 0;
alter table warehouse_configuration ADD COLUMN new_lpn_print_label_at_adjustment_flag  boolean not null default 0; 


alter table warehouse_configuration ADD COLUMN reuse_lpn_after_removed  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN reuse_lpn_after_shipped  boolean not null default 0; 

alter table warehouse_configuration ADD COLUMN billing_request_enabled  boolean not null default 0; 


 
alter table warehouse_configuration ADD COLUMN workingOnSundayFlag  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN workingOnMondayFlag  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN workingOnTuesdayFlag  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN workingOnWednesdayFlag  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN workingOnThursdayFlag  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN workingOnFridayFlag  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN workingOnSaturdayFlag  boolean not null default 0; 

ALTER TABLE warehouse_configuration DROP COLUMN workingOnSundayFlag;
ALTER TABLE warehouse_configuration DROP COLUMN workingOnMondayFlag;
ALTER TABLE warehouse_configuration DROP COLUMN workingOnTuesdayFlag;
ALTER TABLE warehouse_configuration DROP COLUMN workingOnWednesdayFlag;
ALTER TABLE warehouse_configuration DROP COLUMN workingOnThursdayFlag;
ALTER TABLE warehouse_configuration DROP COLUMN workingOnFridayFlag;
ALTER TABLE warehouse_configuration DROP COLUMN workingOnSaturdayFlag;


alter table warehouse_configuration ADD COLUMN working_on_sunday  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN working_on_monday  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN working_on_tuesday  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN working_on_wednesday  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN working_on_thursday	  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN working_on_friday  boolean not null default 0; 
alter table warehouse_configuration ADD COLUMN working_on_saturday  boolean not null default 0; 

update warehouse_configuration 
set working_on_sunday = 0, working_on_monday = 0,working_on_tuesday = 0,working_on_wednesday = 0,working_on_thursday = 0, 
working_on_friday = 0, working_on_saturday = 0



alter table warehouse_configuration ADD COLUMN time_zone  VARCHAR(50);