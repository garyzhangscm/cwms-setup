 
ALTER TABLE list_pick_configuration ADD COLUMN max_pick_count INTEGER; 
ALTER TABLE list_pick_configuration ADD COLUMN max_quantity BIGINT; 



ALTER TABLE list_pick_configuration ADD COLUMN max_volume_unit varchar(50); 

ALTER TABLE list_pick_configuration ADD COLUMN max_weight_unit varchar(50); 

ALTER TABLE list_pick_configuration ADD COLUMN allow_lpn_pick BOOLEAN; 

