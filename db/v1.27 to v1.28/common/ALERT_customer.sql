ALTER TABLE customer ADD COLUMN is_target BOOLEAN;
ALTER TABLE customer ADD COLUMN is_walmart BOOLEAN;

ALTER TABLE customer ADD COLUMN allow_print_shipping_carton_label BOOLEAN;
ALTER TABLE customer ADD COLUMN allow_print_shipping_carton_label_with_pallet_label BOOLEAN;
ALTER TABLE customer ADD COLUMN print_shipping_carton_label_with_pallet_label_when_short BOOLEAN;


ALTER TABLE customer ADD COLUMN max_pallet_size DOUBLE;
ALTER TABLE customer ADD COLUMN max_pallet_height DOUBLE;



