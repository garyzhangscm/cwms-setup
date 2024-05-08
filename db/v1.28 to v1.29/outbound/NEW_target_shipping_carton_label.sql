DROP TABLE if exists target_shipping_carton_label; 



CREATE TABLE target_shipping_carton_label (
  target_shipping_carton_label_id      BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  warehouse_id   BIGINT NOT NULL,   
  partner_id VARCHAR(100)  NOT NULL,
  doc_type VARCHAR(100)  NOT NULL,
  po_number VARCHAR(100)  NOT NULL,
  po_date VARCHAR(100)  NOT NULL,   
  ship_to_name VARCHAR(200) ,
  address_1 VARCHAR(300) ,
  city_state_zip VARCHAR(100) ,
  zip_420 VARCHAR(50) ,
  line_item_number VARCHAR(50) ,
  UOM VARCHAR(100) ,
  piece_carton VARCHAR(100) ,
  item_number VARCHAR(100) ,
  customer_sku VARCHAR(100) ,
  UPC VARCHAR(100) ,
  weight VARCHAR(100) ,
  shipped_quantity VARCHAR(100) ,
  order_quantity VARCHAR(100) ,
  SSCC18 VARCHAR(100) ,
  ship_date VARCHAR(100) ,
  BOL VARCHAR(100) ,
  SCAC VARCHAR(100) ,
  freight_type VARCHAR(100) ,
  ship_id VARCHAR(100) ,
  dpci_dashed VARCHAR(100) ,
  GTIN VARCHAR(100) ,
  pallet_pick_label_content_id LONG,
  last_print_time DATETIME,
  created_time DATETIME,
  created_by VARCHAR(50),
  last_modified_time DATETIME,
  last_modified_by VARCHAR(50));
 