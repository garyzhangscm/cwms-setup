ALTER TABLE inventory_activity ALTER COLUMN [type] VARCHAR(50);

update inventory_activity set type = 'INVENTORY_MOVEMENT' where type = "0";

update inventory_activity set type = 'RECEIVING' where type = "1";

update inventory_activity set type = 'REVERSE_RECEIVING' where type = "2";

update inventory_activity set type = 'WORK_ORDER_PRODUCING' where type = "3";

update inventory_activity set type = 'WORK_ORDER_CONSUME' where type = "4";

update inventory_activity set type = 'WORK_ORDER_RETURN_MATERIAL' where type = "5";

update inventory_activity set type = 'PICKING' where type = "6";

update inventory_activity set type = 'UNPICKING' where type = "7";

update inventory_activity set type = 'COUNT' where type = "8";

update inventory_activity set type = 'CYCLE_COUNT' where type = "9";

update inventory_activity set type = 'AUDIT_COUNT' where type = "10";

update inventory_activity set type = 'INVENTORY_ADJUSTMENT' where type = "11";

update inventory_activity set type = 'SPLIT_FOR_INVENTORY_ADJUSTMENT' where type = "12";

update inventory_activity set type = 'INVENTORY_CONSOLIDATION' where type = "13";

update inventory_activity set type = 'INVENTORY_SPLIT' where type = "14";

update inventory_activity set type = 'RELABEL_LPN' where type = "15";

update inventory_activity set type = 'INVENTORY_STATUS_CHANGE' where type = "16";

update inventory_activity set type = 'INVENTORY_PACKAGE_TYPE_CHANGE' where type = "17";

update inventory_activity set type = 'REVERSE_PRODUCTION' where type = "18";

update inventory_activity set type = 'REVERSE_BY_PRODUCT' where type = "19"; 