-- User

DROP TABLE IF EXISTS qc_rule; 

CREATE TABLE qc_rule (
  qc_rule_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL,
  name VARCHAR(50) not null,
  description VARCHAR(200),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 
