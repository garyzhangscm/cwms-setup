ALTER TABLE outbound_order ADD COLUMN ship_to_address_line3 VARCHAR(100) ;
ALTER TABLE outbound_order ADD COLUMN bill_to_address_line3 VARCHAR(100) ;


alter table outbound_order modify column ship_to_address_postcode  VARCHAR(25); 
alter table outbound_order modify column bill_to_address_postcode  VARCHAR(25); 