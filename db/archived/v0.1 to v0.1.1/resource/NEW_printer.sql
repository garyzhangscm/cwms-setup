 

DROP TABLE IF EXISTS printer; 

CREATE TABLE printer (
  printer_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,  
  name varchar(50) not null, 
  description varchar(2000) not null,  
  printer_type_id BIGINT,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(printer_type_id) references printer_type(printer_type_id)
);

