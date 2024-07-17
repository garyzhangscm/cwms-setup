 

DROP TABLE IF EXISTS receiving_lpn_label_font_size; 

CREATE TABLE receiving_lpn_label_font_size (
  receiving_lpn_label_font_size_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  characters_per_line BIGINT NOT NULL,
  base_size BIGINT NOT NULL,
  base_size_line_count BIGINT NOT NULL,
  step  BIGINT NOT NULL,
  warehouse_id BIGINT NOT NULL,
  type VARCHAR(20),
  enabled BOOLEAN not null,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);
