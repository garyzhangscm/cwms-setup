 
ALTER TABLE outbound_order ADD COLUMN allow_for_manual_pick BOOLEAN;

update outbound_order set allow_for_manual_pick = false;

