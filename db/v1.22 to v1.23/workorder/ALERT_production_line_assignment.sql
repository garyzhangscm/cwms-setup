ALTER TABLE production_line_assignment ADD COLUMN assigned_time DATETIME;

update production_line_assignment set assigned_time = created_time where 1=1;


ALTER TABLE production_line_assignment ADD COLUMN deassigned_time DATETIME;


ALTER TABLE production_line_assignment ADD COLUMN deassigned BOOLEAN;

update production_line_assignment set deassigned = false where 1=1;



