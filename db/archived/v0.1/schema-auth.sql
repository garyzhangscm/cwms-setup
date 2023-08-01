-- User

DROP TABLE IF EXISTS user_auth;

CREATE TABLE user_auth (
  user_auth_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT NOT NULL,
  username   VARCHAR(100) NOT NULL ,
  password  VARCHAR(100) NOT NULL,
  enabled boolean not null default 0,
  locked boolean not null default 0,
  email  VARCHAR(100)
);

-- You may need to create a super user that has access to everything, to start build your environment
INSERT INTO user_auth (company_id, username, password, enabled, locked, email) VALUES (-1, "USERNAME", "PASSWORD",1, 0, "xxxxxxxx@gmail.com");

