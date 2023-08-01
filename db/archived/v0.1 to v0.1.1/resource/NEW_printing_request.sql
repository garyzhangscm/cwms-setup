 

DROP TABLE IF EXISTS printing_request; 

CREATE TABLE printing_request (
  printing_request_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,  
  report_history_id BIGINT not null, 
  printer_name varchar(200) not null,  
  copies INTEGER,  
  printing_time DATETIME,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(report_history_id) references report_history(report_history_id)
);

