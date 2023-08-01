 

DROP TABLE IF EXISTS production_line_assignment_line; 

CREATE TABLE production_line_assignment_line (
  production_line_assignment_line_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  work_order_line_id BIGINT NOT NULL,
  production_line_assignment_id BIGINT NOT NULL,
  quantity BIGINT not null ,
  open_quantity BIGINT not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50) ,
  foreign key(work_order_line_id) references work_order_line(work_order_line_id),
  foreign key(production_line_assignment_id) references production_line_assignment(production_line_assignment_id)
);
 
