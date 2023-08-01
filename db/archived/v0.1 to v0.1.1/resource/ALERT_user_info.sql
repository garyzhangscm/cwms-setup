ALTER TABLE user_info ADD COLUMN is_system_admin boolean not null default false;

ALTER TABLE user_info ADD COLUMN last_login_company_id BIGINT;
ALTER TABLE user_info ADD COLUMN last_login_warehouse_id BIGINT;
ALTER TABLE user_info ADD COLUMN last_login_token VARCHAR(100);


ALTER TABLE user_info ADD COLUMN department_id BIGINT;
ALTER TABLE user_info ADD CONSTRAINT fk_department_id FOREIGN KEY (department_id) REFERENCES department(department_id);
ALTER TABLE user_info ADD COLUMN position VARCHAR(100);
ALTER TABLE user_info ADD COLUMN on_board_time DATETIME;
ALTER TABLE user_info ADD COLUMN worker_type VARCHAR(50);


ALTER TABLE user_info ADD COLUMN email VARCHAR(100);
update user_info set email = (select   email from user_auth where user_auth.username = user_info.username limit 1)


ALTER TABLE user_info ADD COLUMN type VARCHAR(20);