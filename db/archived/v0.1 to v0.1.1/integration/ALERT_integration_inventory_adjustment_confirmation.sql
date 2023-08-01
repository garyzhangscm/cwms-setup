ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN inventory_quantity_change_type VARCHAR(50);
ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN document_number VARCHAR(100); 
ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN comment VARCHAR(2000); 



ALTER TABLE integration_inventory_adjustment_confirmation ADD COLUMN quickbook_listid VARCHAR(50) ; 