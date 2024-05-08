 
ALTER TABLE inventory ADD COLUMN attribute_1 VARCHAR(200);
ALTER TABLE inventory ADD COLUMN attribute_2 VARCHAR(200);
ALTER TABLE inventory ADD COLUMN attribute_3 VARCHAR(200);
ALTER TABLE inventory ADD COLUMN attribute_4 VARCHAR(200);
ALTER TABLE inventory ADD COLUMN attribute_5 VARCHAR(200);

ALTER TABLE inventory ADD COLUMN in_warehouse_datetime DATETIME;

ALTER TABLE inventory ADD COLUMN shipped_datetime DATETIME;
