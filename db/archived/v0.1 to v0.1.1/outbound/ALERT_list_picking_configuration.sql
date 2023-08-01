ALTER TABLE list_picking_configuration ADD COLUMN customer_id BIGINT; 

ALTER TABLE list_picking_configuration ADD COLUMN max_volume DOUBLE; 
ALTER TABLE list_picking_configuration ADD COLUMN max_weight DOUBLE; 