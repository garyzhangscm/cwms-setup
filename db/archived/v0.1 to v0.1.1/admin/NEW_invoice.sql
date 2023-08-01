 
 
DROP TABLE IF EXISTS invoice_line; 
DROP TABLE IF EXISTS invoice; 

CREATE TABLE invoice (
  invoice_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  company_id BIGINT,
  warehouse_id BIGINT,
  client_id BIGINT,
  number VARCHAR(50) not null,
  reference_number VARCHAR(200),
  comment  VARCHAR(2000),
  start_time datetime,
  end_time datetime, 
  total_charge double not  null,
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50)
);

CREATE TABLE invoice_line (
  invoice_line_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  invoice_id BIGINT  NOT NULL, 
  billing_request_id  BIGINT  NOT NULL, 
  billable_category VARCHAR(50) NOT NULL,
  amount double not  null,
  rate double not  null,
  total_charge double not  null,
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50),
  foreign key(invoice_id) references invoice(invoice_id)
);
