ALTER TABLE integration_bill_of_material ADD COLUMN created_time DATETIME;
ALTER TABLE integration_bill_of_material ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_bill_of_material ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_bill_of_material ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_bill_of_material MODIFY insert_time DATETIME;
ALTER TABLE integration_bill_of_material MODIFY last_update_time DATETIME;
update integration_bill_of_material set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG'; 

ALTER TABLE integration_bill_of_material_by_product ADD COLUMN created_time DATETIME;
ALTER TABLE integration_bill_of_material_by_product ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_bill_of_material_by_product ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_bill_of_material_by_product ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_bill_of_material_by_product MODIFY insert_time DATETIME;
ALTER TABLE integration_bill_of_material_by_product MODIFY last_update_time DATETIME;
update integration_bill_of_material_by_product set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG'; 


ALTER TABLE integration_bill_of_material_line ADD COLUMN created_time DATETIME;
ALTER TABLE integration_bill_of_material_line ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_bill_of_material_line ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_bill_of_material_line ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_bill_of_material_line MODIFY insert_time DATETIME;
ALTER TABLE integration_bill_of_material_line MODIFY last_update_time DATETIME;
update integration_bill_of_material_line set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG'; 


ALTER TABLE integration_client ADD COLUMN created_time DATETIME;
ALTER TABLE integration_client ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_client ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_client ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_client MODIFY insert_time DATETIME;
ALTER TABLE integration_client MODIFY last_update_time DATETIME;
update integration_client set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_customer ADD COLUMN created_time DATETIME;
ALTER TABLE integration_customer ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_customer ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_customer ADD COLUMN  last_modified_by VARCHAR(50);
 
ALTER TABLE integration_customer MODIFY insert_time DATETIME;
ALTER TABLE integration_customer MODIFY last_update_time DATETIME;
update integration_customer set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_inventory_adjustment_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_inventory_adjustment_confirmation MODIFY last_update_time DATETIME;
update integration_inventory_adjustment_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_inventory_attribute_change_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_inventory_attribute_change_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_inventory_attribute_change_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_inventory_attribute_change_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 



ALTER TABLE integration_inventory_attribute_change_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_inventory_attribute_change_confirmation MODIFY last_update_time DATETIME;
update integration_inventory_attribute_change_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_inventory_shippping_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_inventory_shippping_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_inventory_shippping_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_inventory_shippping_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_inventory_shippping_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_inventory_shippping_confirmation MODIFY last_update_time DATETIME;
update integration_inventory_shippping_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_item ADD COLUMN created_time DATETIME;
ALTER TABLE integration_item ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_item ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_item ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_item MODIFY insert_time DATETIME;
ALTER TABLE integration_item MODIFY last_update_time DATETIME;
update integration_item set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_item_family ADD COLUMN created_time DATETIME;
ALTER TABLE integration_item_family ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_item_family ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_item_family ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_item_family MODIFY insert_time DATETIME;
ALTER TABLE integration_item_family MODIFY last_update_time DATETIME;
update integration_item_family set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_item_package_type ADD COLUMN created_time DATETIME;
ALTER TABLE integration_item_package_type ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_item_package_type ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_item_package_type ADD COLUMN  last_modified_by VARCHAR(50);

ALTER TABLE integration_item_package_type MODIFY insert_time DATETIME;
ALTER TABLE integration_item_package_type MODIFY last_update_time DATETIME; 
update integration_item_package_type set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_item_unit_of_measure ADD COLUMN created_time DATETIME;
ALTER TABLE integration_item_unit_of_measure ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_item_unit_of_measure ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_item_unit_of_measure ADD COLUMN  last_modified_by VARCHAR(50);

ALTER TABLE integration_item_unit_of_measure MODIFY insert_time DATETIME;
ALTER TABLE integration_item_unit_of_measure MODIFY last_update_time DATETIME;  
update integration_item_unit_of_measure set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_order ADD COLUMN created_time DATETIME;
ALTER TABLE integration_order ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_order ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_order ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_order MODIFY insert_time DATETIME;
ALTER TABLE integration_order MODIFY last_update_time DATETIME;  
update integration_order set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_order_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_order_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_order_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_order_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_order_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_order_confirmation MODIFY last_update_time DATETIME; 
update integration_order_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_order_line ADD COLUMN created_time DATETIME;
ALTER TABLE integration_order_line ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_order_line ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_order_line ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_order_line MODIFY insert_time DATETIME;
ALTER TABLE integration_order_line MODIFY last_update_time DATETIME; 
update integration_order_line set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_order_line_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_order_line_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_order_line_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_order_line_confirmation ADD COLUMN  last_modified_by VARCHAR(50);

