-- User

DROP TABLE IF EXISTS qc_rule_item; 

CREATE TABLE qc_rule_item (
  qc_rule_item_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  check_point VARCHAR(1000) not null,
  qc_rule_item_type VARCHAR(200) not null,
  expected_value VARCHAR(200) not null,
  qc_rule_item_comparator VARCHAR(20) not null,
  qc_rule_id  BIGINT NOT NULL,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
  foreign key(qc_rule_id) references qc_rule(qc_rule_id)
);
 
