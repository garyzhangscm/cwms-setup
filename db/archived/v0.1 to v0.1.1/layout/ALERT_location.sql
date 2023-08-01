alter table location ADD COLUMN empty_in_process  boolean not null default 0;





ALTER TABLE location ADD COLUMN  weight_unit VARCHAR(50) ; 
ALTER TABLE location ADD COLUMN  length_unit VARCHAR(50) ; 
ALTER TABLE location ADD COLUMN  width_unit VARCHAR(50) ; 
ALTER TABLE location ADD COLUMN  height_unit VARCHAR(50) ; 
ALTER TABLE location ADD COLUMN  capacity_unit VARCHAR(50) ; 