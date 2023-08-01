 
ALTER TABLE inventory ADD COLUMN fifo_date DATETIME;

update inventory set fifo_date = created_time where 1 = 1;