 
DROP TABLE IF EXISTS qc_inspection_request_item; 

CREATE TABLE qc_inspection_request_item (
  qc_inspection_request_item_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  qc_rule_id BIGINT not null,
  qc_inspection_result VARCHAR(200),
  qc_inspection_request_id BIGINT not null,
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50),
  foreign key(qc_inspection_request_id) references qc_inspection_request(qc_inspection_request_id),
  foreign key(qc_rule_id) references qc_rule(qc_rule_id)
);
 
