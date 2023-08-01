ALTER TABLE easy_post_carrier Add COLUMN print_parcel_label_after_manifest boolean not null default 1;


update easy_post_carrier set print_parcel_label_after_manifest = 1;

ALTER TABLE easy_post_carrier Add COLUMN schedule_pickup_after_manifest boolean not null default 1;


update easy_post_carrier set schedule_pickup_after_manifest = 1;


ALTER TABLE easy_post_carrier Add COLUMN label_copy_count INTEGER;


update easy_post_carrier set label_copy_count = 1;

ALTER TABLE easy_post_carrier Add COLUMN min_pickup_time TIME;
ALTER TABLE easy_post_carrier Add COLUMN max_pickup_time TIME;
