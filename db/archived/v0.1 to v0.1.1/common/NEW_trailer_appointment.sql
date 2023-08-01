


DROP TABLE IF EXISTS trailer_appointment; 

CREATE TABLE trailer_appointment (
  trailer_appointment_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT,
  company_id BIGINT NOT NULL, 
  number   VARCHAR(100) NOT NULL,
  description   VARCHAR(200), 
  tractor_id BIGINT, 
  trailer_id BIGINT,  
  type VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  completed_time DATETIME,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  
  foreign key(trailer_id) references trailer(trailer_id),
  foreign key(tractor_id) references tractor(tractor_id)
);
 
