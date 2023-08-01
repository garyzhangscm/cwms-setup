 

DROP TABLE IF EXISTS billing_request_line; 

CREATE TABLE billing_request_line (
  billing_request_line_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  billing_request_id BIGINT not null,
  start_time datetime not null,
  end_time datetime not null,
  total_amount double,  
  total_charge double,  
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50),
  foreign key(billing_request_id) references billing_request(billing_request_id)
);
