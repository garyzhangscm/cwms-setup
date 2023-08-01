 

DROP TABLE IF EXISTS warehouse_holiday;

CREATE TABLE warehouse_holiday (
  warehouse_holiday_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  holiday_date DATE not null, 
  description VARCHAR(250),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(warehouse_id) references warehouse(warehouse_id)
);

