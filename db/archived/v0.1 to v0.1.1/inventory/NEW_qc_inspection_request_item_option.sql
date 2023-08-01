 
DROP TABLE IF EXISTS qc_inspection_request_item_option; 

CREATE TABLE qc_inspection_request_item_option (
  qc_inspection_request_item_option_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  qc_rule_item_id BIGINT not null,
  qc_inspection_result VARCHAR(200),
  qc_inspection_request_item_id BIGINT not null,
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50),
  foreign key(qc_inspection_request_item_id) references qc_inspection_request_item(qc_inspection_request_item_id),
  foreign key(qc_rule_item_id) references qc_rule_item(qc_rule_item_id)
);
 


ALTER TABLE qc_inspection_request_item_option ADD COLUMN string_value VARCHAR(2000);

 
ALTER TABLE qc_inspection_request_item_option ADD COLUMN double_value double;

ALTER TABLE qc_inspection_request_item_option ADD COLUMN boolean_value boolean;
 