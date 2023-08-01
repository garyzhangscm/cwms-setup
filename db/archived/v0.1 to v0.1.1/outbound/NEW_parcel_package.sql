 

DROP TABLE IF EXISTS parcel_package; 

CREATE TABLE parcel_package (
  parcel_package_id    BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL,  
  warehouse_id BIGINT NOT NULL,
  tracking_code VARCHAR(100),
  tracking_url VARCHAR(250),
  status VARCHAR(50),
  shipment_id VARCHAR(100),
  length double,
  width double,
  height double,
  weight double,
  carrier VARCHAR(50),
  service VARCHAR(50),
  delivery_days int,
  rate double,
  label_resolution VARCHAR(100),
  label_size VARCHAR(25),
  label_url VARCHAR(250),
  insurance VARCHAR(25),
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50)
);

