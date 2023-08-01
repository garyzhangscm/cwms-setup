ALTER TABLE stop DROP COLUMN trailer_id;



ALTER TABLE stop ADD COLUMN stop_sequence bigint not null; 
ALTER TABLE stop ADD COLUMN trailer_appointment_id bigint; 

ALTER TABLE stop ADD COLUMN number  VARCHAR(25) NOT NULL; 

ALTER TABLE stop ADD COLUMN contactor_firstname   VARCHAR(100); 
ALTER TABLE stop ADD COLUMN contactor_lastname   VARCHAR(100) ; 
ALTER TABLE stop ADD COLUMN address_country   VARCHAR(100) ; 
ALTER TABLE stop ADD COLUMN address_state   VARCHAR(100) ; 
ALTER TABLE stop ADD COLUMN address_county   VARCHAR(100) ; 
ALTER TABLE stop ADD COLUMN address_city   VARCHAR(100) ; 
ALTER TABLE stop ADD COLUMN address_district   VARCHAR(100); 
ALTER TABLE stop ADD COLUMN address_line1   VARCHAR(300) ; 
ALTER TABLE stop ADD COLUMN address_line2   VARCHAR(300); 
ALTER TABLE stop ADD COLUMN address_postcode  VARCHAR(10) ; 

ALTER TABLE stop ADD COLUMN status  VARCHAR(20) ; 


ALTER TABLE stop ADD COLUMN ship_to_customer_id BIGINT;