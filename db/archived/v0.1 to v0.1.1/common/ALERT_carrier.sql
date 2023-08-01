alter table carrier ADD COLUMN user_defined_field_1  VARCHAR(100);
alter table carrier ADD COLUMN user_defined_field_2  VARCHAR(100);
alter table carrier ADD COLUMN user_defined_field_3  VARCHAR(100);
alter table carrier ADD COLUMN user_defined_field_4  VARCHAR(100);
alter table carrier ADD COLUMN user_defined_field_5  VARCHAR(100);



alter table carrier ADD COLUMN enabled BOOLEAN;
update carrier set enabled = true;


alter table carrier modify column name   VARCHAR(100) NOT NULL;
alter table carrier modify column description   VARCHAR(100);
alter table carrier modify column contactor_firstname   VARCHAR(100);
alter table carrier modify column contactor_lastname   VARCHAR(100);
alter table carrier modify column address_country   VARCHAR(100);
alter table carrier modify column address_state   VARCHAR(100);
alter table carrier modify column address_county   VARCHAR(100);
alter table carrier modify column address_city   VARCHAR(100);
alter table carrier modify column address_district   VARCHAR(100);
alter table carrier modify column address_line1   VARCHAR(300);
alter table carrier modify column address_line2   VARCHAR(300);
alter table carrier modify column address_postcode  VARCHAR(10);