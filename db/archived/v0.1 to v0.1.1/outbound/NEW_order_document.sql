 

DROP TABLE IF EXISTS outbound_order_document; 

CREATE TABLE outbound_order_document (
  outbound_order_document_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  warehouse_id BIGINT NOT NULL,
  uploaded_username varchar(100) not null,
  file_name varchar(200) not null,   
  outbound_order_id BIGINT,  
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50),
  foreign key(outbound_order_id) references outbound_order(outbound_order_id)
);
 
