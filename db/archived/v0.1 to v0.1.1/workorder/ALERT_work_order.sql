ALTER TABLE work_order ADD COLUMN material_consume_timing VARCHAR(25);
ALTER TABLE work_order ADD COLUMN consume_by_bom_only boolean;
ALTER TABLE work_order ADD COLUMN consume_by_bom_id BIGINT;




ALTER TABLE work_order ADD COLUMN qc_quantity BIGINT;
ALTER TABLE work_order ADD COLUMN qc_percentage double;
ALTER TABLE work_order ADD COLUMN qc_quantity_requested BIGINT;
ALTER TABLE work_order ADD COLUMN qc_quantity_completed BIGINT;
ALTER TABLE work_order ADD COLUMN bto_outbound_order_id BIGINT;
ALTER TABLE work_order ADD COLUMN bto_customer_id BIGINT;


ALTER TABLE work_order ADD COLUMN short_allocation_id BIGINT;