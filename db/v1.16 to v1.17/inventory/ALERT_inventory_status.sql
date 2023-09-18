ALTER TABLE inventory_status ADD COLUMN reason_required_when_receiving BOOLEAN;

ALTER TABLE inventory_status ADD COLUMN reason_required_when_producing BOOLEAN;

ALTER TABLE inventory_status ADD COLUMN reason_required_when_adjusting BOOLEAN;

ALTER TABLE inventory_status ADD COLUMN reason_optional_when_receiving BOOLEAN;

ALTER TABLE inventory_status ADD COLUMN reason_optional_when_producing BOOLEAN;

ALTER TABLE inventory_status ADD COLUMN reason_optional_when_adjusting BOOLEAN;