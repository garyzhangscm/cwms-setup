 
update wave set status = 'COMPLETED' 
where not exists (select 'x' from shipment_line
                    where wave.wave_id = shipment_line.wave_id
					  and shipment_line.status != 'DISPATCHED'
					  and shipment_line.status != 'CANCELLED')