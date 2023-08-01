ALTER TABLE printing_request  ADD COLUMN report_url varchar(1000);
ALTER TABLE printing_request modify COLUMN report_history_id BIGINT;
ALTER TABLE printing_request  ADD COLUMN type varchar(100);


ALTER TABLE printing_request  ADD COLUMN result varchar(20);
ALTER TABLE printing_request  ADD COLUMN error_message varchar(500);