

DROP TABLE IF EXISTS company_menu; 

CREATE TABLE company_menu (
  company_menu_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,
  menu_id bigint not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(menu_id) references menu(menu_id));

