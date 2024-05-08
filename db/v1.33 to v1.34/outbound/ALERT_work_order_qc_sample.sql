 
ALTER TABLE work_order_qc_sample ADD removed BOOLEAN default FALSE;


update work_order_qc_sample set removed = false;