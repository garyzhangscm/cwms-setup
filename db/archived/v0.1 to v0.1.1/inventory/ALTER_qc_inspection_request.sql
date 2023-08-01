
ALTER TABLE qc_inspection_request ADD COLUMN item_id BIGINT;
ALTER TABLE qc_inspection_request ADD COLUMN work_order_id BIGINT;
ALTER TABLE qc_inspection_request ADD COLUMN receipt_id BIGINT; 


ALTER TABLE qc_inspection_request ADD FOREIGN KEY (item_id) REFERENCES item(item_id);


ALTER TABLE qc_inspection_request ADD COLUMN qc_inspection_request_type VARCHAR(50);
update  qc_inspection_request set qc_inspection_request_type = "BY_INVENTORY" WHERE inventory_id is not null;
update  qc_inspection_request set qc_inspection_request_type = "BY_ITEM" WHERE item_id is not null;
update  qc_inspection_request set qc_inspection_request_type = "BY_WORK_ORDER_SAMPLING" WHERE work_order_qc_sample_id is not null;



ALTER TABLE qc_inspection_request ADD COLUMN document_urls VARCHAR(5000);