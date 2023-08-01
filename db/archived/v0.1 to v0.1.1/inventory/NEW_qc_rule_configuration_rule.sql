-- User

DROP TABLE IF EXISTS qc_rule_configuration_rule; 

CREATE TABLE qc_rule_configuration_rule ( 
  qc_rule_configuration_id    BIGINT NOT NULL,
  qc_rule_id    BIGINT NOT NULL,
  foreign key(qc_rule_configuration_id) references qc_rule_configuration(qc_rule_configuration_id),
  foreign key(qc_rule_id) references qc_rule(qc_rule_id),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
