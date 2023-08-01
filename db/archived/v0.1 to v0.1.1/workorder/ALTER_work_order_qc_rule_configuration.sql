

ALTER TABLE work_order_qc_rule_configuration ADD COLUMN company_id BIGINT;
ALTER TABLE work_order_qc_rule_configuration ADD COLUMN item_family_id BIGINT;
ALTER TABLE work_order_qc_rule_configuration ADD COLUMN item_id BIGINT;
ALTER TABLE work_order_qc_rule_configuration ADD COLUMN outbound_order_id BIGINT;
ALTER TABLE work_order_qc_rule_configuration ADD COLUMN customer_id BIGINT; 

ALTER TABLE work_order_qc_rule_configuration ADD COLUMN qc_quantity_per_work_order BIGINT;
ALTER TABLE work_order_qc_rule_configuration ADD COLUMN qc_percentage_per_work_order double;
ALTER TABLE work_order_qc_rule_configuration ADD COLUMN from_inventory_status_id BIGINT;
ALTER TABLE work_order_qc_rule_configuration ADD COLUMN to_inventory_status_id BIGINT  NOT NULL;
ALTER TABLE work_order_qc_rule_configuration ADD COLUMN inventory_lock_id BIGINT;
ALTER TABLE work_order_qc_rule_configuration ADD COLUMN future_inventory_lock_id BIGINT;


ALTER TABLE work_order_qc_rule_configuration MODIFY warehouse_id BIGINT;

update work_order_qc_rule_configuration set company_id = 1



ALTER TABLE work_order_qc_rule_configuration MODIFY to_inventory_status_id BIGINT;


 