ALTER TABLE integration_order_line_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_order_line_confirmation MODIFY last_update_time DATETIME;  
update integration_order_line_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_receipt ADD COLUMN created_time DATETIME;
ALTER TABLE integration_receipt ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_receipt ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_receipt ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_receipt MODIFY insert_time DATETIME;
ALTER TABLE integration_receipt MODIFY last_update_time DATETIME;  
update integration_receipt set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_receipt_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_receipt_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_receipt_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_receipt_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_receipt_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_receipt_confirmation MODIFY last_update_time DATETIME;  
update integration_receipt_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_receipt_line ADD COLUMN created_time DATETIME;
ALTER TABLE integration_receipt_line ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_receipt_line ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_receipt_line ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_receipt_line MODIFY insert_time DATETIME;
ALTER TABLE integration_receipt_line MODIFY last_update_time DATETIME;  
update integration_receipt_line set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_receipt_line_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_receipt_line_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_receipt_line_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_receipt_line_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_receipt_line_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_receipt_line_confirmation MODIFY last_update_time DATETIME;  
update integration_receipt_line_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_shipment_line_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_shipment_line_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_shipment_line_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_shipment_line_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_shipment_line_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_shipment_line_confirmation MODIFY last_update_time DATETIME;  
update integration_shipment_line_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_supplier ADD COLUMN created_time DATETIME;
ALTER TABLE integration_supplier ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_supplier ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_supplier ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_supplier MODIFY insert_time DATETIME;
ALTER TABLE integration_supplier MODIFY last_update_time DATETIME;  
update integration_supplier set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_work_order ADD COLUMN created_time DATETIME;
ALTER TABLE integration_work_order ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_work_order ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_work_order ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_work_order MODIFY insert_time DATETIME;
ALTER TABLE integration_work_order MODIFY last_update_time DATETIME;  
update integration_work_order set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_work_order_by_product ADD COLUMN created_time DATETIME;
ALTER TABLE integration_work_order_by_product ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_work_order_by_product ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_work_order_by_product ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_work_order_by_product MODIFY insert_time DATETIME;
ALTER TABLE integration_work_order_by_product MODIFY last_update_time DATETIME;  
update integration_work_order_by_product set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_work_order_by_product_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_work_order_by_product_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_work_order_by_product_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_work_order_by_product_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_work_order_by_product_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_work_order_by_product_confirmation MODIFY last_update_time DATETIME;  
update integration_work_order_by_product_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_work_order_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_work_order_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_work_order_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_work_order_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_work_order_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_work_order_confirmation MODIFY last_update_time DATETIME;  
update integration_work_order_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_work_order_instruction ADD COLUMN created_time DATETIME;
ALTER TABLE integration_work_order_instruction ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_work_order_instruction ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_work_order_instruction ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_work_order_instruction MODIFY insert_time DATETIME;
ALTER TABLE integration_work_order_instruction MODIFY last_update_time DATETIME;  
update integration_work_order_instruction set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_work_order_instruction_template ADD COLUMN created_time DATETIME;
ALTER TABLE integration_work_order_instruction_template ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_work_order_instruction_template ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_work_order_instruction_template ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_work_order_instruction_template MODIFY insert_time DATETIME;
ALTER TABLE integration_work_order_instruction_template MODIFY last_update_time DATETIME;  
update integration_work_order_instruction_template set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_work_order_line ADD COLUMN created_time DATETIME;
ALTER TABLE integration_work_order_line ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_work_order_line ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_work_order_line ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_work_order_line MODIFY insert_time DATETIME;
ALTER TABLE integration_work_order_line MODIFY last_update_time DATETIME;  
update integration_work_order_line set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';
 

ALTER TABLE integration_work_order_line_confirmation ADD COLUMN created_time DATETIME;
ALTER TABLE integration_work_order_line_confirmation ADD COLUMN  created_by VARCHAR(50);
ALTER TABLE integration_work_order_line_confirmation ADD COLUMN  last_modified_time DATETIME;
ALTER TABLE integration_work_order_line_confirmation ADD COLUMN  last_modified_by VARCHAR(50); 

ALTER TABLE integration_work_order_line_confirmation MODIFY insert_time DATETIME;
ALTER TABLE integration_work_order_line_confirmation MODIFY last_update_time DATETIME;  
update integration_work_order_line_confirmation set created_time = insert_time, created_by = 'GZHANG', last_modified_time = last_update_time, last_modified_by = 'GZHANG';



ALTER TABLE integration_inventory_attribute_change_confirmation ADD COLUMN  company_id BIGINT; 
ALTER TABLE integration_inventory_attribute_change_confirmation ADD COLUMN  company_code VARCHAR(100); 
 

ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN  company_id BIGINT; 
ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN  company_code VARCHAR(100); 



ALTER TABLE integration_order_confirmation ADD COLUMN  company_id BIGINT; 
ALTER TABLE integration_order_confirmation ADD COLUMN  company_code VARCHAR(100); 



ALTER TABLE integration_receipt_confirmation ADD COLUMN  company_id BIGINT; 
ALTER TABLE integration_receipt_confirmation ADD COLUMN  company_code VARCHAR(100); 


ALTER TABLE integration_work_order_confirmation ADD COLUMN  company_id BIGINT; 
ALTER TABLE integration_work_order_confirmation ADD COLUMN  company_code VARCHAR(100); 