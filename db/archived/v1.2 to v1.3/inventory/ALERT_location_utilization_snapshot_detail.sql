 
ALTER TABLE location_utilization_snapshot ADD COLUMN capacity_unit varchar(50);  
ALTER TABLE client_location_utilization_snapshot_batch ADD COLUMN capacity_unit varchar(50);  
ALTER TABLE location_utilization_snapshot_batch ADD COLUMN capacity_unit varchar(50);  
ALTER TABLE location_utilization_snapshot_detail ADD COLUMN capacity_unit varchar(50);  