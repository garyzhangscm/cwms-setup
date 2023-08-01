
ALTER TABLE qc_rule_item ADD COLUMN enabled BOOLEAN not null default 1;

update qc_rule_item set enabled = 1 ;