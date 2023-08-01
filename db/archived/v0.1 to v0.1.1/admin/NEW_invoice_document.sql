 
 
DROP TABLE IF EXISTS invoice_document;  
 

CREATE TABLE invoice_document (
  invoice_document_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  invoice_id BIGINT  NOT NULL,  
  file_name VARCHAR(50) NOT NULL,
  remote_file_name VARCHAR(70) NOT NULL, 
  created_time datetime,
  created_by VARCHAR(50),
  last_modified_time datetime,
  last_modified_by VARCHAR(50),
  foreign key(invoice_id) references invoice(invoice_id)
);
