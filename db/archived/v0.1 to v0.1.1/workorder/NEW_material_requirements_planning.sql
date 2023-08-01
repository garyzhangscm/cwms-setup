 


DROP TABLE IF EXISTS mrp_production_line; 
DROP TABLE IF EXISTS material_requirements_planning_line; 
DROP TABLE IF EXISTS material_requirements_planning; 

CREATE TABLE material_requirements_planning (
  material_requirements_planning_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  number VARCHAR(50) not null , 
  description VARCHAR(2000), 
  warehouse_id BIGINT not null , 
  master_production_schedule_id BIGINT not null , 
  cutoff_date DATE NOT NULL, 
  item_id BIGINT not null , 
  total_required_quantity BIGINT not null ,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
 

CREATE TABLE material_requirements_planning_line (
  material_requirements_planning_line_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT not null , 
  item_id BIGINT not null , 
  parent_mrp_line_id BIGINT,
  material_requirements_planning_id BIGINT not null , 
  bill_of_material_id BIGINT , 
  total_required_quantity BIGINT not null , 
  required_quantity BIGINT not null , 
  expected_inventory_on_hand BIGINT not null , 
  expected_receive_quantity BIGINT not null , 
  expected_order_quantity BIGINT not null , 
  expected_work_order_quantity BIGINT not null , 
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(material_requirements_planning_id) references material_requirements_planning(material_requirements_planning_id),
  foreign key(bill_of_material_id) references bill_of_material(bill_of_material_id)
);
 
 CREATE TABLE mrp_production_line (
  material_requirements_planning_id    BIGINT NOT NULL,
  production_line_id    BIGINT NOT NULL,
  foreign key(material_requirements_planning_id) references material_requirements_planning(material_requirements_planning_id),
  foreign key(production_line_id) references production_line(production_line_id),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);