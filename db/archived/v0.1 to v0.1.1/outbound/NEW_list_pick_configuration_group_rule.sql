 

DROP TABLE IF EXISTS list_pick_configuration_group_rule; 

CREATE TABLE list_pick_configuration_group_rule (
  list_pick_configuration_group_rule_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  list_pick_configuration_id BIGINT NOT NULL,  
  group_rule_type varchar(50) not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(list_pick_configuration_id) references list_pick_configuration(list_pick_configuration_id)
);

