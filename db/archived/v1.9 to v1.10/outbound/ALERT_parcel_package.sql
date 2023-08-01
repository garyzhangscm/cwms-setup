 

ALTER TABLE parcel_package ADD COLUMN status_description VARCHAR(500);  
update parcel_package set status = 'REQUESTED' where 1=1;
  
ALTER TABLE parcel_package ADD COLUMN request_system VARCHAR(30);  
  
