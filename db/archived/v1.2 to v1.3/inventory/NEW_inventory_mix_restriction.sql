 

DROP TABLE IF EXISTS inventory_mix_rule_line; 
DROP TABLE IF EXISTS inventory_mix_rule; 

DROP TABLE IF EXISTS inventory_mix_restriction_line; 

DROP TABLE IF EXISTS inventory_mix_restriction; 

CREATE TABLE inventory_mix_restriction (
  inventory_mix_restriction_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id BIGINT NOT NULL,
  location_group_type_id BIGINT,
  location_group_id BIGINT,
  location_id BIGINT,
  client_id BIGINT, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 

CREATE TABLE inventory_mix_restriction_line (
  inventory_mix_restriction_line_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  inventory_mix_restriction_id BIGINT NOT NULL,
  type VARCHAR(20) not null,
  attribute VARCHAR(50) not null, 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(inventory_mix_restriction_id) references inventory_mix_restriction(inventory_mix_restriction_id)
);
  