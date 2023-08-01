 
DROP TABLE if exists tractor_attached_trailer;
DROP TABLE if exists tractor_appointment_trailer;
DROP TABLE if exists tractor;
DROP TABLE if exists trailer;
DROP TABLE if exists tractor_appointment;
DROP TABLE IF EXISTS trailer_appointment; 


DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS unit_of_measure;
DROP TABLE IF EXISTS reason_code;
drop table if exists system_controlled_number;
drop table if exists policy;

drop table if exists carrier_service_level;
drop table if exists carrier;

drop table if exists work_task;




CREATE TABLE client (
  client_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  name   VARCHAR(100) NOT NULL unique,
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

 


CREATE TABLE unit_of_measure (
  unit_of_measure_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  name   VARCHAR(100) NOT NULL unique,
  description   VARCHAR(100) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));


CREATE TABLE supplier (
  supplier_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  name   VARCHAR(100) NOT NULL unique,
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


CREATE TABLE customer (
  customer_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  name   VARCHAR(100) NOT NULL unique,
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
 


CREATE TABLE reason_code (
  reason_code_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  name   VARCHAR(100) NOT NULL unique,
  description   VARCHAR(100) NOT NULL,
  type   int NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));


CREATE TABLE system_controlled_number (
  system_controlled_number_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  variable   VARCHAR(100) NOT NULL unique,
  prefix   VARCHAR(10) NOT NULL,
  postfix   VARCHAR(10) NOT NULL,
  length   int NOT NULL,
  current_number   VARCHAR(100) NOT NULL,
  rollover boolean not null default 0,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));

CREATE TABLE policy (
  policy_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  policy_key   VARCHAR(100) NOT NULL unique,
  policy_value   VARCHAR(100) NOT NULL,
  description   VARCHAR(100) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));


CREATE TABLE carrier (
  carrier_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  name   VARCHAR(100) NOT NULL unique,
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


CREATE TABLE carrier_service_level (
  carrier_service_level_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name   VARCHAR(100) NOT NULL,
  description   VARCHAR(100) NOT NULL,
  type   VARCHAR(20) NOT NULL,
  carrier_id   BIGINT NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(carrier_id) references carrier(carrier_id));



CREATE TABLE work_task (
   work_task_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   warehouse_id BIGINT NOT NULL,
   number VARCHAR(20) NOT NULL,
   type VARCHAR(50) NOT NULL,
   status VARCHAR(20) NOT NULL,
   source_location_id BIGINT NOT NULL,
   destination_location_id BIGINT,
   inventory_id BIGINT,
   assigned_user_id BIGINT,
   assigned_role_id BIGINT,
   assigned_working_team_id BIGINT,
   current_user_id BIGINT,
   complete_user_id BIGINT,
   start_time BIGINT,
   complete_time BIGINT,
   created_time DATETIME,
   created_by VARCHAR(50),
   last_modified_time DATETIME,
   last_modified_by VARCHAR(50));
   
   
   
CREATE TABLE tractor_appointment(

  tractor_appointment_id   BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  company_id BIGINT  not null,
  warehouse_id BIGINT ,
  driver_first_name VARCHAR(50)  ,
  driver_last_name VARCHAR(50) ,
  driver_phone VARCHAR(50)  ,
  number VARCHAR(50) NOT NULL,
  description VARCHAR(2000) ,
  type  VARCHAR(50) NOT NULL, 
  status  VARCHAR(50) NOT NULL, 
  tractor_id BIGINT NOT NULL,  
  carrier_id BIGINT,
  carrier_service_level_id BIGINT,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(carrier_id) references carrier(carrier_id),
  foreign key(carrier_service_level_id) references carrier_service_level(carrier_service_level_id)
);

CREATE TABLE tractor(
  tractor_id   BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  company_id BIGINT  not null,
  warehouse_id BIGINT ,
  license_plate_number VARCHAR(50) ,
  number VARCHAR(50) NOT NULL,
  description VARCHAR(50),
  tractor_appointment_id BIGINT,
  location_id BIGINT,
  status VARCHAR(20) NOT NULL, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(tractor_appointment_id) references tractor_appointment(tractor_appointment_id)
);
   
CREATE TABLE trailer_appointment (
  trailer_appointment_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT,
  trailer_id BIGINT NOT NULL,  
  company_id BIGINT NOT NULL,  
  number VARCHAR(50) NOT NULL,
  description VARCHAR(2000) ,
  type VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
CREATE TABLE trailer(
  trailer_id   BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  company_id BIGINT  not null, 
  warehouse_id BIGINT, 
  number VARCHAR(50) NOT NULL,
  description VARCHAR(2000) ,
  trailer_appointment_id BIGINT, 
  size DOUBLE,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(trailer_appointment_id) references trailer_appointment(trailer_appointment_id), 
);


  
CREATE TABLE tractor_appointment_trailer (
  tractor_appointment_id    BIGINT NOT NULL,
  trailer_id    BIGINT NOT NULL,
  foreign key(tractor_appointment_id) references tractor_appointment(tractor_appointment_id),
  foreign key(trailer_id) references trailer(trailer_id),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
CREATE TABLE tractor_attached_trailer (
  tractor_id    BIGINT NOT NULL,
  trailer_id    BIGINT NOT NULL,
  foreign key(tractor_id) references tractor(tractor_id),
  foreign key(trailer_id) references trailer(trailer_id),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);