
drop table if exists location;
drop table if exists pickable_unit_of_measure;
drop table if exists location_group;
drop Table if exists location_group_type;
DROP TABLE IF EXISTS warehouse;
DROP TABLE IF EXISTS company;

CREATE TABLE company (
  company_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  code   VARCHAR(100) NOT NULL unique,
  name   VARCHAR(100) NOT NULL,
  description   VARCHAR(100) NOT NULL,
  contactor_firstname   VARCHAR(100) NOT NULL,
  contactor_lastname   VARCHAR(100) NOT NULL,
  address_country   VARCHAR(100) NOT NULL,
  address_state   VARCHAR(100) NOT NULL,
  address_county   VARCHAR(100) NOT NULL,
  address_city   VARCHAR(100) NOT NULL,
  address_district   VARCHAR(100),
  address_line1   VARCHAR(300) NOT NULL,
  address_line2   VARCHAR(300),
  address_postcode  VARCHAR(10) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));

-- you may need to create the company
INSERT INTO company (company_id, code, name, description,
    contactor_firstname, contactor_lastname,
    address_country, address_state, address_county ,
    address_city , address_district, address_line1, address_line2, address_postcode)
VALUES (1, "200001", "Company-Name", "Company Name",
    "FirstName","LastName",
    "U.S", "CA", "County", "City", "", "Address", "", "90001");
 

CREATE TABLE warehouse (
  warehouse_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id   BIGINT NOT NULL,
  name   VARCHAR(100) NOT NULL,
  size   double NOT NULL,
  address_country   VARCHAR(100) NOT NULL,
  address_state   VARCHAR(100) NOT NULL,
  address_county   VARCHAR(100) NOT NULL,
  address_city   VARCHAR(100) NOT NULL,
  address_district   VARCHAR(100),
  address_line1   VARCHAR(300) NOT NULL,
  address_line2   VARCHAR(300),
  address_postcode  VARCHAR(10) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(company_id) references company(company_id));


INSERT INTO warehouse (company_id, name, size, address_country, address_state, address_county ,
    address_city , address_district, address_line1, address_line2, address_postcode)
     VALUES (1, "WM01", 50000, "U.S", "CA", "County", "City", "", "Address", "", "90001"); 
  


CREATE TABLE location_group_type (
  location_group_type_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name   VARCHAR(100) NOT NULL,
  description   VARCHAR(100) NOT NULL,
  four_wall_inventory  boolean not null default 1,
  virtual_locations  boolean not null default 0,
  receiving_stage_locations  boolean not null default 0,
  shipping_stage_locations  boolean not null default 0,
  dock_locations  boolean not null default 0,
  yard_locations  boolean not null default 0,
  storage_locations  boolean not null default 0,
  pickup_and_deposit_locations  boolean not null default 0,
  trailer_locations  boolean not null default 0,
  shipped_parcel_locations boolean not null default 0,
  shipped_order_locations boolean not null default 0,
  rf_locations  boolean not null default 0,
  grid  boolean not null default 0,
  production_line_locations  boolean not null default 0,
  production_line_inbound_locations  boolean not null default 0,
  production_line_outbound_locations  boolean not null default 0,
  container_locations  boolean not null default 0,
  packing_stations boolean not null default 0,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
  );
 

CREATE TABLE location_group(
  location_group_id   BIGINT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name   VARCHAR(100) NOT NULL,
  description   VARCHAR(100) NOT NULL,
  location_group_type_id BIGINT NOT NULL,
  warehouse_id BIGINT NOT NULL,
  pickable  boolean not null default 0,
  storable  boolean not null default 0,
  countable  boolean not null default 0,
  adjustable  boolean not null default 0,
  allow_cartonization boolean not null default 0,
  tracking_volume  boolean not null default 0,
  volume_tracking_policy VARCHAR(20),
  inventory_consolidation_strategy VARCHAR(20),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(location_group_type_id) references location_group_type(location_group_type_id),
  foreign key(warehouse_id) references warehouse(warehouse_id));
 


CREATE TABLE pickable_unit_of_measure(

  pickable_unit_of_measure_id   BIGINT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
  unit_of_measure_id  BIGINT  NOT NULL,
  location_group_id BIGINT  NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(location_group_id) references location_group(location_group_id));


CREATE TABLE location(
  location_id   BIGINT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name   VARCHAR(100) NOT NULL,
  code   VARCHAR(20) ,
  warehouse_id BIGINT NOT NULL,
  aisle   VARCHAR(100),
  x double,
  y double,
  z double,
  length double,
  width double,
  height double,
  pick_sequence BIGINT,
  putaway_sequence BIGINT,
  count_sequence BIGINT,
  capacity double,
  fill_percentage double,
  current_volume double,
  pending_volume double,
  location_group_id  BIGINT not null,
  enabled boolean not null default 0,
  locked boolean not null default 0,
  reserved_code VARCHAR(100),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(location_group_id) references location_group(location_group_id),
  foreign key(warehouse_id) references warehouse(warehouse_id));



