-- Adminer 4.8.1 MySQL 8.0.32 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DELIMITER ;;

DROP EVENT IF EXISTS `WO-Location-Auto`;;
CREATE EVENT `WO-Location-Auto` ON SCHEDULE EVERY 1 MINUTE STARTS '2021-10-20 09:36:36' ON COMPLETION NOT PRESERVE ENABLE DO insert into location (
name, warehouse_id, location_group_id, enabled, locked
)

select number, warehouse_id, 40, 1, 1 from work_order 
where not exists (select *
     from location l
     where  l.name = work_order.number);;

DELIMITER ;

SET NAMES utf8mb4;


DROP TABLE IF EXISTS `abc_category`;
CREATE TABLE `abc_category` (
  `abc_category_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(500) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`abc_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `alert`;
CREATE TABLE `alert` (
  `alert_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `type` varchar(50) NOT NULL,
  `key_words` varchar(2000) NOT NULL,
  `title` varchar(2000) NOT NULL,
  `message` varchar(11000) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `last_sent_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `parameters` text,
  PRIMARY KEY (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `alert_subscription`;
CREATE TABLE `alert_subscription` (
  `alert_subscription_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `type` varchar(50) NOT NULL,
  `delivery_channel` varchar(50) NOT NULL,
  `key_words_list` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`alert_subscription_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `alert_subscription_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `alert_template`;
CREATE TABLE `alert_template` (
  `alert_template_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `type` varchar(50) NOT NULL,
  `delivery_channel` varchar(50) NOT NULL,
  `template` varchar(5000) NOT NULL,
  `read_date` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`alert_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `allocation_configuration`;
CREATE TABLE `allocation_configuration` (
  `allocation_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `sequence` int NOT NULL,
  `type` varchar(20) NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `location_group_id` bigint DEFAULT NULL,
  `location_group_type_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  PRIMARY KEY (`allocation_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `allocation_configuration_pickable_unit_of_measure`;
CREATE TABLE `allocation_configuration_pickable_unit_of_measure` (
  `allocation_configuration_pickable_unit_of_measure_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `unit_of_measure_id` bigint NOT NULL,
  `allocation_configuration_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`allocation_configuration_pickable_unit_of_measure_id`),
  KEY `allocation_configuration_id` (`allocation_configuration_id`),
  CONSTRAINT `allocation_configuration_pickable_unit_of_measure_ibfk_1` FOREIGN KEY (`allocation_configuration_id`) REFERENCES `allocation_configuration` (`allocation_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `allocation_transaction_history`;
CREATE TABLE `allocation_transaction_history` (
  `allocation_transaction_history_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(20) NOT NULL,
  `transaction_group_id` varchar(20) NOT NULL,
  `order_number` varchar(100) DEFAULT NULL,
  `shipment_line_id` bigint DEFAULT NULL,
  `work_order_number` varchar(20) DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `location_name` varchar(100) DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `total_required_quantity` bigint DEFAULT NULL,
  `current_required_quantity` bigint DEFAULT NULL,
  `total_inventory_quantity` bigint DEFAULT NULL,
  `total_available_quantity` bigint DEFAULT NULL,
  `total_allocated_quantity` bigint DEFAULT NULL,
  `already_allocated_quantity` bigint DEFAULT NULL,
  `is_skipped_flag` tinyint(1) DEFAULT NULL,
  `is_allocated_by_lpn_flag` tinyint(1) DEFAULT NULL,
  `is_round_up_flag` tinyint(1) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `message` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `allocate_by_receipt_number` varchar(100) DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `style` varchar(100) DEFAULT NULL,
  `productSize` varchar(100) DEFAULT NULL,
  `product_size` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`allocation_transaction_history_id`),
  KEY `shipment_line_id` (`shipment_line_id`),
  CONSTRAINT `allocation_transaction_history_ibfk_1` FOREIGN KEY (`shipment_line_id`) REFERENCES `shipment_line` (`shipment_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `audit_count_request`;
CREATE TABLE `audit_count_request` (
  `audit_count_request_id` bigint NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(100) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `location_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`audit_count_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `audit_count_result`;
CREATE TABLE `audit_count_result` (
  `audit_count_result_id` bigint NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(100) NOT NULL,
  `location_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `inventory_id` bigint DEFAULT NULL,
  `lpn` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `quantity` int NOT NULL,
  `count_quantity` int NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`audit_count_result_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `audit_count_result_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `bill_of_material`;
CREATE TABLE `bill_of_material` (
  `bill_of_material_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(20) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `expected_quantity` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `bill_of_material_by_product`;
CREATE TABLE `bill_of_material_by_product` (
  `bill_of_material_by_product_id` bigint NOT NULL AUTO_INCREMENT,
  `bill_of_material_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `expected_quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bill_of_material_by_product_id`),
  KEY `bill_of_material_id` (`bill_of_material_id`),
  CONSTRAINT `bill_of_material_by_product_ibfk_1` FOREIGN KEY (`bill_of_material_id`) REFERENCES `bill_of_material` (`bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `bill_of_material_line`;
CREATE TABLE `bill_of_material_line` (
  `bill_of_material_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(20) NOT NULL,
  `bill_of_material_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `expected_quantity` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bill_of_material_line_id`),
  KEY `bill_of_material_id` (`bill_of_material_id`),
  CONSTRAINT `bill_of_material_line_ibfk_1` FOREIGN KEY (`bill_of_material_id`) REFERENCES `bill_of_material` (`bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `billable_activity`;
CREATE TABLE `billable_activity` (
  `billable_activity_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `billable_category` varchar(50) NOT NULL,
  `billable_activity_type_id` bigint DEFAULT NULL,
  `activity_time` datetime DEFAULT NULL,
  `amount` double NOT NULL,
  `rate` double DEFAULT NULL,
  `total_charge` double DEFAULT NULL,
  `document_number` varchar(500) DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`billable_activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `billable_activity_type`;
CREATE TABLE `billable_activity_type` (
  `billable_activity_type_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`billable_activity_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `billable_request`;
CREATE TABLE `billable_request` (
  `billable_request_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `service_name` varchar(50) NOT NULL,
  `web_api_endpoint` varchar(200) NOT NULL,
  `request_method` varchar(50) DEFAULT NULL,
  `request_parameters` varchar(2000) DEFAULT NULL,
  `request_body` varchar(2000) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `token` varchar(100) NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `rate` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`billable_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `billing_rate`;
CREATE TABLE `billing_rate` (
  `billing_rate_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `billable_category` varchar(50) NOT NULL,
  `rate` double NOT NULL,
  `billing_cycle` varchar(20) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`billing_rate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `billing_request`;
CREATE TABLE `billing_request` (
  `billing_request_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `number` varchar(50) NOT NULL,
  `billable_category` varchar(50) NOT NULL,
  `rate` double NOT NULL,
  `billing_cycle` varchar(20) NOT NULL,
  `total_amount` double DEFAULT NULL,
  `total_charge` double DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`billing_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `billing_request_line`;
CREATE TABLE `billing_request_line` (
  `billing_request_line_id` bigint NOT NULL AUTO_INCREMENT,
  `billing_request_id` bigint NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `total_amount` double DEFAULT NULL,
  `total_charge` double DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `document_number` varchar(500) DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`billing_request_line_id`),
  KEY `billing_request_id` (`billing_request_id`),
  CONSTRAINT `billing_request_line_ibfk_1` FOREIGN KEY (`billing_request_id`) REFERENCES `billing_request` (`billing_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `bulk_pick`;
CREATE TABLE `bulk_pick` (
  `bulk_pick_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(50) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `wave_number` varchar(50) NOT NULL,
  `source_location_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `quantity` bigint NOT NULL,
  `picked_quantity` bigint NOT NULL,
  `picking_by_user_id` bigint DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `unit_of_measure_id` bigint NOT NULL,
  `work_task_id` bigint DEFAULT NULL,
  `confirm_item_flag` tinyint(1) NOT NULL,
  `confirm_location_flag` tinyint(1) NOT NULL,
  `confirm_location_code_flag` tinyint(1) NOT NULL,
  `confirm_lpn_flag` tinyint(1) NOT NULL,
  `color` varchar(100) DEFAULT NULL,
  `product_size` varchar(100) DEFAULT NULL,
  `style` varchar(100) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `acknowledged_username` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bulk_pick_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `bulk_pick_configuration`;
CREATE TABLE `bulk_pick_configuration` (
  `bulk_pick_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `pick_sort_direction` varchar(50) DEFAULT NULL,
  `enabled_for_outbound` tinyint(1) NOT NULL,
  `enabled_for_work_order` tinyint(1) NOT NULL,
  `release_to_work_task` tinyint(1) NOT NULL,
  `work_task_priority` int DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`bulk_pick_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `cancelled_pick`;
CREATE TABLE `cancelled_pick` (
  `cancelled_pick_id` bigint NOT NULL AUTO_INCREMENT,
  `pick_id` bigint NOT NULL,
  `pick_number` varchar(100) NOT NULL,
  `number` varchar(100) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `source_location_id` bigint NOT NULL,
  `destination_location_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `type` varchar(20) NOT NULL,
  `shipment_line_id` bigint DEFAULT NULL,
  `work_order_line_id` bigint DEFAULT NULL,
  `short_allocation_id` bigint DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `picked_quantity` bigint NOT NULL,
  `cancelled_quantity` bigint NOT NULL,
  `pick_list_id` bigint DEFAULT NULL,
  `inventory_status_id` bigint NOT NULL,
  `cartonization_id` bigint DEFAULT NULL,
  `cancelled_username` varchar(100) NOT NULL,
  `cancelled_date` datetime NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cancelled_pick_id`),
  UNIQUE KEY `number_warehouse_id` (`number`,`warehouse_id`),
  KEY `shipment_line_id` (`shipment_line_id`),
  KEY `pick_list_id` (`pick_list_id`),
  KEY `short_allocation_id` (`short_allocation_id`),
  KEY `cartonization_id` (`cartonization_id`),
  CONSTRAINT `cancelled_pick_ibfk_1` FOREIGN KEY (`shipment_line_id`) REFERENCES `shipment_line` (`shipment_line_id`),
  CONSTRAINT `cancelled_pick_ibfk_3` FOREIGN KEY (`short_allocation_id`) REFERENCES `short_allocation` (`short_allocation_id`),
  CONSTRAINT `cancelled_pick_ibfk_4` FOREIGN KEY (`cartonization_id`) REFERENCES `cartonization` (`cartonization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `cancelled_short_allocation`;
CREATE TABLE `cancelled_short_allocation` (
  `cancelled_short_allocation_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `shipment_line_id` bigint DEFAULT NULL,
  `work_order_line_id` bigint DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `open_quantity` bigint NOT NULL,
  `inprocess_quantity` bigint NOT NULL,
  `delivered_quantity` bigint NOT NULL,
  `allocation_count` bigint NOT NULL,
  `status` varchar(20) NOT NULL,
  `cancelled_quantity` bigint NOT NULL,
  `cancelled_username` varchar(100) NOT NULL,
  `cancelled_date` datetime NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cancelled_short_allocation_id`),
  KEY `shipment_line_id` (`shipment_line_id`),
  CONSTRAINT `cancelled_short_allocation_ibfk_1` FOREIGN KEY (`shipment_line_id`) REFERENCES `shipment_line` (`shipment_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `carrier`;
CREATE TABLE `carrier` (
  `carrier_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `contactor_firstname` varchar(100) DEFAULT NULL,
  `contactor_lastname` varchar(100) DEFAULT NULL,
  `address_country` varchar(100) DEFAULT NULL,
  `address_state` varchar(100) DEFAULT NULL,
  `address_county` varchar(100) DEFAULT NULL,
  `address_city` varchar(100) DEFAULT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) DEFAULT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(25) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `user_defined_field_1` varchar(100) DEFAULT NULL,
  `user_defined_field_2` varchar(100) DEFAULT NULL,
  `user_defined_field_3` varchar(100) DEFAULT NULL,
  `user_defined_field_4` varchar(100) DEFAULT NULL,
  `user_defined_field_5` varchar(100) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `tracking_info_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`carrier_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `carrier_service_level`;
CREATE TABLE `carrier_service_level` (
  `carrier_service_level_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `carrier_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`carrier_service_level_id`),
  KEY `carrier_id` (`carrier_id`),
  CONSTRAINT `carrier_service_level_ibfk_1` FOREIGN KEY (`carrier_id`) REFERENCES `carrier` (`carrier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `carton`;
CREATE TABLE `carton` (
  `carton_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(20) NOT NULL,
  `length` double NOT NULL,
  `width` double NOT NULL,
  `height` double NOT NULL,
  `fill_rate` double NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `shipping_carton_flag` tinyint(1) NOT NULL,
  `picking_carton_flag` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`carton_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `cartonization`;
CREATE TABLE `cartonization` (
  `cartonization_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `group_key_value` varchar(100) NOT NULL,
  `number` varchar(20) NOT NULL,
  `carton_id` bigint NOT NULL,
  `pick_list_id` bigint DEFAULT NULL,
  `carton_status` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cartonization_id`),
  KEY `carton_id` (`carton_id`),
  CONSTRAINT `cartonization_ibfk_1` FOREIGN KEY (`carton_id`) REFERENCES `carton` (`carton_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `cartonization_configuration`;
CREATE TABLE `cartonization_configuration` (
  `cartonization_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `sequence` int NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `pick_type` varchar(20) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cartonization_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `cartonization_configuration_group_rule`;
CREATE TABLE `cartonization_configuration_group_rule` (
  `cartonization_configuration_id` bigint NOT NULL,
  `group_rule` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cartonization_configuration_id`,`group_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `client_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `contactor_firstname` varchar(100) NOT NULL,
  `contactor_lastname` varchar(100) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_county` varchar(100) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) NOT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(25) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `user_defined_field_1` varchar(100) DEFAULT NULL,
  `user_defined_field_2` varchar(100) DEFAULT NULL,
  `user_defined_field_3` varchar(100) DEFAULT NULL,
  `user_defined_field_4` varchar(100) DEFAULT NULL,
  `user_defined_field_5` varchar(100) DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `list_pick_enabled_flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `client_inventory_aging_snapshot`;
CREATE TABLE `client_inventory_aging_snapshot` (
  `client_inventory_aging_snapshot_id` bigint NOT NULL AUTO_INCREMENT,
  `inventory_aging_snapshot_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `average_age_in_days` bigint NOT NULL,
  `average_age_in_weeks` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`client_inventory_aging_snapshot_id`),
  KEY `inventory_aging_snapshot_id` (`inventory_aging_snapshot_id`),
  CONSTRAINT `client_inventory_aging_snapshot_ibfk_1` FOREIGN KEY (`inventory_aging_snapshot_id`) REFERENCES `inventory_aging_snapshot` (`inventory_aging_snapshot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `client_location_utilization_snapshot_batch`;
CREATE TABLE `client_location_utilization_snapshot_batch` (
  `client_location_utilization_snapshot_batch_id` bigint NOT NULL AUTO_INCREMENT,
  `location_utilization_snapshot_batch_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `net_volume` double NOT NULL,
  `gross_volume` double NOT NULL,
  `total_locations` int DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `capacity_unit` varchar(50) DEFAULT NULL,
  `total_lpns` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_location_utilization_snapshot_batch_id`),
  KEY `location_utilization_snapshot_batch_id` (`location_utilization_snapshot_batch_id`),
  CONSTRAINT `client_location_utilization_snapshot_batch_ibfk_1` FOREIGN KEY (`location_utilization_snapshot_batch_id`) REFERENCES `location_utilization_snapshot_batch` (`location_utilization_snapshot_batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `company_id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `contactor_firstname` varchar(100) NOT NULL,
  `contactor_lastname` varchar(100) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_county` varchar(100) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) NOT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `production` tinyint(1) NOT NULL DEFAULT '1',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `short_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `company` (`company_id`, `code`, `name`, `description`, `contactor_firstname`, `contactor_lastname`, `address_country`, `address_state`, `address_county`, `address_city`, `address_district`, `address_line1`, `address_line2`, `address_postcode`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `production`, `enabled`, `short_name`) VALUES
(1,	'20001',	'YOUR-COMPANY',	'Company Name.',	'xxxx',	'yyyy',	'U.S',	'CA',	'LA',	'LA',	'',	'XXXX Main Street',	'',	'90001',	NULL,	NULL,	NULL,	NULL,	1,	1,	NULL);

DROP TABLE IF EXISTS `company_menu`;
CREATE TABLE `company_menu` (
  `company_menu_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `menu_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`company_menu_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `company_menu_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `customer_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `contactor_firstname` varchar(100) NOT NULL,
  `contactor_lastname` varchar(100) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_county` varchar(100) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) NOT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(25) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `user_defined_field_1` varchar(100) DEFAULT NULL,
  `user_defined_field_2` varchar(100) DEFAULT NULL,
  `user_defined_field_3` varchar(100) DEFAULT NULL,
  `user_defined_field_4` varchar(100) DEFAULT NULL,
  `user_defined_field_5` varchar(100) DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `list_pick_enabled_flag` tinyint(1) NOT NULL DEFAULT '0',
  `quickbook_listid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `customer_return_order`;
CREATE TABLE `customer_return_order` (
  `customer_return_order_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `rma_number` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `allow_unexpected_item` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_return_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `customer_return_order_line`;
CREATE TABLE `customer_return_order_line` (
  `customer_return_order_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `received_quantity` bigint NOT NULL,
  `customer_return_order_id` bigint DEFAULT NULL,
  `over_receiving_quantity` bigint NOT NULL,
  `over_receiving_percent` double NOT NULL,
  `qc_quantity` bigint NOT NULL,
  `qc_percentage` double NOT NULL,
  `qc_quantity_requested` bigint NOT NULL,
  `outbound_order_line_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_return_order_line_id`),
  KEY `customer_return_order_id` (`customer_return_order_id`),
  CONSTRAINT `customer_return_order_line_ibfk_1` FOREIGN KEY (`customer_return_order_id`) REFERENCES `customer_return_order` (`customer_return_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `cycle_count_batch`;
CREATE TABLE `cycle_count_batch` (
  `cycle_count_batch_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `batch_id` varchar(100) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cycle_count_batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `cycle_count_request`;
CREATE TABLE `cycle_count_request` (
  `cycle_count_request_id` bigint NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(100) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `location_id` bigint NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cycle_count_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `cycle_count_result`;
CREATE TABLE `cycle_count_result` (
  `cycle_count_result_id` bigint NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(100) NOT NULL,
  `location_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `quantity` int NOT NULL,
  `count_quantity` int NOT NULL,
  `audit_count_request_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cycle_count_result_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `cycle_count_result_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `data_initial_request`;
CREATE TABLE `data_initial_request` (
  `data_initial_request_id` bigint NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `company_code` varchar(50) DEFAULT NULL,
  `warehouse_name` varchar(100) NOT NULL,
  `admin_username` varchar(50) NOT NULL,
  `request_username` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `production` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`data_initial_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `data_transfer_request`;
CREATE TABLE `data_transfer_request` (
  `data_transfer_request_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `number` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`data_transfer_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `data_transfer_request_detail`;
CREATE TABLE `data_transfer_request_detail` (
  `data_transfer_request_detail_id` bigint NOT NULL AUTO_INCREMENT,
  `sequence` int NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `tables_name` varchar(50) NOT NULL,
  `data_transfer_request_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`data_transfer_request_detail_id`),
  KEY `data_transfer_request_id` (`data_transfer_request_id`),
  CONSTRAINT `data_transfer_request_detail_ibfk_1` FOREIGN KEY (`data_transfer_request_id`) REFERENCES `data_transfer_request` (`data_transfer_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `easy_post_carrier`;
CREATE TABLE `easy_post_carrier` (
  `easy_post_carrier_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `easy_post_configuration_id` bigint NOT NULL,
  `carrier_id` bigint NOT NULL,
  `account_number` varchar(250) DEFAULT NULL,
  `report_type` varchar(250) NOT NULL,
  `printer_name` varchar(100) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `print_parcel_label_after_manifest` tinyint(1) NOT NULL DEFAULT '1',
  `schedule_pickup_after_manifest` tinyint(1) NOT NULL DEFAULT '1',
  `label_copy_count` int DEFAULT NULL,
  `min_pickup_time` time DEFAULT NULL,
  `max_pickup_time` time DEFAULT NULL,
  PRIMARY KEY (`easy_post_carrier_id`),
  KEY `easy_post_configuration_id` (`easy_post_configuration_id`),
  CONSTRAINT `easy_post_carrier_ibfk_1` FOREIGN KEY (`easy_post_configuration_id`) REFERENCES `easy_post_configuration` (`easy_post_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `easy_post_configuration`;
CREATE TABLE `easy_post_configuration` (
  `easy_post_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `api_key` varchar(250) DEFAULT NULL,
  `webhook_secret` varchar(100) DEFAULT NULL,
  `use_warehouse_address_as_ship_from_flag` tinyint(1) NOT NULL DEFAULT '1',
  `contactor_firstname` varchar(100) DEFAULT NULL,
  `contactor_lastname` varchar(100) DEFAULT NULL,
  `address_country` varchar(100) DEFAULT NULL,
  `address_state` varchar(100) DEFAULT NULL,
  `address_county` varchar(100) DEFAULT NULL,
  `address_city` varchar(100) DEFAULT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) DEFAULT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(10) DEFAULT NULL,
  `use_warehouse_address_as_return_flag` tinyint(1) NOT NULL DEFAULT '1',
  `return_contactor_firstname` varchar(100) DEFAULT NULL,
  `return_contactor_lastname` varchar(100) DEFAULT NULL,
  `return_address_country` varchar(100) DEFAULT NULL,
  `return_address_state` varchar(100) DEFAULT NULL,
  `return_address_county` varchar(100) DEFAULT NULL,
  `return_address_city` varchar(100) DEFAULT NULL,
  `return_address_district` varchar(100) DEFAULT NULL,
  `return_address_line1` varchar(300) DEFAULT NULL,
  `return_address_line2` varchar(300) DEFAULT NULL,
  `return_address_postcode` varchar(10) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `return_address_phone` varchar(25) DEFAULT NULL,
  `address_phone` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`easy_post_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `email_alert_configuration`;
CREATE TABLE `email_alert_configuration` (
  `email_alert_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `host` varchar(200) NOT NULL,
  `port` int NOT NULL,
  `username` varchar(200) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `send_from_email` varchar(200) DEFAULT NULL,
  `transport_protocol` varchar(200) NOT NULL,
  `auth_flag` tinyint(1) NOT NULL,
  `starttls_enable_flag` tinyint(1) NOT NULL,
  `debug_flag` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email_alert_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `emergency_replenishment_configuration`;
CREATE TABLE `emergency_replenishment_configuration` (
  `emergency_replenishment_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `sequence` int NOT NULL,
  `unit_of_measure_id` bigint NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `source_location_id` bigint DEFAULT NULL,
  `source_location_group_id` bigint DEFAULT NULL,
  `destination_location_id` bigint DEFAULT NULL,
  `destination_location_group_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`emergency_replenishment_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `grid_configuration`;
CREATE TABLE `grid_configuration` (
  `grid_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `location_group_id` bigint NOT NULL,
  `pre_assigned_location` tinyint(1) NOT NULL,
  `allow_confirm_by_group` tinyint(1) NOT NULL,
  `deposit_on_confirm` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`grid_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `grid_location_configuration`;
CREATE TABLE `grid_location_configuration` (
  `grid_location_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `location_group_id` bigint NOT NULL,
  `location_id` bigint NOT NULL,
  `row_num` int NOT NULL,
  `column_span` int NOT NULL,
  `sequence` int NOT NULL,
  `permanent_lpn_flag` tinyint(1) NOT NULL,
  `permanent_lpn` varchar(25) DEFAULT NULL,
  `current_lpn` varchar(25) DEFAULT NULL,
  `pending_quantity` bigint NOT NULL,
  `arrived_quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`grid_location_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hualei_configuration`;
CREATE TABLE `hualei_configuration` (
  `hualei_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `customer_id` varchar(50) DEFAULT NULL,
  `customer_userid` varchar(50) DEFAULT NULL,
  `create_order_protocol` varchar(10) DEFAULT NULL,
  `create_order_host` varchar(100) DEFAULT NULL,
  `create_order_port` varchar(10) DEFAULT NULL,
  `create_order_endpoint` varchar(500) DEFAULT NULL,
  `print_label_protocol` varchar(10) DEFAULT NULL,
  `print_label_host` varchar(100) DEFAULT NULL,
  `print_label_port` varchar(10) DEFAULT NULL,
  `print_label_endpoint` varchar(500) DEFAULT NULL,
  `default_cargo_type` varchar(50) DEFAULT NULL,
  `default_customs_clearance` varchar(50) DEFAULT NULL,
  `default_customs_declaration` varchar(50) DEFAULT NULL,
  `default_duty_type` varchar(50) DEFAULT NULL,
  `default_from` varchar(50) DEFAULT NULL,
  `default_is_fba` varchar(50) DEFAULT NULL,
  `default_order_returnsign` varchar(50) DEFAULT NULL,
  `default_hs_code` varchar(50) DEFAULT NULL,
  `default_invoice_title` varchar(50) DEFAULT NULL,
  `default_sku` varchar(50) DEFAULT NULL,
  `default_sku_code` varchar(50) DEFAULT NULL,
  `weight_unit` varchar(20) DEFAULT NULL,
  `length_unit` varchar(20) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `get_package_status_protocol` varchar(10) DEFAULT NULL,
  `get_package_status_host` varchar(100) DEFAULT NULL,
  `get_package_status_port` varchar(10) DEFAULT NULL,
  `get_package_status_endpoint` varchar(500) DEFAULT NULL,
  `get_tracking_number_protocol` varchar(10) DEFAULT NULL,
  `get_tracking_number_host` varchar(100) DEFAULT NULL,
  `get_tracking_number_port` varchar(10) DEFAULT NULL,
  `get_tracking_number_endpoint` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`hualei_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hualei_product`;
CREATE TABLE `hualei_product` (
  `hualei_product_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `product_id` varchar(50) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  PRIMARY KEY (`hualei_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hualei_shipment_request`;
CREATE TABLE `hualei_shipment_request` (
  `hualei_shipment_request_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `get_tracking_number` varchar(1) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `outbound_order_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hualei_shipment_request_id`),
  KEY `outbound_order_id` (`outbound_order_id`),
  CONSTRAINT `hualei_shipment_request_ibfk_1` FOREIGN KEY (`outbound_order_id`) REFERENCES `outbound_order` (`outbound_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hualei_shipment_request_order_invoice_parameters`;
CREATE TABLE `hualei_shipment_request_order_invoice_parameters` (
  `hualei_shipment_request_order_invoice_parameters_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `box_no` varchar(20) DEFAULT NULL,
  `hs_code` varchar(20) DEFAULT NULL,
  `invoice_amount` double DEFAULT NULL,
  `invoice_pcs` double DEFAULT NULL,
  `invoice_title` varchar(100) DEFAULT NULL,
  `invoice_weight` double DEFAULT NULL,
  `weight_unit` varchar(50) DEFAULT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `sku_code` varchar(100) DEFAULT NULL,
  `hualei_shipment_request_parameters_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hualei_shipment_request_order_invoice_parameters_id`),
  KEY `hualei_shipment_request_parameters_id` (`hualei_shipment_request_parameters_id`),
  CONSTRAINT `hualei_shipment_request_order_invoice_parameters_ibfk_1` FOREIGN KEY (`hualei_shipment_request_parameters_id`) REFERENCES `hualei_shipment_request_parameters` (`hualei_shipment_request_parameters_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hualei_shipment_request_order_volume_parameters`;
CREATE TABLE `hualei_shipment_request_order_volume_parameters` (
  `hualei_shipment_request_order_volume_parameters_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `box_no` varchar(20) DEFAULT NULL,
  `child_no` varchar(20) DEFAULT NULL,
  `volume_height` double DEFAULT NULL,
  `volume_length` double DEFAULT NULL,
  `volume_width` double DEFAULT NULL,
  `volume_weight` double DEFAULT NULL,
  `length_unit` varchar(50) DEFAULT NULL,
  `weight_unit` varchar(50) DEFAULT NULL,
  `hualei_shipment_request_parameters_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hualei_shipment_request_order_volume_parameters_id`),
  KEY `hualei_shipment_request_parameters_id` (`hualei_shipment_request_parameters_id`),
  CONSTRAINT `hualei_shipment_request_order_volume_parameters_ibfk_1` FOREIGN KEY (`hualei_shipment_request_parameters_id`) REFERENCES `hualei_shipment_request_parameters` (`hualei_shipment_request_parameters_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hualei_shipment_request_parameters`;
CREATE TABLE `hualei_shipment_request_parameters` (
  `hualei_shipment_request_parameters_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `cargo_type` varchar(10) DEFAULT NULL,
  `consignee_address` varchar(100) DEFAULT NULL,
  `consignee_city` varchar(50) DEFAULT NULL,
  `consignee_name` varchar(100) DEFAULT NULL,
  `consignee_postcode` varchar(20) DEFAULT NULL,
  `consignee_state` varchar(20) DEFAULT NULL,
  `consignee_telephone` varchar(20) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `customer_id` varchar(20) DEFAULT NULL,
  `customer_userid` varchar(20) DEFAULT NULL,
  `customs_clearance` varchar(10) DEFAULT NULL,
  `customs_declaration` varchar(10) DEFAULT NULL,
  `duty_type` varchar(20) DEFAULT NULL,
  `ship_from` varchar(200) DEFAULT NULL,
  `is_fba` varchar(10) DEFAULT NULL,
  `order_customer_invoice_code` varchar(20) DEFAULT NULL,
  `order_piece` int DEFAULT NULL,
  `order_return_sign` varchar(10) DEFAULT NULL,
  `product_id` varchar(20) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `weight_unit` varchar(50) DEFAULT NULL,
  `hualei_shipment_request_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `note` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`hualei_shipment_request_parameters_id`),
  KEY `hualei_shipment_request_id` (`hualei_shipment_request_id`),
  CONSTRAINT `hualei_shipment_request_parameters_ibfk_1` FOREIGN KEY (`hualei_shipment_request_id`) REFERENCES `hualei_shipment_request` (`hualei_shipment_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hualei_shipment_response`;
CREATE TABLE `hualei_shipment_response` (
  `hualei_shipment_response_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `ack` varchar(10) DEFAULT NULL,
  `attr1` varchar(100) DEFAULT NULL,
  `attr2` varchar(100) DEFAULT NULL,
  `delay_type` varchar(100) DEFAULT NULL,
  `is_change_numbers` varchar(10) DEFAULT NULL,
  `is_delay` varchar(10) DEFAULT NULL,
  `is_remote` varchar(10) DEFAULT NULL,
  `is_residential` varchar(10) DEFAULT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `order_id` varchar(20) DEFAULT NULL,
  `order_private_code` varchar(100) DEFAULT NULL,
  `order_transfer_code` varchar(100) DEFAULT NULL,
  `order_price_trial_amount` varchar(50) DEFAULT NULL,
  `order_price_trial_currency` varchar(50) DEFAULT NULL,
  `post_customer_name` varchar(100) DEFAULT NULL,
  `product_track_no_api_type` varchar(100) DEFAULT NULL,
  `reference_number` varchar(100) DEFAULT NULL,
  `return_address` varchar(1000) DEFAULT NULL,
  `tracking_number` varchar(200) DEFAULT NULL,
  `hualei_shipment_request_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hualei_shipment_response_id`),
  KEY `hualei_shipment_request_id` (`hualei_shipment_request_id`),
  CONSTRAINT `hualei_shipment_response_ibfk_1` FOREIGN KEY (`hualei_shipment_request_id`) REFERENCES `hualei_shipment_request` (`hualei_shipment_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hualei_shipment_response_child`;
CREATE TABLE `hualei_shipment_response_child` (
  `hualei_shipment_response_child_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `child_number` varchar(100) DEFAULT NULL,
  `label_info` varchar(100) DEFAULT NULL,
  `hualei_shipment_response_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hualei_shipment_response_child_id`),
  KEY `hualei_shipment_response_id` (`hualei_shipment_response_id`),
  CONSTRAINT `hualei_shipment_response_child_ibfk_1` FOREIGN KEY (`hualei_shipment_response_id`) REFERENCES `hualei_shipment_response` (`hualei_shipment_response_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hualei_shipping_label_format_by_product`;
CREATE TABLE `hualei_shipping_label_format_by_product` (
  `hualei_shipping_label_format_by_product_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `product_id` varchar(20) DEFAULT NULL,
  `shipping_label_format` varchar(50) DEFAULT NULL,
  `tracking_info_url` varchar(500) DEFAULT NULL,
  `hualei_configuration_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`hualei_shipping_label_format_by_product_id`),
  KEY `hualei_configuration_id` (`hualei_configuration_id`),
  CONSTRAINT `hualei_shipping_label_format_by_product_ibfk_1` FOREIGN KEY (`hualei_configuration_id`) REFERENCES `hualei_configuration` (`hualei_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inbound_qc_configuration`;
CREATE TABLE `inbound_qc_configuration` (
  `inbound_qc_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `qc_quantity_per_receipt` bigint DEFAULT NULL,
  `qc_percentage` double DEFAULT NULL,
  `from_inventory_status_id` bigint DEFAULT NULL,
  `to_inventory_status_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inbound_qc_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_bill_of_material`;
CREATE TABLE `integration_bill_of_material` (
  `integration_bill_of_material_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_bill_of_material_by_product`;
CREATE TABLE `integration_bill_of_material_by_product` (
  `integration_bill_of_material_by_product_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `integration_bill_of_material_id` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_bill_of_material_by_product_id`),
  KEY `integration_bill_of_material_id` (`integration_bill_of_material_id`),
  CONSTRAINT `integration_bill_of_material_by_product_ibfk_1` FOREIGN KEY (`integration_bill_of_material_id`) REFERENCES `integration_bill_of_material` (`integration_bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_bill_of_material_line`;
CREATE TABLE `integration_bill_of_material_line` (
  `integration_bill_of_material_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `integration_bill_of_material_id` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_bill_of_material_line_id`),
  KEY `integration_bill_of_material_id` (`integration_bill_of_material_id`),
  CONSTRAINT `integration_bill_of_material_line_ibfk_1` FOREIGN KEY (`integration_bill_of_material_id`) REFERENCES `integration_bill_of_material` (`integration_bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_client`;
CREATE TABLE `integration_client` (
  `integration_client_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `contactor_firstname` varchar(100) NOT NULL,
  `contactor_lastname` varchar(100) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_county` varchar(100) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) NOT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(25) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_customer`;
CREATE TABLE `integration_customer` (
  `integration_customer_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  `contactor_firstname` varchar(100) NOT NULL,
  `contactor_lastname` varchar(100) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_county` varchar(100) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) NOT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(25) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_listid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_inventory_adjustment_confirmation`;
CREATE TABLE `integration_inventory_adjustment_confirmation` (
  `integration_inventory_adjustment_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `adjust_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `inventory_quantity_change_type` varchar(50) DEFAULT NULL,
  `document_number` varchar(100) DEFAULT NULL,
  `comment` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `quickbook_listid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_inventory_adjustment_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_inventory_attribute_change_confirmation`;
CREATE TABLE `integration_inventory_attribute_change_confirmation` (
  `integration_inventory_attribute_change_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `attribute_name` varchar(100) NOT NULL,
  `original_value` varchar(100) DEFAULT NULL,
  `new_value` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`integration_inventory_attribute_change_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_inventory_shippping_confirmation`;
CREATE TABLE `integration_inventory_shippping_confirmation` (
  `integration_inventory_shippping_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `shipment_number` varchar(100) NOT NULL,
  `shipment_line_number` varchar(100) NOT NULL,
  `order_number` varchar(100) NOT NULL,
  `order_line_number` varchar(100) NOT NULL,
  `lpn` varchar(100) NOT NULL,
  `quantity` bigint NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `order_expected_quantity` bigint NOT NULL,
  `order_shipped_quantity` bigint NOT NULL,
  `shipment_shipped_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_name` varchar(100) DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `carrier_service_level_name` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_inventory_shippping_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_item`;
CREATE TABLE `integration_item` (
  `integration_item_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `integration_item_family_id` bigint DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `item_family_name` varchar(50) DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_listid` varchar(50) DEFAULT NULL,
  `non_inventory_item` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`integration_item_id`),
  KEY `integration_item_family_id` (`integration_item_family_id`),
  CONSTRAINT `integration_item_ibfk_1` FOREIGN KEY (`integration_item_family_id`) REFERENCES `integration_item_family` (`integration_item_family_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_item_family`;
CREATE TABLE `integration_item_family` (
  `integration_item_family_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_item_family_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_item_package_type`;
CREATE TABLE `integration_item_package_type` (
  `integration_item_package_type_id` bigint NOT NULL AUTO_INCREMENT,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `integration_item_id` bigint DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_item_package_type_id`),
  KEY `integration_item_id` (`integration_item_id`),
  CONSTRAINT `integration_item_package_type_ibfk_1` FOREIGN KEY (`integration_item_id`) REFERENCES `integration_item` (`integration_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_item_unit_of_measure`;
CREATE TABLE `integration_item_unit_of_measure` (
  `integration_item_unit_of_measure_id` bigint NOT NULL AUTO_INCREMENT,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `item_package_type_id` bigint DEFAULT NULL,
  `item_package_type_name` varchar(100) DEFAULT NULL,
  `unit_of_measure_id` bigint DEFAULT NULL,
  `unit_of_measure_name` varchar(100) DEFAULT NULL,
  `quantity` bigint DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `length` double DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `integration_item_package_type_id` bigint DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `default_for_inbound_receiving` tinyint(1) NOT NULL DEFAULT '0',
  `default_for_work_order_receiving` tinyint(1) NOT NULL DEFAULT '0',
  `tracking_lpn` tinyint(1) NOT NULL DEFAULT '0',
  `default_for_display` tinyint(1) NOT NULL DEFAULT '0',
  `case_flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`integration_item_unit_of_measure_id`),
  KEY `integration_item_package_type_id` (`integration_item_package_type_id`),
  CONSTRAINT `integration_item_unit_of_measure_ibfk_1` FOREIGN KEY (`integration_item_package_type_id`) REFERENCES `integration_item_package_type` (`integration_item_package_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_order`;
CREATE TABLE `integration_order` (
  `integration_order_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `ship_to_customer_id` bigint DEFAULT NULL,
  `ship_to_customer_name` varchar(100) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `bill_to_customer_id` bigint DEFAULT NULL,
  `bill_to_customer_name` varchar(100) DEFAULT NULL,
  `ship_to_contactor_firstname` varchar(100) DEFAULT NULL,
  `ship_to_contactor_lastname` varchar(100) DEFAULT NULL,
  `ship_to_address_country` varchar(100) DEFAULT NULL,
  `ship_to_address_state` varchar(100) DEFAULT NULL,
  `ship_to_address_county` varchar(100) DEFAULT NULL,
  `ship_to_address_city` varchar(100) DEFAULT NULL,
  `ship_to_address_district` varchar(100) DEFAULT NULL,
  `ship_to_address_line1` varchar(100) DEFAULT NULL,
  `ship_to_address_line2` varchar(100) DEFAULT NULL,
  `ship_to_address_postcode` varchar(25) DEFAULT NULL,
  `bill_to_contactor_firstname` varchar(100) DEFAULT NULL,
  `bill_to_contactor_lastname` varchar(100) DEFAULT NULL,
  `bill_to_address_country` varchar(100) DEFAULT NULL,
  `bill_to_address_state` varchar(100) DEFAULT NULL,
  `bill_to_address_county` varchar(100) DEFAULT NULL,
  `bill_to_address_city` varchar(100) DEFAULT NULL,
  `bill_to_address_district` varchar(100) DEFAULT NULL,
  `bill_to_address_line1` varchar(100) DEFAULT NULL,
  `bill_to_address_line2` varchar(100) DEFAULT NULL,
  `bill_to_address_postcode` varchar(25) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_name` varchar(100) DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `carrier_service_level_name` varchar(100) DEFAULT NULL,
  `stage_location_group_id` bigint DEFAULT NULL,
  `stage_location_group_name` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `category` varchar(50) NOT NULL DEFAULT 'SALES_ORDER',
  `transfer_receipt_warehouse_id` bigint DEFAULT NULL,
  `transfer_receipt_warehouse_name` varchar(50) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_txnid` varchar(50) DEFAULT NULL,
  `quickbook_customer_list_id` varchar(50) DEFAULT NULL,
  `ship_to_address_line3` varchar(100) DEFAULT NULL,
  `bill_to_address_line3` varchar(100) DEFAULT NULL,
  `ship_to_contactor_phone_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_order_confirmation`;
CREATE TABLE `integration_order_confirmation` (
  `integration_order_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `quickbook_txnid` varchar(50) DEFAULT NULL,
  `quickbook_customer_list_id` varchar(50) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  PRIMARY KEY (`integration_order_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_order_line`;
CREATE TABLE `integration_order_line` (
  `integration_order_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `integration_order_id` bigint NOT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_name` varchar(100) DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `carrier_service_level_name` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_txnlineid` varchar(50) DEFAULT NULL,
  `item_quickbook_list_id` varchar(50) DEFAULT NULL,
  `non_allocatable` tinyint(1) DEFAULT NULL,
  `hualei_product_id` varchar(100) DEFAULT NULL,
  `auto_request_shipping_label` tinyint(1) NOT NULL DEFAULT '0',
  `color` varchar(100) DEFAULT NULL,
  `product_size` varchar(100) DEFAULT NULL,
  `style` varchar(100) DEFAULT NULL,
  `allocate_by_receipt_number` varchar(100) DEFAULT NULL,
  `parcel_insured` tinyint(1) DEFAULT NULL,
  `parcel_insured_amount_per_unit` double DEFAULT NULL,
  `parcel_signature_required` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`integration_order_line_id`),
  KEY `integration_order_id` (`integration_order_id`),
  CONSTRAINT `integration_order_line_ibfk_1` FOREIGN KEY (`integration_order_id`) REFERENCES `integration_order` (`integration_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_order_line_confirmation`;
CREATE TABLE `integration_order_line_confirmation` (
  `integration_order_line_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `open_quantity` bigint NOT NULL,
  `inprocess_quantity` bigint NOT NULL,
  `shipped_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `integration_order_confirmation_id` bigint NOT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_name` varchar(100) DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `carrier_service_level_name` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_txnlineid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_order_line_confirmation_id`),
  KEY `integration_order_confirmation_id` (`integration_order_confirmation_id`),
  CONSTRAINT `integration_order_line_confirmation_ibfk_1` FOREIGN KEY (`integration_order_confirmation_id`) REFERENCES `integration_order_confirmation` (`integration_order_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_purchase_order`;
CREATE TABLE `integration_purchase_order` (
  `integration_purchase_order_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `allow_unexpected_item` tinyint(1) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_txnid` varchar(50) DEFAULT NULL,
  `quickbook_vendor_list_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`integration_purchase_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_purchase_order_line`;
CREATE TABLE `integration_purchase_order_line` (
  `integration_purchase_order_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `integration_purchase_order_id` bigint DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_txnlineid` varchar(50) DEFAULT NULL,
  `item_quickbook_list_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_purchase_order_line_id`),
  KEY `integration_purchase_order_id` (`integration_purchase_order_id`),
  CONSTRAINT `integration_purchase_order_line_ibfk_1` FOREIGN KEY (`integration_purchase_order_id`) REFERENCES `integration_purchase_order` (`integration_purchase_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_receipt`;
CREATE TABLE `integration_receipt` (
  `integration_receipt_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `allow_unexpected_item` tinyint(1) NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_receipt_confirmation`;
CREATE TABLE `integration_receipt_confirmation` (
  `integration_receipt_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `allow_unexpected_item` tinyint(1) NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `quickbook_txnid` varchar(50) DEFAULT NULL,
  `quickbook_vendor_listid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_receipt_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_receipt_line`;
CREATE TABLE `integration_receipt_line` (
  `integration_receipt_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `integration_receipt_id` bigint DEFAULT NULL,
  `over_receiving_quantity` bigint NOT NULL,
  `over_receiving_percent` double NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_receipt_line_id`),
  KEY `integration_receipt_id` (`integration_receipt_id`),
  CONSTRAINT `integration_receipt_line_ibfk_1` FOREIGN KEY (`integration_receipt_id`) REFERENCES `integration_receipt` (`integration_receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_receipt_line_confirmation`;
CREATE TABLE `integration_receipt_line_confirmation` (
  `integration_receipt_line_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `received_quantity` bigint NOT NULL,
  `integration_receipt_confirmation_id` bigint DEFAULT NULL,
  `over_receiving_quantity` bigint NOT NULL,
  `over_receiving_percent` double NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_txnlineid` varchar(50) DEFAULT NULL,
  `quickbook_item_listId` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_receipt_line_confirmation_id`),
  KEY `integration_receipt_confirmation_id` (`integration_receipt_confirmation_id`),
  CONSTRAINT `integration_receipt_line_confirmation_ibfk_1` FOREIGN KEY (`integration_receipt_confirmation_id`) REFERENCES `integration_receipt_confirmation` (`integration_receipt_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_shipment`;
CREATE TABLE `integration_shipment` (
  `integration_shipment_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `number` varchar(100) NOT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_name` varchar(100) DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `carrier_service_level_name` varchar(100) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `order_id` bigint DEFAULT NULL,
  `order_number` varchar(100) DEFAULT NULL,
  `ship_to_customer_id` bigint DEFAULT NULL,
  `ship_to_customer_name` varchar(100) DEFAULT NULL,
  `ship_to_contactor_firstname` varchar(100) DEFAULT NULL,
  `ship_to_contactor_lastname` varchar(100) DEFAULT NULL,
  `ship_to_address_country` varchar(100) DEFAULT NULL,
  `ship_to_address_state` varchar(100) DEFAULT NULL,
  `ship_to_address_county` varchar(100) DEFAULT NULL,
  `ship_to_address_city` varchar(100) DEFAULT NULL,
  `ship_to_address_district` varchar(100) DEFAULT NULL,
  `ship_to_address_line1` varchar(100) DEFAULT NULL,
  `ship_to_address_line2` varchar(100) DEFAULT NULL,
  `ship_to_address_postcode` varchar(100) DEFAULT NULL,
  `integration_stop_id` bigint NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_shipment_id`),
  KEY `integration_stop_id` (`integration_stop_id`),
  CONSTRAINT `integration_shipment_ibfk_1` FOREIGN KEY (`integration_stop_id`) REFERENCES `integration_stop` (`integration_stop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_shipment_line`;
CREATE TABLE `integration_shipment_line` (
  `integration_shipment_line_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `number` varchar(100) NOT NULL,
  `order_line_id` bigint DEFAULT NULL,
  `order_line_number` varchar(100) DEFAULT NULL,
  `integration_shipment_id` bigint NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_shipment_line_id`),
  KEY `integration_shipment_id` (`integration_shipment_id`),
  CONSTRAINT `integration_shipment_line_ibfk_1` FOREIGN KEY (`integration_shipment_id`) REFERENCES `integration_shipment` (`integration_shipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_shipment_line_confirmation`;
CREATE TABLE `integration_shipment_line_confirmation` (
  `integration_shipment_line_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `shipment_number` varchar(100) NOT NULL,
  `shipment_line_number` varchar(100) NOT NULL,
  `order_number` varchar(100) NOT NULL,
  `order_line_number` varchar(100) NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `order_expected_quantity` bigint NOT NULL,
  `order_shipped_quantity` bigint NOT NULL,
  `shipment_shipped_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_name` varchar(100) DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `carrier_service_level_name` varchar(100) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_shipment_line_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_stop`;
CREATE TABLE `integration_stop` (
  `integration_stop_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `number` varchar(100) NOT NULL,
  `sequence` int NOT NULL,
  `contactor_firstname` varchar(100) DEFAULT NULL,
  `contactor_lastname` varchar(100) DEFAULT NULL,
  `address_country` varchar(100) DEFAULT NULL,
  `address_state` varchar(100) DEFAULT NULL,
  `address_county` varchar(100) DEFAULT NULL,
  `address_city` varchar(100) DEFAULT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(100) DEFAULT NULL,
  `address_line2` varchar(100) DEFAULT NULL,
  `address_postcode` varchar(25) DEFAULT NULL,
  `integration_trailer_appointment_id` bigint NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_stop_id`),
  KEY `integration_trailer_appointment_id` (`integration_trailer_appointment_id`),
  CONSTRAINT `integration_stop_ibfk_1` FOREIGN KEY (`integration_trailer_appointment_id`) REFERENCES `integration_trailer_appointment` (`integration_trailer_appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_supplier`;
CREATE TABLE `integration_supplier` (
  `integration_supplier_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `contactor_firstname` varchar(100) NOT NULL,
  `contactor_lastname` varchar(100) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_county` varchar(100) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) NOT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(25) DEFAULT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `user_defined_field_1` varchar(100) DEFAULT NULL,
  `user_defined_field_2` varchar(100) DEFAULT NULL,
  `user_defined_field_3` varchar(100) DEFAULT NULL,
  `user_defined_field_4` varchar(100) DEFAULT NULL,
  `user_defined_field_5` varchar(100) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_listid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_trailer_appointment`;
CREATE TABLE `integration_trailer_appointment` (
  `integration_trailer_appointment_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `number` varchar(100) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `type` varchar(100) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_trailer_appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_work_order`;
CREATE TABLE `integration_work_order` (
  `integration_work_order_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `po_number` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_work_order_by_product`;
CREATE TABLE `integration_work_order_by_product` (
  `integration_work_order_by_product_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `integration_work_order_id` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_work_order_by_product_id`),
  KEY `integration_work_order_id` (`integration_work_order_id`),
  CONSTRAINT `integration_work_order_by_product_ibfk_1` FOREIGN KEY (`integration_work_order_id`) REFERENCES `integration_work_order` (`integration_work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_work_order_by_product_confirmation`;
CREATE TABLE `integration_work_order_by_product_confirmation` (
  `integration_work_order_by_product_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `produced_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `integration_work_order_confirmation_id` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_work_order_by_product_confirmation_id`),
  KEY `integration_work_order_confirmation_id` (`integration_work_order_confirmation_id`),
  CONSTRAINT `integration_work_order_by_product_confirmation_ibfk_1` FOREIGN KEY (`integration_work_order_confirmation_id`) REFERENCES `integration_work_order_confirmation` (`integration_work_order_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_work_order_confirmation`;
CREATE TABLE `integration_work_order_confirmation` (
  `integration_work_order_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `production_line_name` varchar(100) DEFAULT NULL,
  `bill_of_material_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `produced_quantity` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`integration_work_order_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_work_order_instruction`;
CREATE TABLE `integration_work_order_instruction` (
  `integration_work_order_instruction_id` bigint NOT NULL AUTO_INCREMENT,
  `sequence` int DEFAULT NULL,
  `instruction` varchar(100) DEFAULT NULL,
  `integration_work_order_id` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_work_order_instruction_id`),
  KEY `integration_work_order_id` (`integration_work_order_id`),
  CONSTRAINT `integration_work_order_instruction_ibfk_1` FOREIGN KEY (`integration_work_order_id`) REFERENCES `integration_work_order` (`integration_work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_work_order_instruction_template`;
CREATE TABLE `integration_work_order_instruction_template` (
  `integration_work_order_instruction_template_id` bigint NOT NULL AUTO_INCREMENT,
  `sequence` int DEFAULT NULL,
  `instruction` varchar(100) DEFAULT NULL,
  `integration_bill_of_material_id` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_work_order_instruction_template_id`),
  KEY `integration_bill_of_material_id` (`integration_bill_of_material_id`),
  CONSTRAINT `integration_work_order_instruction_template_ibfk_1` FOREIGN KEY (`integration_bill_of_material_id`) REFERENCES `integration_bill_of_material` (`integration_bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_work_order_line`;
CREATE TABLE `integration_work_order_line` (
  `integration_work_order_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `company_id` bigint DEFAULT NULL,
  `company_code` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `warehouse_name` varchar(100) DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `allocation_strategy_type` varchar(100) DEFAULT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `integration_work_order_id` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_work_order_line_id`),
  KEY `integration_work_order_id` (`integration_work_order_id`),
  CONSTRAINT `integration_work_order_line_ibfk_1` FOREIGN KEY (`integration_work_order_id`) REFERENCES `integration_work_order` (`integration_work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `integration_work_order_line_confirmation`;
CREATE TABLE `integration_work_order_line_confirmation` (
  `integration_work_order_line_confirmation_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `open_quantity` bigint NOT NULL,
  `inprocess_quantity` bigint NOT NULL,
  `delivered_quantity` bigint NOT NULL,
  `consumed_quantity` bigint NOT NULL,
  `scrapped_quantity` bigint NOT NULL,
  `returned_quantity` bigint NOT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `inventory_status_name` varchar(100) DEFAULT NULL,
  `integration_work_order_confirmation_id` bigint NOT NULL,
  `insert_time` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`integration_work_order_line_confirmation_id`),
  KEY `integration_work_order_confirmation_id` (`integration_work_order_confirmation_id`),
  CONSTRAINT `integration_work_order_line_confirmation_ibfk_1` FOREIGN KEY (`integration_work_order_confirmation_id`) REFERENCES `integration_work_order_confirmation` (`integration_work_order_confirmation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `inventory_id` bigint NOT NULL AUTO_INCREMENT,
  `lpn` varchar(100) NOT NULL,
  `location_id` bigint NOT NULL,
  `pick_id` bigint DEFAULT NULL,
  `allocated_by_pick_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `item_package_type_id` bigint NOT NULL,
  `quantity` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `virtual_inventory` tinyint(1) NOT NULL DEFAULT '0',
  `receipt_id` bigint DEFAULT NULL,
  `receipt_line_id` bigint DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `work_order_line_id` bigint DEFAULT NULL,
  `work_order_by_product_id` bigint DEFAULT NULL,
  `locked_for_adjust` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `create_inventory_transaction_id` bigint DEFAULT NULL,
  `inbound_qc_required` tinyint(1) NOT NULL DEFAULT '0',
  `customer_return_order_id` bigint DEFAULT NULL,
  `customer_return_order_line_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `product_size` varchar(100) DEFAULT NULL,
  `style` varchar(100) DEFAULT NULL,
  `fifo_date` datetime DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `item_id` (`item_id`),
  KEY `item_package_type_id` (`item_package_type_id`),
  KEY `inventory_status_id` (`inventory_status_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`item_package_type_id`) REFERENCES `item_package_type` (`item_package_type_id`),
  CONSTRAINT `inventory_ibfk_3` FOREIGN KEY (`inventory_status_id`) REFERENCES `inventory_status` (`inventory_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_activity`;
CREATE TABLE `inventory_activity` (
  `inventory_activity_id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(20) NOT NULL,
  `transaction_group_id` varchar(20) NOT NULL,
  `lpn` varchar(100) NOT NULL,
  `location_id` bigint NOT NULL,
  `pick_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `item_package_type_id` bigint NOT NULL,
  `quantity` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `virtual_inventory` tinyint(1) NOT NULL DEFAULT '0',
  `receipt_id` bigint DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `activity_datetime` datetime NOT NULL,
  `username` varchar(50) NOT NULL,
  `value_type` varchar(50) DEFAULT NULL,
  `from_value` varchar(50) DEFAULT NULL,
  `to_value` varchar(50) DEFAULT NULL,
  `document_number` varchar(50) DEFAULT NULL,
  `comment` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `rf_code` varchar(50) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  PRIMARY KEY (`inventory_activity_id`),
  KEY `item_id` (`item_id`),
  KEY `item_package_type_id` (`item_package_type_id`),
  KEY `inventory_status_id` (`inventory_status_id`),
  CONSTRAINT `inventory_activity_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `inventory_activity_ibfk_2` FOREIGN KEY (`item_package_type_id`) REFERENCES `item_package_type` (`item_package_type_id`),
  CONSTRAINT `inventory_activity_ibfk_3` FOREIGN KEY (`inventory_status_id`) REFERENCES `inventory_status` (`inventory_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_adjustment_request`;
CREATE TABLE `inventory_adjustment_request` (
  `inventory_adjustment_request_id` bigint NOT NULL AUTO_INCREMENT,
  `inventory_id` bigint DEFAULT NULL,
  `lpn` varchar(100) NOT NULL,
  `location_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `item_package_type_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `quantity` bigint NOT NULL,
  `new_quantity` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `virtual_inventory` tinyint(1) DEFAULT NULL,
  `inventory_quantity_change_type` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `requested_by_username` varchar(50) NOT NULL,
  `requested_by_datetime` datetime NOT NULL,
  `processed_by_username` varchar(50) DEFAULT NULL,
  `processed_by_datetime` datetime DEFAULT NULL,
  `document_number` varchar(200) DEFAULT NULL,
  `comment` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_adjustment_request_id`),
  KEY `item_id` (`item_id`),
  KEY `item_package_type_id` (`item_package_type_id`),
  KEY `inventory_status_id` (`inventory_status_id`),
  CONSTRAINT `inventory_adjustment_request_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `inventory_adjustment_request_ibfk_2` FOREIGN KEY (`item_package_type_id`) REFERENCES `item_package_type` (`item_package_type_id`),
  CONSTRAINT `inventory_adjustment_request_ibfk_3` FOREIGN KEY (`inventory_status_id`) REFERENCES `inventory_status` (`inventory_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_adjustment_threshold`;
CREATE TABLE `inventory_adjustment_threshold` (
  `inventory_adjustment_threshold_id` bigint NOT NULL AUTO_INCREMENT,
  `item_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `inventory_quantity_change_type` varchar(20) DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `quantity_threshold` bigint DEFAULT NULL,
  `cost_threshold` double DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_adjustment_threshold_id`),
  KEY `item_id` (`item_id`),
  KEY `item_family_id` (`item_family_id`),
  CONSTRAINT `inventory_adjustment_threshold_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `inventory_adjustment_threshold_ibfk_2` FOREIGN KEY (`item_family_id`) REFERENCES `item_family` (`item_family_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_aging_snapshot`;
CREATE TABLE `inventory_aging_snapshot` (
  `inventory_aging_snapshot_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(50) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `complete_time` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_aging_snapshot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_aging_snapshot_detail`;
CREATE TABLE `inventory_aging_snapshot_detail` (
  `inventory_aging_snapshot_detail_id` bigint NOT NULL AUTO_INCREMENT,
  `client_inventory_aging_snapshot_id` bigint NOT NULL,
  `inventory_id` bigint NOT NULL,
  `lpn` varchar(100) NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `age_in_days` bigint NOT NULL DEFAULT '0',
  `age_in_weeks` bigint NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_aging_snapshot_detail_id`),
  KEY `client_inventory_aging_snapshot_id` (`client_inventory_aging_snapshot_id`),
  CONSTRAINT `inventory_aging_snapshot_detail_ibfk_1` FOREIGN KEY (`client_inventory_aging_snapshot_id`) REFERENCES `client_inventory_aging_snapshot` (`client_inventory_aging_snapshot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_configuration`;
CREATE TABLE `inventory_configuration` (
  `inventory_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `lpn_validation_rule` varchar(250) DEFAULT NULL,
  `new_item_auto_generate_default_package_type` tinyint(1) DEFAULT NULL,
  `new_item_default_package_type_name` varchar(50) DEFAULT NULL,
  `new_item_default_package_type_description` varchar(250) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `inventory_configuration` (`inventory_configuration_id`, `company_id`, `warehouse_id`, `lpn_validation_rule`, `new_item_auto_generate_default_package_type`, `new_item_default_package_type_name`, `new_item_default_package_type_description`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	1,	1,	'[WABRPEDL]\\d+',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `inventory_lock`;
CREATE TABLE `inventory_lock` (
  `inventory_lock_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `allow_pick` tinyint(1) NOT NULL,
  `allow_ship` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_lock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_mix_restriction`;
CREATE TABLE `inventory_mix_restriction` (
  `inventory_mix_restriction_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `location_group_type_id` bigint DEFAULT NULL,
  `location_group_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_mix_restriction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_mix_restriction_line`;
CREATE TABLE `inventory_mix_restriction_line` (
  `inventory_mix_restriction_line_id` bigint NOT NULL AUTO_INCREMENT,
  `inventory_mix_restriction_id` bigint NOT NULL,
  `type` varchar(20) NOT NULL,
  `attribute` varchar(50) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_mix_restriction_line_id`),
  KEY `inventory_mix_restriction_id` (`inventory_mix_restriction_id`),
  CONSTRAINT `inventory_mix_restriction_line_ibfk_1` FOREIGN KEY (`inventory_mix_restriction_id`) REFERENCES `inventory_mix_restriction` (`inventory_mix_restriction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_movement`;
CREATE TABLE `inventory_movement` (
  `inventory_movement_id` bigint NOT NULL AUTO_INCREMENT,
  `inventory_id` bigint NOT NULL,
  `location_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `sequence` int NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_movement_id`),
  KEY `inventory_id` (`inventory_id`),
  CONSTRAINT `inventory_movement_ibfk_1` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_snapshot`;
CREATE TABLE `inventory_snapshot` (
  `inventory_snapshot_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `batch_number` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `complete_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `file_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`inventory_snapshot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_snapshot_configuration`;
CREATE TABLE `inventory_snapshot_configuration` (
  `inventory_snapshot_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `cron` varchar(20) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `location_utilization_snapshot_cron` varchar(20) DEFAULT NULL,
  `inventory_snapshot_timing_1` int DEFAULT NULL,
  `inventory_snapshot_timing_2` int DEFAULT NULL,
  `inventory_snapshot_timing_3` int DEFAULT NULL,
  `location_utilization_snapshot_timing_1` int DEFAULT NULL,
  `location_utilization_snapshot_timing_2` int DEFAULT NULL,
  `location_utilization_snapshot_timing_3` int DEFAULT NULL,
  `inventory_aging_snapshot_timing_1` int DEFAULT NULL,
  `inventory_aging_snapshot_timing_2` int DEFAULT NULL,
  `inventory_aging_snapshot_timing_3` int DEFAULT NULL,
  PRIMARY KEY (`inventory_snapshot_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_snapshot_detail`;
CREATE TABLE `inventory_snapshot_detail` (
  `inventory_snapshot_detail_id` bigint NOT NULL AUTO_INCREMENT,
  `inventory_snapshot_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `item_package_type_id` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `location_group_type_id` bigint NOT NULL,
  `quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_snapshot_detail_id`),
  KEY `inventory_snapshot_id` (`inventory_snapshot_id`),
  KEY `item_id` (`item_id`),
  KEY `item_package_type_id` (`item_package_type_id`),
  KEY `inventory_status_id` (`inventory_status_id`),
  CONSTRAINT `inventory_snapshot_detail_ibfk_1` FOREIGN KEY (`inventory_snapshot_id`) REFERENCES `inventory_snapshot` (`inventory_snapshot_id`),
  CONSTRAINT `inventory_snapshot_detail_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `inventory_snapshot_detail_ibfk_3` FOREIGN KEY (`item_package_type_id`) REFERENCES `item_package_type` (`item_package_type_id`),
  CONSTRAINT `inventory_snapshot_detail_ibfk_4` FOREIGN KEY (`inventory_status_id`) REFERENCES `inventory_status` (`inventory_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `inventory_status`;
CREATE TABLE `inventory_status` (
  `inventory_status_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `description` varchar(100) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `available_status_flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`inventory_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `inventory_status` (`inventory_status_id`, `name`, `warehouse_id`, `description`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `available_status_flag`) VALUES
(1,	'AVAL',	1,	'Available',	'2021-07-27 19:49:20',	NULL,	'2021-07-27 19:49:20',	NULL,	1),
(2,	'DMG',	1,	'Damaged',	'2021-07-27 19:49:20',	NULL,	'2021-07-27 19:49:20',	NULL,	0),
(3,	'QC',	1,	'QC Required',	NULL,	NULL,	NULL,	NULL,	0),
(4,	'QCF',	1,	'QC Failed',	NULL,	NULL,	NULL,	NULL,	0),

DROP TABLE IF EXISTS `inventory_with_lock`;
CREATE TABLE `inventory_with_lock` (
  `inventory_with_lock_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `inventory_id` bigint NOT NULL,
  `inventory_lock_id` bigint NOT NULL,
  `comment` varchar(2000) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inventory_with_lock_id`),
  KEY `inventory_id` (`inventory_id`),
  KEY `inventory_lock_id` (`inventory_lock_id`),
  CONSTRAINT `inventory_with_lock_ibfk_1` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`),
  CONSTRAINT `inventory_with_lock_ibfk_2` FOREIGN KEY (`inventory_lock_id`) REFERENCES `inventory_lock` (`inventory_lock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `invoice_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `number` varchar(50) NOT NULL,
  `reference_number` varchar(200) DEFAULT NULL,
  `comment` varchar(2000) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `total_charge` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `start_date` varchar(20) DEFAULT NULL,
  `end_date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `invoice_document`;
CREATE TABLE `invoice_document` (
  `invoice_document_id` bigint NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint NOT NULL,
  `file_name` varchar(50) NOT NULL,
  `remote_file_name` varchar(70) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`invoice_document_id`),
  KEY `invoice_id` (`invoice_id`),
  CONSTRAINT `invoice_document_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `invoice_line`;
CREATE TABLE `invoice_line` (
  `invoice_line_id` bigint NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint NOT NULL,
  `billing_request_id` bigint NOT NULL,
  `billable_category` varchar(50) NOT NULL,
  `amount` double NOT NULL,
  `rate` double NOT NULL,
  `total_charge` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`invoice_line_id`),
  KEY `invoice_id` (`invoice_id`),
  CONSTRAINT `invoice_line_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `item_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `allow_cartonization` tinyint(1) NOT NULL DEFAULT '0',
  `allow_allocation_by_lpn` tinyint(1) NOT NULL DEFAULT '0',
  `allocation_round_up_strategy_type` varchar(20) DEFAULT NULL,
  `allocation_round_up_strategy_value` double DEFAULT NULL,
  `tracking_volume_flag` tinyint(1) NOT NULL DEFAULT '0',
  `tracking_lot_number_flag` tinyint(1) NOT NULL DEFAULT '0',
  `tracking_manufacture_date_flag` tinyint(1) NOT NULL DEFAULT '0',
  `shelf_life_days` int DEFAULT '0',
  `tracking_expiration_date_flag` tinyint(1) NOT NULL DEFAULT '0',
  `image_url` varchar(2000) DEFAULT NULL,
  `thumbnail_url` varchar(2000) DEFAULT NULL,
  `active_flag` tinyint(1) NOT NULL DEFAULT '1',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `abc_category_id` bigint DEFAULT NULL,
  `velocity_id` bigint DEFAULT NULL,
  `quickbook_listid` varchar(50) DEFAULT NULL,
  `non_inventory_item` tinyint(1) DEFAULT NULL,
  `tracking_color_flag` tinyint(1) NOT NULL DEFAULT '0',
  `default_color` varchar(100) DEFAULT NULL,
  `tracking_product_size_flag` tinyint(1) NOT NULL DEFAULT '0',
  `default_product_size` varchar(100) DEFAULT NULL,
  `tracking_style_flag` tinyint(1) NOT NULL DEFAULT '0',
  `default_style` varchar(100) DEFAULT NULL,
  `receiving_rate_by_unit` double DEFAULT NULL,
  `shipping_rate_by_unit` double DEFAULT NULL,
  `handling_rate_by_unit` double DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `item_family_id` (`item_family_id`),
  CONSTRAINT `item_ibfk_1` FOREIGN KEY (`item_family_id`) REFERENCES `item_family` (`item_family_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `item_default_package_uom`;
CREATE TABLE `item_default_package_uom` (
  `item_default_package_uom_id` bigint NOT NULL AUTO_INCREMENT,
  `inventory_configuration_id` bigint NOT NULL,
  `unit_of_measure_id` bigint NOT NULL,
  `quantity` int NOT NULL,
  `weight` double NOT NULL,
  `weight_unit` varchar(50) DEFAULT NULL,
  `length` double NOT NULL,
  `length_unit` varchar(50) DEFAULT NULL,
  `width` double NOT NULL,
  `width_unit` varchar(50) DEFAULT NULL,
  `height` double NOT NULL,
  `height_unit` varchar(50) DEFAULT NULL,
  `default_for_inbound_receiving` tinyint(1) NOT NULL DEFAULT '0',
  `default_for_work_order_receiving` tinyint(1) NOT NULL DEFAULT '0',
  `tracking_lpn` tinyint(1) NOT NULL DEFAULT '0',
  `case_flag` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`item_default_package_uom_id`),
  KEY `inventory_configuration_id` (`inventory_configuration_id`),
  CONSTRAINT `item_default_package_uom_ibfk_1` FOREIGN KEY (`inventory_configuration_id`) REFERENCES `inventory_configuration` (`inventory_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `item_family`;
CREATE TABLE `item_family` (
  `item_family_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `description` varchar(100) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `company_id` bigint NOT NULL,
  PRIMARY KEY (`item_family_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `item_package_type`;
CREATE TABLE `item_package_type` (
  `item_package_type_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `item_id` bigint NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `default_flag` tinyint(1) NOT NULL DEFAULT '0',
  `company_id` bigint NOT NULL,
  PRIMARY KEY (`item_package_type_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `item_package_type_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `item_sampling`;
CREATE TABLE `item_sampling` (
  `item_sampling_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(50) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `image_urls` varchar(2000) DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`item_sampling_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `item_sampling_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `item_unit_of_measure`;
CREATE TABLE `item_unit_of_measure` (
  `item_unit_of_measure_id` bigint NOT NULL AUTO_INCREMENT,
  `item_package_type_id` bigint NOT NULL,
  `unit_of_measure_id` bigint NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `quantity` int NOT NULL,
  `weight` double NOT NULL,
  `length` double NOT NULL,
  `width` double NOT NULL,
  `height` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `default_for_inbound_receiving` tinyint(1) NOT NULL DEFAULT '0',
  `default_for_work_order_receiving` tinyint(1) NOT NULL DEFAULT '0',
  `tracking_lpn` tinyint(1) NOT NULL DEFAULT '0',
  `company_id` bigint NOT NULL,
  `case_flag` tinyint(1) DEFAULT NULL,
  `weight_unit` varchar(50) DEFAULT NULL,
  `length_unit` varchar(50) DEFAULT NULL,
  `width_unit` varchar(50) DEFAULT NULL,
  `height_unit` varchar(50) DEFAULT NULL,
  `default_for_display` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_unit_of_measure_id`),
  KEY `item_package_type_id` (`item_package_type_id`),
  CONSTRAINT `item_unit_of_measure_ibfk_1` FOREIGN KEY (`item_package_type_id`) REFERENCES `item_package_type` (`item_package_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `list_pick_configuration`;
CREATE TABLE `list_pick_configuration` (
  `list_pick_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `sequence` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  `pick_type` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `max_volume` double DEFAULT NULL,
  `max_weight` double DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `allow_add_to_existing_list` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`list_pick_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `list_pick_configuration_group_rule`;
CREATE TABLE `list_pick_configuration_group_rule` (
  `list_pick_configuration_group_rule_id` bigint NOT NULL AUTO_INCREMENT,
  `list_pick_configuration_id` bigint NOT NULL,
  `group_rule_type` varchar(50) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`list_pick_configuration_group_rule_id`),
  KEY `list_pick_configuration_id` (`list_pick_configuration_id`),
  CONSTRAINT `list_pick_configuration_group_rule_ibfk_1` FOREIGN KEY (`list_pick_configuration_id`) REFERENCES `list_pick_configuration` (`list_pick_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `list_picking_configuration`;
CREATE TABLE `list_picking_configuration` (
  `list_picking_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `sequence` int NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `pick_type` varchar(20) NOT NULL,
  `group_rule` varchar(20) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  `max_volume` double DEFAULT NULL,
  `max_weight` double DEFAULT NULL,
  PRIMARY KEY (`list_picking_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `location_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `aisle` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `length` double DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `pick_sequence` bigint DEFAULT NULL,
  `putaway_sequence` bigint DEFAULT NULL,
  `count_sequence` bigint DEFAULT NULL,
  `capacity` double DEFAULT NULL,
  `fill_percentage` double DEFAULT NULL,
  `current_volume` double DEFAULT NULL,
  `pending_volume` double DEFAULT NULL,
  `location_group_id` bigint NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `reserved_code` varchar(100) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `weight_unit` varchar(50) DEFAULT NULL,
  `length_unit` varchar(50) DEFAULT NULL,
  `width_unit` varchar(50) DEFAULT NULL,
  `height_unit` varchar(50) DEFAULT NULL,
  `capacity_unit` varchar(50) DEFAULT NULL,
  `error_flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_id`),
  KEY `location_group_id` (`location_group_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`location_group_id`) REFERENCES `location_group` (`location_group_id`),
  CONSTRAINT `location_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `location` (`location_id`, `name`, `code`, `warehouse_id`, `aisle`, `x`, `y`, `z`, `length`, `width`, `height`, `pick_sequence`, `putaway_sequence`, `count_sequence`, `capacity`, `fill_percentage`, `current_volume`, `pending_volume`, `location_group_id`, `enabled`, `locked`, `reserved_code`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `weight_unit`, `length_unit`, `width_unit`, `height_unit`, `capacity_unit`, `error_flag`) VALUES
(1,	'RSTG001',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100000,	20100000,	20100000,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(2,	'RSTG002',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100001,	20100001,	20100001,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3,	'RSTG003',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100002,	20100002,	20100002,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(4,	'RSTG004',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100003,	20100003,	20100003,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(5,	'RSTG005',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100004,	20100004,	20100004,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(6,	'RSTG006',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100005,	20100005,	20100005,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(7,	'RSTG007',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100006,	20100006,	20100006,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(8,	'RSTG008',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100007,	20100007,	20100007,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(9,	'RSTG009',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100008,	20100008,	20100008,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(10,	'RSTG010',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100009,	20100009,	20100009,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(11,	'RSTG011',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100010,	20100010,	20100010,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(12,	'RSTG012',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100011,	20100011,	20100011,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(13,	'RSTG013',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100012,	20100012,	20100012,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(14,	'RSTG014',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100013,	20100013,	20100013,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(15,	'RSTG015',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100014,	20100014,	20100014,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(16,	'RSTG016',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100015,	20100015,	20100015,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(17,	'RSTG017',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100016,	20100016,	20100016,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(18,	'RSTG018',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100017,	20100017,	20100017,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(19,	'RSTG019',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100018,	20100018,	20100018,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(20,	'RSTG020',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100019,	20100019,	20100019,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(21,	'RSTG021',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100020,	20100020,	20100020,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(22,	'RSTG022',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100021,	20100021,	20100021,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(23,	'RSTG023',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100022,	20100022,	20100022,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(24,	'RSTG024',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100023,	20100023,	20100023,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(25,	'RSTG025',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100024,	20100024,	20100024,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(26,	'RSTG026',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100025,	20100025,	20100025,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(27,	'RSTG027',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100026,	20100026,	20100026,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(28,	'RSTG028',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100027,	20100027,	20100027,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(29,	'RSTG029',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100028,	20100028,	20100028,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(30,	'RSTG030',	NULL,	1,	'201',	NULL,	NULL,	NULL,	320,	240,	48,	20100029,	20100029,	20100029,	3686400,	100,	0,	0,	2,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(31,	'SSTG001',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200000,	20200000,	20200000,	3686400,	100,	0,	0,	5,	1,	0,	'SHIP0000001489',	NULL,	NULL,	'2022-01-10 15:52:05',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(32,	'SSTG002',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200001,	20200001,	20200001,	3686400,	100,	0,	0,	5,	1,	0,	'SHIP0000001347',	NULL,	NULL,	'2021-12-28 06:27:39',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(33,	'SSTG003',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200002,	20200002,	20200002,	3686400,	100,	0,	0,	5,	1,	0,	'FY000003980',	NULL,	NULL,	'2023-01-12 09:02:08',	'XXXX',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(34,	'SSTG004',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200003,	20200003,	20200003,	3686400,	100,	0,	0,	5,	1,	0,	'SHIP0000001399',	NULL,	NULL,	'2021-12-30 15:38:48',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(35,	'SSTG005',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200004,	20200004,	20200004,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:19:12',	'GZHANG',	'2023-07-20 04:19:12',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(36,	'SSTG006',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200005,	20200005,	20200005,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:19:13',	'GZHANG',	'2023-07-20 04:19:13',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(37,	'SSTG007',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200006,	20200006,	20200006,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:19:37',	'GZHANG',	'2023-07-20 04:19:37',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(38,	'SSTG008',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200007,	20200007,	20200007,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:19:58',	'GZHANG',	'2023-07-20 04:19:58',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(39,	'SSTG009',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200008,	20200008,	20200008,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:20:20',	'GZHANG',	'2023-07-20 04:20:20',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(40,	'SSTG010',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200009,	20200009,	20200009,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:20:22',	'GZHANG',	'2023-07-20 04:20:22',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(41,	'SSTG011',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200010,	20200010,	20200010,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:20:28',	'GZHANG',	'2023-07-20 04:20:28',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(42,	'SSTG012',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200011,	20200011,	20200011,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:20:30',	'GZHANG',	'2023-07-20 04:20:30',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(43,	'SSTG013',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200012,	20200012,	20200012,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:20:51',	'GZHANG',	'2023-07-20 04:20:51',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(44,	'SSTG014',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200013,	20200013,	20200013,	3686400,	100,	0,	0,	5,	1,	0,	'CT000001333',	NULL,	NULL,	'2021-12-15 21:23:06',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(45,	'SSTG015',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200014,	20200014,	20200014,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:21:11',	'GZHANG',	'2023-07-20 04:21:11',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(46,	'SSTG016',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200015,	20200015,	20200015,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-20 04:21:34',	'GZHANG',	'2023-07-20 04:21:34',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(47,	'SSTG017',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200016,	20200016,	20200016,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 02:49:12',	'GZHANG',	'2023-07-21 02:49:12',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(48,	'SSTG018',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200017,	20200017,	20200017,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 02:50:39',	'GZHANG',	'2023-07-21 02:50:39',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(49,	'SSTG019',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200018,	20200018,	20200018,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:52:29',	'GZHANG',	'2023-07-21 22:52:29',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(50,	'SSTG020',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200019,	20200019,	20200019,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:53:04',	'GZHANG',	'2023-07-21 22:53:04',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(51,	'SSTG021',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200020,	20200020,	20200020,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:53:12',	'GZHANG',	'2023-07-21 22:53:12',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(52,	'SSTG022',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200021,	20200021,	20200021,	3686400,	100,	0,	0,	5,	1,	0,	'SHIP0000002051',	NULL,	NULL,	'2022-03-01 15:46:52',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(53,	'SSTG023',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200022,	20200022,	20200022,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:53:45',	'GZHANG',	'2023-07-21 22:53:45',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(54,	'SSTG024',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200023,	20200023,	20200023,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:54:17',	'GZHANG',	'2023-07-21 22:54:17',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(55,	'SSTG025',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200024,	20200024,	20200024,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:54:49',	'GZHANG',	'2023-07-21 22:54:49',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(56,	'SSTG026',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200025,	20200025,	20200025,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:55:10',	'GZHANG',	'2023-07-21 22:55:10',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(57,	'SSTG027',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200026,	20200026,	20200026,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:55:44',	'GZHANG',	'2023-07-21 22:55:44',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(58,	'SSTG028',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200027,	20200027,	20200027,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:56:18',	'GZHANG',	'2023-07-21 22:56:18',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(59,	'SSTG029',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200028,	20200028,	20200028,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 22:56:47',	'GZHANG',	'2023-07-21 22:56:47',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(60,	'SSTG030',	NULL,	1,	'202',	NULL,	NULL,	NULL,	320,	240,	48,	20200029,	20200029,	20200029,	3686400,	100,	0,	0,	5,	1,	0,	NULL,	'2023-07-21 23:08:05',	'GZHANG',	'2023-07-21 23:08:05',	'GZHANG',	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(61,	'DMG001',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100000,	30100000,	30100000,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(62,	'DMG002',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100001,	30100001,	30100001,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(63,	'DMG003',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100002,	30100002,	30100002,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(64,	'DMG004',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100003,	30100003,	30100003,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(65,	'DMG005',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100004,	30100004,	30100004,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(66,	'DMG006',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100005,	30100005,	30100005,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(67,	'DMG007',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100006,	30100006,	30100006,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(68,	'DMG008',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100007,	30100007,	30100007,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(69,	'DMG009',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100008,	30100008,	30100008,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(70,	'DMG010',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100009,	30100009,	30100009,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(71,	'DMG011',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100010,	30100010,	30100010,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(72,	'DMG012',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100011,	30100011,	30100011,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(73,	'DMG013',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100012,	30100012,	30100012,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(74,	'DMG014',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100013,	30100013,	30100013,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(75,	'DMG015',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100014,	30100014,	30100014,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(76,	'DMG016',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100015,	30100015,	30100015,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(77,	'DMG017',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100016,	30100016,	30100016,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(78,	'DMG018',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100017,	30100017,	30100017,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(79,	'DMG019',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100018,	30100018,	30100018,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(80,	'DMG020',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100019,	30100019,	30100019,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(81,	'DMG021',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100020,	30100020,	30100020,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(82,	'DMG022',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100021,	30100021,	30100021,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(83,	'DMG023',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100022,	30100022,	30100022,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(84,	'DMG024',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100023,	30100023,	30100023,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(85,	'DMG025',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100024,	30100024,	30100024,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(86,	'DMG026',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100025,	30100025,	30100025,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(87,	'DMG027',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100026,	30100026,	30100026,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(88,	'DMG028',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100027,	30100027,	30100027,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(89,	'DMG029',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100028,	30100028,	30100028,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(90,	'DMG030',	NULL,	1,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100029,	30100029,	30100029,	997002999,	100,	0,	0,	1,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(91,	'RDOCK001',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100000,	40100000,	40100000,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(92,	'RDOCK002',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100001,	40100001,	40100001,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(93,	'RDOCK003',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100002,	40100002,	40100002,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(94,	'RDOCK004',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100003,	40100003,	40100003,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(95,	'RDOCK005',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100004,	40100004,	40100004,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(96,	'RDOCK006',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100005,	40100005,	40100005,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(97,	'RDOCK007',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100006,	40100006,	40100006,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(98,	'RDOCK008',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100007,	40100007,	40100007,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(99,	'RDOCK009',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100008,	40100008,	40100008,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(100,	'RDOCK010',	NULL,	1,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100009,	40100009,	40100009,	997002999,	100,	0,	0,	3,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(101,	'SDOCK001',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200000,	40200000,	40200000,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(102,	'SDOCK002',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200001,	40200001,	40200001,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(103,	'SDOCK003',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200002,	40200002,	40200002,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(104,	'SDOCK004',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200003,	40200003,	40200003,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(105,	'SDOCK005',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200004,	40200004,	40200004,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(106,	'SDOCK006',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200005,	40200005,	40200005,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(107,	'SDOCK007',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200006,	40200006,	40200006,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(108,	'SDOCK008',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200007,	40200007,	40200007,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(109,	'SDOCK009',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200008,	40200008,	40200008,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(110,	'SDOCK010',	NULL,	1,	'402',	NULL,	NULL,	NULL,	999,	999,	999,	40200009,	40200009,	40200009,	997002999,	100,	0,	0,	6,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(268,	'INVADJ',	NULL,	1,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100001,	100100001,	100100001,	999999,	100,	0,	0,	14,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(269,	'AUDIT',	NULL,	1,	'1002',	NULL,	NULL,	NULL,	999,	999,	999,	100100002,	100100002,	100100002,	999999,	100,	0,	0,	13,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(270,	'COUNT',	NULL,	1,	'1003',	NULL,	NULL,	NULL,	999,	999,	999,	100100003,	100100003,	100100003,	999999,	100,	0,	0,	13,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(271,	'INVRCV',	NULL,	1,	'1004',	NULL,	NULL,	NULL,	999,	999,	999,	100100004,	100100004,	100100004,	999999,	100,	0,	0,	15,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(272,	'REMOVE_INV',	NULL,	1,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100003,	100100003,	100100003,	999999,	100,	0,	0,	12,	1,	0,	'',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(341,	'RSTG000',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100000,	20100000,	20100000,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(342,	'RSTG001',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100001,	20100001,	20100001,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(343,	'RSTG002',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100002,	20100002,	20100002,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(344,	'RSTG003',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100003,	20100003,	20100003,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(345,	'RSTG004',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100004,	20100004,	20100004,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(346,	'RSTG005',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100005,	20100005,	20100005,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(347,	'RSTG006',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100006,	20100006,	20100006,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(348,	'RSTG007',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100007,	20100007,	20100007,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(349,	'RSTG008',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100008,	20100008,	20100008,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(350,	'RSTG009',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100009,	20100009,	20100009,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(351,	'RSTG010',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100010,	20100010,	20100010,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(352,	'RSTG011',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100011,	20100011,	20100011,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(353,	'RSTG012',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100012,	20100012,	20100012,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(354,	'RSTG013',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100013,	20100013,	20100013,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(355,	'RSTG014',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100014,	20100014,	20100014,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(356,	'RSTG015',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100015,	20100015,	20100015,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(357,	'RSTG016',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100016,	20100016,	20100016,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(358,	'RSTG017',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100017,	20100017,	20100017,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(359,	'RSTG018',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100018,	20100018,	20100018,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(360,	'RSTG019',	NULL,	2,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100019,	20100019,	20100019,	999999,	100,	NULL,	NULL,	21,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(361,	'RDOCK000',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100000,	30100000,	30100000,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(362,	'RDOCK001',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100001,	30100001,	30100001,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(363,	'RDOCK002',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100002,	30100002,	30100002,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(364,	'RDOCK003',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100003,	30100003,	30100003,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(365,	'RDOCK004',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100004,	30100004,	30100004,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(366,	'RDOCK005',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100005,	30100005,	30100005,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(367,	'RDOCK006',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100006,	30100006,	30100006,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(368,	'RDOCK007',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100007,	30100007,	30100007,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(369,	'RDOCK008',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100008,	30100008,	30100008,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(370,	'RDOCK009',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100009,	30100009,	30100009,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(371,	'RDOCK010',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100010,	30100010,	30100010,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(372,	'RDOCK011',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100011,	30100011,	30100011,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(373,	'RDOCK012',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100012,	30100012,	30100012,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(374,	'RDOCK013',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100013,	30100013,	30100013,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(375,	'RDOCK014',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100014,	30100014,	30100014,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(376,	'RDOCK015',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100015,	30100015,	30100015,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(377,	'RDOCK016',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100016,	30100016,	30100016,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(378,	'RDOCK017',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100017,	30100017,	30100017,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(379,	'RDOCK018',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100018,	30100018,	30100018,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(380,	'RDOCK019',	NULL,	2,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100019,	30100019,	30100019,	999999,	100,	NULL,	NULL,	22,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(381,	'SSTG0000',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100000,	40100000,	40100000,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(382,	'SSTG0001',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100001,	40100001,	40100001,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(383,	'SSTG0002',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100002,	40100002,	40100002,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(384,	'SSTG0003',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100003,	40100003,	40100003,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(385,	'SSTG0004',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100004,	40100004,	40100004,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(386,	'SSTG0005',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100005,	40100005,	40100005,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(387,	'SSTG0006',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100006,	40100006,	40100006,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(388,	'SSTG0007',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100007,	40100007,	40100007,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(389,	'SSTG0008',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100008,	40100008,	40100008,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(390,	'SSTG0009',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100009,	40100009,	40100009,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(391,	'SSTG0010',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100010,	40100010,	40100010,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(392,	'SSTG0011',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100011,	40100011,	40100011,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(393,	'SSTG0012',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100012,	40100012,	40100012,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(394,	'SSTG0013',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100013,	40100013,	40100013,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(395,	'SSTG0014',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100014,	40100014,	40100014,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(396,	'SSTG0015',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100015,	40100015,	40100015,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(397,	'SSTG0016',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100016,	40100016,	40100016,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(398,	'SSTG0017',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100017,	40100017,	40100017,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(399,	'SSTG0018',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100018,	40100018,	40100018,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(400,	'SSTG0019',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100019,	40100019,	40100019,	999999,	100,	NULL,	NULL,	24,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(401,	'SDOCK000',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100000,	40100000,	40100000,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(402,	'SDOCK001',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100001,	40100001,	40100001,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(403,	'SDOCK002',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100002,	40100002,	40100002,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(404,	'SDOCK003',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100003,	40100003,	40100003,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(405,	'SDOCK004',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100004,	40100004,	40100004,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(406,	'SDOCK005',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100005,	40100005,	40100005,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(407,	'SDOCK006',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100006,	40100006,	40100006,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(408,	'SDOCK007',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100007,	40100007,	40100007,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(409,	'SDOCK008',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100008,	40100008,	40100008,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(410,	'SDOCK009',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100009,	40100009,	40100009,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(411,	'SDOCK010',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100010,	40100010,	40100010,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(412,	'SDOCK011',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100011,	40100011,	40100011,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(413,	'SDOCK012',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100012,	40100012,	40100012,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(414,	'SDOCK013',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100013,	40100013,	40100013,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(415,	'SDOCK014',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100014,	40100014,	40100014,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(416,	'SDOCK015',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100015,	40100015,	40100015,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(417,	'SDOCK016',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100016,	40100016,	40100016,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(418,	'SDOCK017',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100017,	40100017,	40100017,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(419,	'SDOCK018',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100018,	40100018,	40100018,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(420,	'SDOCK019',	NULL,	2,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100019,	40100019,	40100019,	999999,	100,	NULL,	NULL,	25,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(441,	'REMOVE_INV',	NULL,	2,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100000,	100200000,	100100000,	999999,	100,	NULL,	NULL,	31,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(442,	'AUDIT',	NULL,	2,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100001,	100200001,	100200001,	999999,	100,	NULL,	NULL,	32,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(443,	'COUNT',	NULL,	2,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100002,	10100002,	100100002,	999999,	100,	NULL,	NULL,	32,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(444,	'INVADJ',	NULL,	2,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100003,	10100003,	100100003,	999999,	100,	NULL,	NULL,	33,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(445,	'INVRCV',	NULL,	2,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100004,	10100004,	100100004,	999999,	100,	NULL,	NULL,	34,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(446,	'LINE00',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100000,	60100000,	60100000,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(447,	'LINE01',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100001,	60100001,	60100001,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(448,	'LINE02',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100002,	60100002,	60100002,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(449,	'LINE03',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100003,	60100003,	60100003,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(450,	'LINE04',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100004,	60100004,	60100004,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(451,	'LINE05',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100005,	60100005,	60100005,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(452,	'LINE06',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100006,	60100006,	60100006,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(453,	'LINE07',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100007,	60100007,	60100007,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(454,	'LINE08',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100008,	60100008,	60100008,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(455,	'LINE09',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100009,	60100009,	60100009,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(456,	'LINE10',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100010,	60100010,	60100010,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(457,	'LINE11',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100011,	60100011,	60100011,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(458,	'LINE12',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100012,	60100012,	60100012,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(459,	'LINE13',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100013,	60100013,	60100013,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(460,	'LINE14',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100014,	60100014,	60100014,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(461,	'LINE15',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100015,	60100015,	60100015,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(462,	'LINE16',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100016,	60100016,	60100016,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(463,	'LINE17',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100017,	60100017,	60100017,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(464,	'LINE18',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100018,	60100018,	60100018,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(465,	'LINE19',	NULL,	2,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100019,	60100019,	60100019,	999999,	100,	NULL,	NULL,	35,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(466,	'LINE00-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200000,	60200000,	60200000,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(467,	'LINE01-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200001,	60200001,	60200001,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(468,	'LINE02-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200002,	60200002,	60200002,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(469,	'LINE03-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200003,	60200003,	60200003,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(470,	'LINE04-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200004,	60200004,	60200004,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(471,	'LINE05-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200005,	60200005,	60200005,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(472,	'LINE06-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200006,	60200006,	60200006,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(473,	'LINE07-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200007,	60200007,	60200007,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(474,	'LINE08-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200008,	60200008,	60200008,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(475,	'LINE09-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200009,	60200009,	60200009,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(476,	'LINE10-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200010,	60200010,	60200010,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(477,	'LINE11-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200011,	60200011,	60200011,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(478,	'LINE12-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200012,	60200012,	60200012,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(479,	'LINE13-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200013,	60200013,	60200013,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(480,	'LINE14-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200014,	60200014,	60200014,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(481,	'LINE15-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200015,	60200015,	60200015,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(482,	'LINE16-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200016,	60200016,	60200016,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(483,	'LINE17-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200017,	60200017,	60200017,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(484,	'LINE18-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200018,	60200018,	60200018,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(485,	'LINE19-IN',	NULL,	2,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200019,	60200019,	60200019,	999999,	100,	NULL,	NULL,	36,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(486,	'LINE00-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300000,	60300000,	60300000,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(487,	'LINE01-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300001,	60300001,	60300001,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(488,	'LINE02-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300002,	60300002,	60300002,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(489,	'LINE03-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300003,	60300003,	60300003,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(490,	'LINE04-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300004,	60300004,	60300004,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(491,	'LINE05-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300005,	60300005,	60300005,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(492,	'LINE06-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300006,	60300006,	60300006,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(493,	'LINE07-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300007,	60300007,	60300007,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(494,	'LINE08-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300008,	60300008,	60300008,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(495,	'LINE09-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300009,	60300009,	60300009,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(496,	'LINE10-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300010,	60300010,	60300010,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(497,	'LINE11-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300011,	60300011,	60300011,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(498,	'LINE12-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300012,	60300012,	60300012,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(499,	'LINE13-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300013,	60300013,	60300013,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(500,	'LINE14-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300014,	60300014,	60300014,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(501,	'LINE15-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300015,	60300015,	60300015,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(502,	'LINE16-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300016,	60300016,	60300016,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(503,	'LINE17-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300017,	60300017,	60300017,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(504,	'LINE18-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300018,	60300018,	60300018,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(505,	'LINE19-OUT',	NULL,	2,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300019,	60300019,	60300019,	999999,	100,	NULL,	NULL,	37,	1,	0,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(744,	'QC001',	NULL,	1,	'101',	NULL,	NULL,	NULL,	100,	100,	100,	100,	100,	100,	10000,	100,	0,	0,	39,	1,	0,	'',	NULL,	NULL,	'2021-10-05 11:10:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3220,	'RSTG000',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100000,	20100000,	20100000,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:41',	NULL,	'2022-01-26 12:11:41',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3221,	'RSTG001',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100001,	20100001,	20100001,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:41',	NULL,	'2022-01-26 12:11:41',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3222,	'RSTG002',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100002,	20100002,	20100002,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:41',	NULL,	'2022-01-26 12:11:41',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3223,	'RSTG003',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100003,	20100003,	20100003,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:41',	NULL,	'2022-01-26 12:11:41',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3224,	'RSTG004',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100004,	20100004,	20100004,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:41',	NULL,	'2022-01-26 12:11:41',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3225,	'RSTG005',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100005,	20100005,	20100005,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:41',	NULL,	'2022-01-26 12:11:41',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3226,	'RSTG006',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100006,	20100006,	20100006,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:41',	NULL,	'2022-01-26 12:11:41',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3227,	'RSTG007',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100007,	20100007,	20100007,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:41',	NULL,	'2022-01-26 12:11:41',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3228,	'RSTG008',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100008,	20100008,	20100008,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3229,	'RSTG009',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100009,	20100009,	20100009,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3230,	'RSTG010',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100010,	20100010,	20100010,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3231,	'RSTG011',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100011,	20100011,	20100011,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3232,	'RSTG012',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100012,	20100012,	20100012,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3233,	'RSTG013',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100013,	20100013,	20100013,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3234,	'RSTG014',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100014,	20100014,	20100014,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3235,	'RSTG015',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100015,	20100015,	20100015,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3236,	'RSTG016',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100016,	20100016,	20100016,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3237,	'RSTG017',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100017,	20100017,	20100017,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3238,	'RSTG018',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100018,	20100018,	20100018,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3239,	'RSTG019',	NULL,	3,	'201',	NULL,	NULL,	NULL,	999,	999,	999,	20100019,	20100019,	20100019,	999999,	100,	0,	0,	41,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3240,	'RDOCK000',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100000,	30100000,	30100000,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3241,	'RDOCK001',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100001,	30100001,	30100001,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3242,	'RDOCK002',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100002,	30100002,	30100002,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3243,	'RDOCK003',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100003,	30100003,	30100003,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3244,	'RDOCK004',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100004,	30100004,	30100004,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3245,	'RDOCK005',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100005,	30100005,	30100005,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3246,	'RDOCK006',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100006,	30100006,	30100006,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3247,	'RDOCK007',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100007,	30100007,	30100007,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3248,	'RDOCK008',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100008,	30100008,	30100008,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3249,	'RDOCK009',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100009,	30100009,	30100009,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3250,	'RDOCK010',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100010,	30100010,	30100010,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3251,	'RDOCK011',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100011,	30100011,	30100011,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3252,	'RDOCK012',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100012,	30100012,	30100012,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3253,	'RDOCK013',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100013,	30100013,	30100013,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3254,	'RDOCK014',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100014,	30100014,	30100014,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3255,	'RDOCK015',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100015,	30100015,	30100015,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3256,	'RDOCK016',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100016,	30100016,	30100016,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3257,	'RDOCK017',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100017,	30100017,	30100017,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3258,	'RDOCK018',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100018,	30100018,	30100018,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3259,	'RDOCK019',	NULL,	3,	'301',	NULL,	NULL,	NULL,	999,	999,	999,	30100019,	30100019,	30100019,	999999,	100,	0,	0,	42,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3260,	'SSTG0001',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100001,	40100001,	40100001,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3261,	'SSTG0002',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100002,	40100002,	40100002,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3262,	'SSTG0003',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100003,	40100003,	40100003,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3263,	'SSTG0004',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100004,	40100004,	40100004,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3264,	'SSTG0005',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100005,	40100005,	40100005,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3265,	'SSTG0006',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100006,	40100006,	40100006,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3266,	'SSTG0007',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100007,	40100007,	40100007,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3267,	'SSTG0008',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100008,	40100008,	40100008,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3268,	'SSTG0009',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100009,	40100009,	40100009,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3269,	'SSTG0010',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100010,	40100010,	40100010,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3270,	'SSTG0011',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100011,	40100011,	40100011,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3271,	'SSTG0012',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100012,	40100012,	40100012,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3272,	'SSTG0013',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100013,	40100013,	40100013,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3273,	'SSTG0014',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100014,	40100014,	40100014,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3274,	'SSTG0015',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100015,	40100015,	40100015,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3275,	'SSTG0016',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100016,	40100016,	40100016,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3276,	'SSTG0017',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100017,	40100017,	40100017,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3277,	'SSTG0018',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100018,	40100018,	40100018,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3278,	'SSTG0019',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100019,	40100019,	40100019,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3279,	'SSTG0020',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100020,	40100020,	40100020,	999999,	100,	0,	0,	44,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3280,	'SDOCK000',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100000,	40100000,	40100000,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3281,	'SDOCK001',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100001,	40100001,	40100001,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3282,	'SDOCK002',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100002,	40100002,	40100002,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3283,	'SDOCK003',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100003,	40100003,	40100003,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3284,	'SDOCK004',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100004,	40100004,	40100004,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3285,	'SDOCK005',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100005,	40100005,	40100005,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3286,	'SDOCK006',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100006,	40100006,	40100006,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3287,	'SDOCK007',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100007,	40100007,	40100007,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3288,	'SDOCK008',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100008,	40100008,	40100008,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3289,	'SDOCK009',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100009,	40100009,	40100009,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3290,	'SDOCK010',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100010,	40100010,	40100010,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3291,	'SDOCK011',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100011,	40100011,	40100011,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3292,	'SDOCK012',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100012,	40100012,	40100012,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3293,	'SDOCK013',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100013,	40100013,	40100013,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3294,	'SDOCK014',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100014,	40100014,	40100014,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3295,	'SDOCK015',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100015,	40100015,	40100015,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3296,	'SDOCK016',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100016,	40100016,	40100016,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3297,	'SDOCK017',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100017,	40100017,	40100017,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3298,	'SDOCK018',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100018,	40100018,	40100018,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3299,	'SDOCK019',	NULL,	3,	'401',	NULL,	NULL,	NULL,	999,	999,	999,	40100019,	40100019,	40100019,	999999,	100,	0,	0,	45,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3320,	'REMOVE_INV',	NULL,	3,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100000,	100200000,	100100000,	999999,	100,	0,	0,	51,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3321,	'AUDIT',	NULL,	3,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100001,	100200001,	100200001,	999999,	100,	0,	0,	52,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3322,	'COUNT',	NULL,	3,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100002,	10100002,	100100002,	999999,	100,	0,	0,	52,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3323,	'INVADJ',	NULL,	3,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100003,	10100003,	100100003,	999999,	100,	0,	0,	53,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3324,	'INVRCV',	NULL,	3,	'1001',	NULL,	NULL,	NULL,	999,	999,	999,	100100004,	10100004,	100100004,	999999,	100,	0,	0,	54,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3325,	'LINE00',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100000,	60100000,	60100000,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3326,	'LINE01',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100001,	60100001,	60100001,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3327,	'LINE02',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100002,	60100002,	60100002,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3328,	'LINE03',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100003,	60100003,	60100003,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3329,	'LINE04',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100004,	60100004,	60100004,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3330,	'LINE05',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100005,	60100005,	60100005,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3331,	'LINE06',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100006,	60100006,	60100006,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3332,	'LINE07',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100007,	60100007,	60100007,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3333,	'LINE08',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100008,	60100008,	60100008,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3334,	'LINE09',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100009,	60100009,	60100009,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3335,	'LINE10',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100010,	60100010,	60100010,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3336,	'LINE11',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100011,	60100011,	60100011,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3337,	'LINE12',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100012,	60100012,	60100012,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3338,	'LINE13',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100013,	60100013,	60100013,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3339,	'LINE14',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100014,	60100014,	60100014,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3340,	'LINE15',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100015,	60100015,	60100015,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3341,	'LINE16',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100016,	60100016,	60100016,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3342,	'LINE17',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100017,	60100017,	60100017,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3343,	'LINE18',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100018,	60100018,	60100018,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3344,	'LINE19',	NULL,	3,	'601',	NULL,	NULL,	NULL,	999,	999,	999,	60100019,	60100019,	60100019,	999999,	100,	0,	0,	55,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3345,	'LINE00-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200000,	60200000,	60200000,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3346,	'LINE01-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200001,	60200001,	60200001,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3347,	'LINE02-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200002,	60200002,	60200002,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3348,	'LINE03-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200003,	60200003,	60200003,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3349,	'LINE04-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200004,	60200004,	60200004,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3350,	'LINE05-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200005,	60200005,	60200005,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3351,	'LINE06-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200006,	60200006,	60200006,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3352,	'LINE07-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200007,	60200007,	60200007,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3353,	'LINE08-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200008,	60200008,	60200008,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3354,	'LINE09-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200009,	60200009,	60200009,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3355,	'LINE10-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200010,	60200010,	60200010,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3356,	'LINE11-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200011,	60200011,	60200011,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3357,	'LINE12-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200012,	60200012,	60200012,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3358,	'LINE13-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200013,	60200013,	60200013,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3359,	'LINE14-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200014,	60200014,	60200014,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3360,	'LINE15-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200015,	60200015,	60200015,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3361,	'LINE16-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200016,	60200016,	60200016,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3362,	'LINE17-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200017,	60200017,	60200017,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3363,	'LINE18-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200018,	60200018,	60200018,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3364,	'LINE19-IN',	NULL,	3,	'602',	NULL,	NULL,	NULL,	999,	999,	999,	60200019,	60200019,	60200019,	999999,	100,	0,	0,	56,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3365,	'LINE00-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300000,	60300000,	60300000,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3366,	'LINE01-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300001,	60300001,	60300001,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3367,	'LINE02-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300002,	60300002,	60300002,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3368,	'LINE03-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300003,	60300003,	60300003,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3369,	'LINE04-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300004,	60300004,	60300004,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3370,	'LINE05-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300005,	60300005,	60300005,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3371,	'LINE06-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300006,	60300006,	60300006,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3372,	'LINE07-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300007,	60300007,	60300007,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3373,	'LINE08-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300008,	60300008,	60300008,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3374,	'LINE09-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300009,	60300009,	60300009,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3375,	'LINE10-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300010,	60300010,	60300010,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3376,	'LINE11-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300011,	60300011,	60300011,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3377,	'LINE12-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300012,	60300012,	60300012,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3378,	'LINE13-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300013,	60300013,	60300013,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3379,	'LINE14-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300014,	60300014,	60300014,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3380,	'LINE15-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300015,	60300015,	60300015,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3381,	'LINE16-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300016,	60300016,	60300016,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3382,	'LINE17-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300017,	60300017,	60300017,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3383,	'LINE18-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300018,	60300018,	60300018,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(3384,	'LINE19-OUT',	NULL,	3,	'603',	NULL,	NULL,	NULL,	999,	999,	999,	60300019,	60300019,	60300019,	999999,	100,	0,	0,	57,	1,	0,	NULL,	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	0),
(6271,	'S1',	NULL,	1,	'1',	99999,	99999,	99999,	99999,	99999,	99999,	30100000,	30100000,	30100000,	99999,	100,	0,	0,	16,	1,	0,	NULL,	NULL,	NULL,	'2022-09-19 13:55:03',	'XXXX',	NULL,	NULL,	NULL,	NULL,	NULL,	0);


DROP TABLE IF EXISTS `location_group`;
CREATE TABLE `location_group` (
  `location_group_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `location_group_type_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `pickable` tinyint(1) NOT NULL DEFAULT '0',
  `storable` tinyint(1) NOT NULL DEFAULT '0',
  `countable` tinyint(1) NOT NULL DEFAULT '0',
  `adjustable` tinyint(1) NOT NULL DEFAULT '0',
  `allow_cartonization` tinyint(1) NOT NULL DEFAULT '0',
  `tracking_volume` tinyint(1) NOT NULL DEFAULT '0',
  `volume_tracking_policy` varchar(20) DEFAULT NULL,
  `inventory_consolidation_strategy` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `allow_empty_location` tinyint(1) NOT NULL DEFAULT '0',
  `item_volume_tracking_level` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `tracking_location_utilization` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`location_group_id`),
  KEY `location_group_type_id` (`location_group_type_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `location_group_ibfk_1` FOREIGN KEY (`location_group_type_id`) REFERENCES `location_group_type` (`location_group_type_id`),
  CONSTRAINT `location_group_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `location_group` (`location_group_id`, `name`, `description`, `location_group_type_id`, `warehouse_id`, `pickable`, `storable`, `countable`, `adjustable`, `allow_cartonization`, `tracking_volume`, `volume_tracking_policy`, `inventory_consolidation_strategy`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `allow_empty_location`, `item_volume_tracking_level`, `tracking_location_utilization`) VALUES
(1,	'DAMAGED',	'Damaged Inventory Area',	2,	1,	1,	1,	1,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(2,	'RECV_STG',	'Receiving Stage',	3,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(3,	'RECV_DCK',	'Receiving Dock',	5,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(4,	'RECEIPT',	'Receipt',	4,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(5,	'SHIP_STG',	'Shipping Stage',	6,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(6,	'SHIP_DCK',	'Shipping Dock',	7,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(7,	'DISPATCHED',	'Dispatched Trailer',	8,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(8,	'TRAILER',	'Trailer',	14,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(9,	'RF',	'RF locations',	9,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(10,	'YARD',	'Yard for parking',	11,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(11,	'P&D',	'Pickup and Deposit',	12,	1,	0,	0,	0,	1,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(12,	'Default_Removed_Inventory_Location',	'Default Location For Removed Inventory',	13,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(13,	'Audit_Count_Inventory_Location',	'Location For Inventory Removed By Audit Count',	13,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(14,	'Inventory_Adjustment_Location',	'Location For Inventory Removed By Audit Count',	13,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(15,	'Inventory_Receiving_Location',	'Location For Inventory Removed By Audit Count',	13,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(16,	'ProductionLine',	'Production Line',	15,	1,	1,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	'2021-10-06 16:42:03',	NULL,	0,	NULL,	NULL),
(17,	'ProductionLineInbound',	'Production Line Inbound Stage',	16,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(18,	'ProductionLineOutbound',	'Production Line Outbound Stage',	17,	1,	1,	1,	1,	1,	0,	0,	'BY_PALLET',	'NONE',	NULL,	NULL,	'2021-09-21 16:31:25',	NULL,	0,	NULL,	NULL),
(19,	'Order',	'Order',	18,	1,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(20,	'Storage',	'Storage',	1,	1,	1,	1,	1,	1,	0,	0,	'BY_PALLET',	'NONE',	NULL,	NULL,	'2021-09-21 16:31:13',	NULL,	0,	NULL,	NULL),
(21,	'RECV_STG',	'Receiving Stage',	3,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(22,	'RECV_DCK',	'Receiving Dock',	5,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(23,	'RECEIPT',	'Receipt',	4,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(24,	'SHIP_STG',	'Shipping Stage',	6,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(25,	'SHIP_DCK',	'Shipping Dock',	7,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(26,	'DISPATCHED',	'Dispatched Trailer',	8,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(27,	'TRAILER',	'Trailer',	14,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(28,	'RF',	'RF locations',	9,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(29,	'YARD',	'Yard for parking',	11,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(30,	'P&D',	'Pickup and Deposit',	12,	2,	0,	0,	0,	1,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(31,	'Default_Removed_Inventory_Location',	'Default Location For Removed Inventory',	13,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(32,	'Audit_Count_Inventory_Location',	'Location For Inventory Removed By Audit Count',	13,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(33,	'Inventory_Adjustment_Location',	'Location For Inventory Removed By Adjust',	13,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(34,	'Inventory_Receiving_Location',	'Location For Inventory Removed By Inventory receiving',	13,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(35,	'ProductionLine',	'Production Line',	15,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(36,	'ProductionLineInbound',	'Production Line Inbound Stage',	16,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(37,	'ProductionLineOutbound',	'Production Line Outbound Stage',	17,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(38,	'Order',	'Order',	18,	2,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	NULL,	NULL,	NULL,	NULL,	0,	NULL,	NULL),
(39,	'QC',	'QC',	19,	1,	0,	1,	0,	0,	0,	0,	NULL,	'NONE',	'2021-10-04 15:56:25',	NULL,	'2021-10-11 15:52:59',	NULL,	0,	NULL,	NULL),
(40,	'WO',	'Work order temp',	12,	1,	0,	1,	0,	1,	0,	0,	NULL,	'NONE',	'2021-10-20 09:33:13',	NULL,	'2021-10-20 09:33:13',	NULL,	0,	NULL,	NULL),
(41,	'RECV_STG',	'Receiving Stage',	3,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:41',	NULL,	'2022-01-26 12:11:41',	NULL,	0,	NULL,	NULL),
(42,	'RECV_DCK',	'Receiving Dock',	5,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	0,	NULL,	NULL),
(43,	'RECEIPT',	'Receipt',	4,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	0,	NULL,	NULL),
(44,	'SHIP_STG',	'Shipping Stage',	6,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	0,	NULL,	NULL),
(45,	'SHIP_DCK',	'Shipping Dock',	7,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:42',	NULL,	'2022-01-26 12:11:42',	NULL,	0,	NULL,	NULL),
(46,	'DISPATCHED',	'Dispatched Trailer',	8,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(47,	'TRAILER',	'Trailer',	14,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(48,	'RF',	'RF locations',	9,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(49,	'YARD',	'Yard for parking',	11,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(50,	'P&D',	'Pickup and Deposit',	12,	3,	0,	0,	0,	1,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(51,	'Default_Removed_Inventory_Location',	'Default Location For Removed Inventory',	13,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(52,	'Audit_Count_Inventory_Location',	'Location For Inventory Removed By Audit Count',	13,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(53,	'Inventory_Adjustment_Location',	'Location For Inventory Removed By Adjust',	13,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(54,	'Inventory_Receiving_Location',	'Location For Inventory Removed By Inventory receiving',	13,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(55,	'ProductionLine',	'Production Line',	15,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(56,	'ProductionLineInbound',	'Production Line Inbound Stage',	16,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:43',	NULL,	'2022-01-26 12:11:43',	NULL,	0,	NULL,	NULL),
(57,	'ProductionLineOutbound',	'Production Line Outbound Stage',	17,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	0,	NULL,	NULL),
(58,	'Order',	'Order',	18,	3,	0,	0,	0,	0,	0,	0,	NULL,	'NONE',	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL,	0,	NULL,	NULL),
(59,	'Storage',	'Storage',	1,	3,	1,	1,	1,	1,	0,	0,	NULL,	'NONE',	'2022-01-26 12:12:38',	NULL,	'2022-01-26 12:12:38',	NULL,	0,	NULL,	NULL);

DROP TABLE IF EXISTS `location_group_type`;
CREATE TABLE `location_group_type` (
  `location_group_type_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `four_wall_inventory` tinyint(1) NOT NULL DEFAULT '1',
  `virtual_locations` tinyint(1) NOT NULL DEFAULT '0',
  `receiving_stage_locations` tinyint(1) NOT NULL DEFAULT '0',
  `shipping_stage_locations` tinyint(1) NOT NULL DEFAULT '0',
  `dock_locations` tinyint(1) NOT NULL DEFAULT '0',
  `yard_locations` tinyint(1) NOT NULL DEFAULT '0',
  `storage_locations` tinyint(1) NOT NULL DEFAULT '0',
  `pickup_and_deposit_locations` tinyint(1) NOT NULL DEFAULT '0',
  `trailer_locations` tinyint(1) NOT NULL DEFAULT '0',
  `shipped_parcel_locations` tinyint(1) NOT NULL DEFAULT '0',
  `shipped_order_locations` tinyint(1) NOT NULL DEFAULT '0',
  `rf_locations` tinyint(1) NOT NULL DEFAULT '0',
  `grid` tinyint(1) NOT NULL DEFAULT '0',
  `production_line_locations` tinyint(1) NOT NULL DEFAULT '0',
  `production_line_inbound_locations` tinyint(1) NOT NULL DEFAULT '0',
  `production_line_outbound_locations` tinyint(1) NOT NULL DEFAULT '0',
  `container_locations` tinyint(1) NOT NULL DEFAULT '0',
  `packing_stations` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `qc_area` tinyint(1) NOT NULL DEFAULT '0',
  `customer_return_stage_locations` tinyint(1) NOT NULL DEFAULT '0',
  `shipped_inventory_locations` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_group_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `location_group_type` (`location_group_type_id`, `name`, `description`, `four_wall_inventory`, `virtual_locations`, `receiving_stage_locations`, `shipping_stage_locations`, `dock_locations`, `yard_locations`, `storage_locations`, `pickup_and_deposit_locations`, `trailer_locations`, `shipped_parcel_locations`, `shipped_order_locations`, `rf_locations`, `grid`, `production_line_locations`, `production_line_inbound_locations`, `production_line_outbound_locations`, `container_locations`, `packing_stations`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `qc_area`, `customer_return_stage_locations`, `shipped_inventory_locations`) VALUES
(1,	'Storage',	'Storage Locations',	1,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(2,	'Damaged',	'Damaged Inventory Locations',	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(3,	'Receive_Stage',	'Receiving Stage',	1,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(4,	'Receipt',	'Receipt',	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(5,	'Receive_Dock',	'Receiving Dock',	1,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(6,	'Shipping_Stage',	'Shipping Stage',	1,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(7,	'Shipping_Dock',	'Shipping Dock',	1,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(8,	'Dispatched',	'Dispatched Shipment',	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'2023-05-17 09:00:00',	'CWMS-USER',	'2023-06-21 10:24:11',	'CWMS-USER',	0,	0,	1),
(9,	'RF',	'RF device',	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(10,	'Grid',	'Grid',	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(11,	'Yard',	'Yard',	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(12,	'PickupDeposit',	'Pickup and Deposit',	1,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(13,	'Removed_Inventory',	'Removed Inventory',	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(14,	'Trailer',	'Trailer',	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'2023-05-17 09:00:03',	'CWMS-USER',	'2023-06-21 10:24:12',	'CWMS-USER',	0,	0,	0),
(15,	'ProductionLine',	'Production Line',	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(16,	'ProductionLineInbound',	'Production Line Inbound Stage',	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(17,	'ProductionLineOutbound',	'Production Line Outbound Stage',	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(18,	'Shipped_Order',	'Order that already shipped',	0,	1,	0,	0,	0,	0,	0,	0,	1,	0,	1,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	0,	0,	0),
(19,	'QC',	'QC Area',	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	1,	0,	0),
(20,	'Customer_Return_Stage',	'Customer Return stage area',	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	'2023-05-17 09:00:09',	'CWMS-USER',	'2023-06-21 10:24:13',	'CWMS-USER',	0,	1,	0);

DROP TABLE IF EXISTS `location_utilization_snapshot`;
CREATE TABLE `location_utilization_snapshot` (
  `location_utilization_snapshot_id` bigint NOT NULL AUTO_INCREMENT,
  `client_location_utilization_snapshot_batch_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `net_volume` double NOT NULL,
  `gross_volume` double NOT NULL,
  `total_locations` int DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `capacity_unit` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`location_utilization_snapshot_id`),
  KEY `item_id` (`item_id`),
  KEY `client_location_utilization_snapshot_batch_id` (`client_location_utilization_snapshot_batch_id`),
  CONSTRAINT `location_utilization_snapshot_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`),
  CONSTRAINT `location_utilization_snapshot_ibfk_2` FOREIGN KEY (`client_location_utilization_snapshot_batch_id`) REFERENCES `client_location_utilization_snapshot_batch` (`client_location_utilization_snapshot_batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `location_utilization_snapshot_batch`;
CREATE TABLE `location_utilization_snapshot_batch` (
  `location_utilization_snapshot_batch_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(50) DEFAULT NULL,
  `net_volume` double NOT NULL,
  `gross_volume` double NOT NULL,
  `total_locations` int DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `complete_time` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `capacity_unit` varchar(50) DEFAULT NULL,
  `total_lpns` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_utilization_snapshot_batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `location_utilization_snapshot_detail`;
CREATE TABLE `location_utilization_snapshot_detail` (
  `location_utilization_snapshot_detail_id` bigint NOT NULL AUTO_INCREMENT,
  `location_utilization_snapshot_id` bigint NOT NULL,
  `net_volume` double NOT NULL,
  `gross_volume` double NOT NULL,
  `location_id` bigint DEFAULT NULL,
  `location_size` double DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `capacity_unit` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`location_utilization_snapshot_detail_id`),
  KEY `location_utilization_snapshot_id` (`location_utilization_snapshot_id`),
  CONSTRAINT `location_utilization_snapshot_detail_ibfk_1` FOREIGN KEY (`location_utilization_snapshot_id`) REFERENCES `location_utilization_snapshot` (`location_utilization_snapshot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `master_production_schedule`;
CREATE TABLE `master_production_schedule` (
  `master_production_schedule_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `cutoff_date` date NOT NULL,
  `item_id` bigint NOT NULL,
  `total_quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`master_production_schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `master_production_schedule_line`;
CREATE TABLE `master_production_schedule_line` (
  `master_production_schedule_line_id` bigint NOT NULL AUTO_INCREMENT,
  `master_production_schedule_id` bigint NOT NULL,
  `planned_quantity` bigint NOT NULL,
  `production_line_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`master_production_schedule_line_id`),
  KEY `master_production_schedule_id` (`master_production_schedule_id`),
  CONSTRAINT `master_production_schedule_line_ibfk_1` FOREIGN KEY (`master_production_schedule_id`) REFERENCES `master_production_schedule` (`master_production_schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `master_production_schedule_line_date`;
CREATE TABLE `master_production_schedule_line_date` (
  `master_production_schedule_line_date_id` bigint NOT NULL AUTO_INCREMENT,
  `master_production_schedule_line_id` bigint NOT NULL,
  `planned_quantity` bigint NOT NULL,
  `planned_date` date DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`master_production_schedule_line_date_id`),
  KEY `master_production_schedule_line_id` (`master_production_schedule_line_id`),
  CONSTRAINT `master_production_schedule_line_date_ibfk_1` FOREIGN KEY (`master_production_schedule_line_id`) REFERENCES `master_production_schedule_line` (`master_production_schedule_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `material_requirements_planning`;
CREATE TABLE `material_requirements_planning` (
  `material_requirements_planning_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `master_production_schedule_id` bigint NOT NULL,
  `cutoff_date` date NOT NULL,
  `item_id` bigint NOT NULL,
  `total_required_quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`material_requirements_planning_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `material_requirements_planning_line`;
CREATE TABLE `material_requirements_planning_line` (
  `material_requirements_planning_line_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `parent_mrp_line_id` bigint DEFAULT NULL,
  `material_requirements_planning_id` bigint NOT NULL,
  `bill_of_material_id` bigint DEFAULT NULL,
  `total_required_quantity` bigint NOT NULL,
  `required_quantity` bigint NOT NULL,
  `expected_inventory_on_hand` bigint NOT NULL,
  `expected_receive_quantity` bigint NOT NULL,
  `expected_order_quantity` bigint NOT NULL,
  `expected_work_order_quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`material_requirements_planning_line_id`),
  KEY `material_requirements_planning_id` (`material_requirements_planning_id`),
  KEY `bill_of_material_id` (`bill_of_material_id`),
  CONSTRAINT `material_requirements_planning_line_ibfk_1` FOREIGN KEY (`material_requirements_planning_id`) REFERENCES `material_requirements_planning` (`material_requirements_planning_id`),
  CONSTRAINT `material_requirements_planning_line_ibfk_2` FOREIGN KEY (`bill_of_material_id`) REFERENCES `bill_of_material` (`bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT,
  `text` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `i18n` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `menu_sub_group_id` bigint NOT NULL,
  `sequence` int NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `is_system_admin_menu` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`menu_id`),
  UNIQUE KEY `name` (`name`),
  KEY `menu_sub_group_id` (`menu_sub_group_id`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`menu_sub_group_id`) REFERENCES `menu_sub_group` (`menu_sub_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `menu` (`menu_id`, `text`, `name`, `i18n`, `link`, `icon`, `menu_sub_group_id`, `sequence`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `enabled`, `is_system_admin_menu`) VALUES
(1,	'Default',	'Dashboard-Default',	'menu.dashboard.default',	'/dashboard/v1',	'',	1,	1,	'2023-05-17 09:05:35',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(3,	'User',	'Auth-User',	'menu.main.auth.user',	'/auth/user',	'',	2,	1,	'2023-05-17 09:05:42',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(4,	'Role',	'Auth-Role',	'menu.main.auth.role',	'/auth/role',	'',	2,	2,	'2023-05-17 09:05:42',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(5,	'WorkingTeam',	'Auth-WorkingTeam',	'menu.main.auth.working-team',	'/auth/working-team',	'',	2,	4,	'2023-05-17 09:05:46',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(6,	'Warehouse',	'Layout-warehouse',	'menu.main.layout.warehouse',	'/warehouse-layout/warehouse',	'',	3,	1,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(7,	'LocationGroup',	'Layout-Location-Group',	'menu.main.layout.location.group',	'/warehouse-layout/location-group',	'',	3,	2,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(8,	'WarehouseLocation',	'Layout-Location',	'menu.main.layout.location',	'/warehouse-layout/warehouse-location',	'',	3,	3,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(9,	'Item Family',	'Inventory-ItemFamily',	'menu.main.inventory.item-family',	'/inventory/item-family',	'',	4,	1,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(10,	'Item',	'Inventory-Item',	'menu.main.inventory.item',	'/inventory/item',	'',	4,	2,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(11,	'inventory',	'Inventory-Inventory',	'menu.main.inventory.inventory',	'/inventory/inventory',	'',	4,	3,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(12,	'inventory activity',	'Inventory-InventoryActivity',	'menu.main.inventory.inventory-activity',	'/inventory/inventory-activity',	'',	4,	4,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(13,	'inventory adjust',	'Inventory-InventoryAdjust',	'menu.main.inventory.inventory-adjust',	'/inventory/inventory-adjust',	'',	4,	5,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(14,	'inventory adjust request',	'Inventory-InventoryAdjustmentRequest',	'menu.main.inventory.inventory-adjustment-request',	'/inventory/inventory-adjustment-request',	'',	4,	6,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(15,	'inventory adjustment Threshold',	'Inventory-InventoryAdjustmentThreshold',	'menu.main.inventory.inventory-adjustment-threshold',	'/inventory/inventory-adjustment-threshold',	'',	4,	7,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(16,	'Movement Path',	'Inventory-MovementPath',	'menu.main.inventory.movement-path',	'/inventory/movement-path',	'',	4,	8,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(17,	'Cycle Count',	'Inventory-CycleCount',	'menu.main.inventory.count.cycle-count',	'/inventory/count/cycle-count',	'',	4,	9,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(18,	'Emergency Replenishment Configuration',	'Inventory-EmerReplConfig',	'menu.main.inventory.replenishment.emergency.config',	'/inventory/replenishment/emergency/config',	'',	4,	10,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(19,	'Trigger Replenishment Configuration',	'Inventory-TriggerReplConfig',	'menu.main.inventory.replenishment.trigger.config',	'/inventory/replenishment/trigger/config',	'',	4,	11,	'2023-05-17 09:05:48',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(20,	'Replenishment Display',	'Inventory-ReplDisplay',	'menu.main.inventory.replenishment.display',	'/inventory/replenishment',	'',	4,	12,	'2023-05-17 09:05:48',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(21,	'Inventory Configuration',	'Inventory-Configuration',	'menu.main.inventory.configuration',	'/inventory/configuration',	'',	4,	13,	'2023-05-17 09:05:49',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(22,	'Inventory Snapshot',	'Inventory-Snapshot',	'menu.main.inventory.snapshot',	'/inventory/snapshot',	'',	4,	16,	'2023-05-17 09:05:54',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(23,	'Receipt',	'Inbound-receipt',	'menu.main.inbound.receipt',	'/inbound/receipt',	'',	5,	1,	'2023-05-17 09:06:05',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(24,	'Putaway Configuration',	'Inbound-PutawayConfig',	'menu.main.inbound.putaway-configuration',	'/inbound/putaway-configuration',	'',	5,	3,	'2023-05-17 09:06:06',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(25,	'Order',	'Outbound-Order',	'menu.main.outbound.order',	'/outbound/order',	'',	6,	1,	'2023-05-17 09:06:09',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(26,	'Shipment',	'Outbound-Shipment',	'menu.main.outbound.shipment',	'/outbound/shipment',	'',	6,	2,	'2023-05-17 09:06:10',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(27,	'Wave',	'Outbound-Wave',	'menu.main.outbound.wave',	'/outbound/wave',	'',	6,	3,	'2023-05-17 09:06:10',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(28,	'Pick',	'Outbound-Pick',	'menu.main.outbound.pick',	'/outbound/pick',	'',	6,	4,	'2023-05-17 09:06:10',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(29,	'Pick List',	'Outbound-PickList',	'menu.main.outbound.pick-list',	'/outbound/pick-list',	'',	6,	5,	'2023-05-17 09:06:10',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(30,	'Carton',	'Outbound-Carton',	'menu.main.outbound.carton',	'/outbound/carton',	'',	6,	6,	'2023-05-17 09:06:11',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(31,	'Cartonization Configuration',	'Outbound-CartonizationConfiguration',	'menu.main.outbound.cartonization-configuration',	'/outbound/cartonization-configuration',	'',	6,	7,	'2023-05-17 09:06:12',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(32,	'Cartonization',	'Outbound-Cartonization',	'menu.main.outbound.cartonization',	'/outbound/cartonization',	'',	6,	8,	'2023-05-17 09:06:13',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(33,	'Shipping Cartonization',	'Outbound-ShippingCartonization',	'menu.main.outbound.shipping-cartonization',	'/outbound/shipping-cartonization',	'',	6,	9,	'2023-05-17 09:06:13',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(34,	'Grid',	'Outbound-Grid',	'menu.main.outbound.grid',	'/outbound/grid',	'',	6,	10,	'2023-05-17 09:06:13',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(35,	'Pick Confirm',	'Outbound-PickConfirm',	'menu.main.outbound.pick-confirm',	'/outbound/pick/confirm',	'',	6,	11,	'2023-05-17 09:06:15',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(36,	'Short Allocation',	'Outbound-ShortAllocation',	'menu.main.outbound.short-allocation',	'/outbound/short-allocation',	'',	6,	12,	'2023-05-17 09:06:17',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(37,	'Trailer',	'Outbound-Trailer',	'menu.main.outbound.trailer',	'/outbound/trailer',	'',	6,	10,	NULL,	NULL,	'2022-02-08 16:37:45',	NULL,	1,	0),
(38,	'Allocation Configuration',	'Outbound-AllocationConfiguration',	'menu.main.outbound.allocation-configuration',	'/outbound/allocation-configuration',	'',	6,	14,	'2023-05-17 09:06:20',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(39,	'Bill Of Material',	'Bill-Of-Material',	'menu.main.work-order.bill-of-material',	'/work-order/bill-of-material',	'',	7,	1,	'2023-05-17 09:06:24',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(40,	'Production Plan',	'Production-Plan',	'menu.main.work-order.production-plan',	'/work-order/production-plan',	'',	7,	2,	'2023-05-17 09:06:24',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(41,	'Work Order',	'Work-Order',	'menu.main.work-order.work-order',	'/work-order/work-order',	'',	7,	3,	'2023-05-17 09:06:24',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(42,	'Production Line',	'Production-Line',	'menu.main.work-order.production-line',	'/work-order/production-line',	'',	7,	4,	'2023-05-17 09:06:25',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(43,	'Production Kanban',	'Production-Kanban',	'menu.dashboard.production-kanban',	'/work-order/production-kanban',	'',	7,	6,	'2023-05-17 09:06:26',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(44,	'Mould',	'Mould',	'menu.main.work-order.mould',	'/work-order/mould',	'',	7,	7,	'2023-05-17 09:06:27',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(45,	'Integration Data',	'Integration-Data',	'menu.main.integration.data',	'/integration/integration-data',	'',	8,	1,	'2023-05-17 09:06:33',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(46,	'Client',	'Common-Client',	'menu.main.common.client',	'/common/client',	'',	9,	1,	'2023-05-17 09:06:33',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(47,	'Supplier',	'Common-Supplier',	'menu.main.common.supplier',	'/common/supplier',	'',	9,	2,	'2023-05-17 09:06:34',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(48,	'Customer',	'Common-Customer',	'menu.main.common.customer',	'/common/customer',	'',	9,	3,	'2023-05-17 09:06:34',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(49,	'Unit Of Measure',	'Common-UnitOfMeasure',	'menu.main.common.unit-of-measure',	'/common/unit-of-measure',	'',	9,	4,	'2023-05-17 09:06:34',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(50,	'File Upload',	'Util-File-Upload',	'menu.main.util.file-upload',	'/util/file-upload',	'',	12,	1,	'2023-05-17 09:06:35',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(51,	'Test Data Initial',	'Util-TestDataInit',	'menu.main.util.test-data-init',	'',	'',	12,	2,	'2023-05-17 09:06:36',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	1),
(52,	'Tester',	'Util-Tester',	'menu.main.util.tester',	'/util/tester',	'',	12,	3,	'2023-05-17 09:06:37',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	1),
(53,	'Valid Icon',	'Util-ValidIcon',	'menu.main.util.icon-list',	'/util/icon-list',	'',	12,	4,	'2023-05-17 09:06:37',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	1),
(54,	'System Configuration',	'Util-SystemConfiguration',	'menu.main.util.system-config',	'/util/system-configuration',	'',	12,	5,	'2023-05-17 09:06:37',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	1),
(55,	'Work Task',	'WorkTask-WorkTask',	'menu.main.work-task.work-task',	'/work-task/work-task',	'',	10,	1,	'2023-05-17 09:06:43',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(56,	'Report',	'Report-Report',	'menu.main.report.report',	'/report/report',	'',	11,	1,	'2023-05-17 09:06:44',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(57,	'Report History',	'Report-Report-History',	'menu.main.report.report-history',	'/report/report-history',	'',	11,	2,	'2023-05-17 09:06:44',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(58,	'Report Printer Configuration',	'Report-Report-PRINTER-CONFIGURATION',	'menu.main.report.report-printer-configuration',	'/report/report-printer-configuration',	'',	11,	3,	'2023-05-17 09:06:44',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(59,	'Receive',	'Mobile-Inbound-Receive',	'menu.mobile.inbound.receive',	'receive',	'menu_inbound_receive.png',	13,	1,	'2023-05-17 09:06:44',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(60,	'Pick By Order',	'Mobile-Outbound-PickByOrder',	'menu.mobile.outbound.pick-by-order',	'pick_by_order',	'menu_outbound_pick_order.png',	14,	1,	'2023-05-17 09:06:45',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(61,	'Pick By List',	'Mobile-Outbound-PickByList',	'menu.mobile.outbound.pick-by-list',	'pick_by_list',	'menu_outbound_pick_list.png',	14,	2,	'2023-05-17 09:06:45',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(62,	'Pick By Tote',	'Mobile-Outbound-PickByTote',	'menu.mobile.outbound.pick-by-tote',	'pick_by_tote',	'menu_outbound_pick_tote.png',	14,	3,	'2023-05-17 09:06:45',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(63,	'Inventory',	'Mobile-Inventory-Inventory',	'menu.mobile.inventory.inventory',	'inventory',	'menu_inventory.png',	15,	1,	'2023-05-17 09:06:45',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(64,	'Count',	'Mobile-Inventory-Count',	'menu.mobile.inventory.count',	'cycle_count_batch',	'menu_inventory_count.png',	15,	2,	'2023-05-17 09:06:45',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(65,	'Audit Count',	'Mobile-Inventory-AuditCount',	'menu.mobile.inventory.audit-count',	'audit_count_batch',	'menu_inventory_audit.png',	15,	3,	'2023-05-17 09:06:46',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(66,	'Inventory Putaway',	'Mobile-Inventory-InventoryPutaway',	'menu.mobile.inventory.inventoryPutaway',	'inventory_putaway',	'menu_inventory_putaway.png',	15,	4,	'2023-05-17 09:06:46',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(67,	'Pick By Work Order',	'Mobile-WorkOrder-PickByWorkOrder',	'menu.mobile.work-order.pick-by-work-order',	'pick_by_work_order',	'menu_workorder_pick.png',	16,	1,	'2023-05-17 09:06:46',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(68,	'Produce',	'Mobile-WorkOrder-Produce',	'menu.mobile.work-order.produce',	'work_order_produce',	'menu_workorder_produce.png',	16,	2,	'2023-05-17 09:06:46',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(69,	'Production Line Check In',	'Mobile-WorkOrder-ProductionLineCheckIn',	'menu.mobile.work-order.production_line_check_in',	'production_line_check_in',	'menu_workorder_checkin.png',	16,	5,	'2023-05-17 09:06:47',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(70,	'Production Line Check Out',	'Mobile-WorkOrder-ProductionLineCheckOut',	'menu.mobile.work-order.production_line_check_out',	'production_line_check_out',	'menu_workorder_checkout.png',	16,	6,	'2023-05-17 09:06:47',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(71,	'Work Order Configuration',	'Work-Order-Config',	'menu.main.work-order.work-order-config',	'/work-order/work-order-configuration',	'',	7,	8,	'2023-05-17 09:06:28',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(72,	'RF',	'Util-RF',	'menu.main.util.rf',	'/util/rf',	'',	12,	6,	'2023-05-17 09:06:38',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(73,	'System Controlled Number',	'Util-SysControlledNum',	'menu.main.util.sys-controlled-num',	'/util/system-controlled-number',	'',	12,	9,	'2023-05-17 09:06:40',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(74,	'Inventory Lost And Found',	'Mobile-Inventory-InventoryLF',	'menu.mobile.inventory.inventoryLF',	'inventory_lost_and_found',	'menu_inventory_lf.png',	15,	5,	'2023-05-17 09:06:46',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(75,	'Work Order Produce Transaction',	'Produce-Transaction',	'menu.main.work-order.wo-produce-transaction',	'/work-order/produce-transaction',	'',	7,	5,	'2023-05-17 09:06:26',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(76,	'Data Initial',	'Util-DataInitial',	'menu.main.util.data-initial',	'/util/data-init',	'',	12,	10,	'2023-05-17 09:06:40',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	1),
(77,	'Billable Request',	'Util-BillableRequest',	'menu.main.util.billable-request',	'/util/billable-request',	'',	12,	11,	'2023-05-17 09:06:40',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(78,	'QC Configuration',	'Inbound-QCConfig',	'menu.main.inbound.qc-configuration',	'/inbound/inbound-qc-configuration',	'',	5,	4,	'2023-05-17 09:06:07',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(79,	'QC Rule Maintenance',	'QC-Rule',	'menu.main.qc.qc-rule',	'/qc/rules',	'',	17,	1,	'2023-05-17 09:06:00',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(80,	'QC Rule Configuration',	'QC-Rule-Configuration',	'menu.main.qc.qc-rule-configuration',	'/qc/rules/configuration',	'',	17,	2,	'2023-05-17 09:06:00',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(81,	'QC Inspection',	'QC-Inspection',	'menu.main.qc.qc-inspection',	'/qc/inspection',	'',	17,	3,	'2023-05-17 09:06:02',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(82,	'QC Configuration',	'QC-Configuration',	'menu.main.qc.qc-configuration',	'/qc/configuration',	'',	17,	2,	'2023-05-17 09:06:02',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(83,	'QC Result',	'QC-Result',	'menu.main.qc.qc-result',	'/qc/result',	'',	17,	3,	'2023-05-17 09:06:04',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(84,	'Work Order QC Rule Configuration',	'Work-Order-QC-Rule-Config',	'menu.main.work-order.qc-rule-config',	'/work-order/qc-rule-configuration',	'',	7,	9,	'2023-05-17 09:06:29',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(85,	'Work Order QC Result',	'Work-Order-QC-Result',	'menu.main.work-order.qc-result',	'/work-order/qc-inspection-result',	'',	7,	10,	'2021-10-19 15:52:13',	NULL,	'2021-10-19 15:52:13',	NULL,	NULL,	NULL),
(86,	'Inventory QC',	'Mobile-Inventory-QC',	'menu.mobile.inventory.qc',	'inventory_qc',	'menu_inventory_qc.png',	15,	6,	'2023-05-17 09:06:46',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(87,	'Work Order QC',	'Mobile-WorkOrder-QC',	'menu.mobile.work-order.qc',	'work_order_qc',	'menu_work_order_qc.png',	16,	3,	'2023-05-17 09:06:47',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(88,	'Work Order Labor',	'Work-Order-Labor',	'menu.main.work-order.labor',	'/work-order/labor',	'',	7,	10,	'2023-05-17 09:06:29',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(89,	'Work Order Labor Activity',	'Work-Order-LaborActivity',	'menu.main.work-order.labor-activity',	'/work-order/labor-activity',	'',	7,	11,	'2023-05-17 09:06:29',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(90,	'Inventory Allocation Summary',	'Inventory-Allocation-Summary',	'menu.main.inventory.allocation-summary',	'/inventory/inventory-allocation-summary',	'',	4,	15,	'2023-05-17 09:05:52',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(91,	'Department',	'Auth-Department',	'menu.main.auth.department',	'/auth/department',	'',	2,	5,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(92,	'RF App Version',	'Util-RFAppVersion',	'menu.main.util.rf-app-version',	'/util/rf-app-version',	'',	12,	7,	'2023-05-17 09:06:38',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	1),
(93,	'Company',	'Util-Company',	'menu.main.util.company',	'/util/company',	'',	12,	12,	'2023-05-17 09:06:40',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	1),
(94,	'QC Sampling',	'Mobile-WorkOrder-QC-Sampling',	'menu.mobile.work-order.qc-sampling',	'work_order_qc_sampling',	'menu_work_order_qc_sampling.png',	16,	4,	'2023-05-17 09:06:47',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(95,	'Menu',	'Util-Menu',	'menu.main.util.menu',	'/util/menu',	'',	12,	13,	'2023-05-17 09:06:40',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	1),
(96,	'Data Transfer',	'Util-DataTransfer',	'menu.main.util.data-transfer',	'/util/data-transfer',	'',	12,	14,	'2023-05-17 09:06:40',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	1),
(97,	'Inventory Sampling',	'Inventory-ItemSampling',	'menu.main.inventory.item-sampling',	'/inventory/item-sampling',	'',	4,	17,	'2023-05-17 09:05:54',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(98,	'Item Sampling',	'Mobile-Inventory-Item-Sampling',	'menu.mobile.inventory.item-sampling',	'item_sampling',	'menu_inventory_item_sampling.png',	15,	7,	'2023-05-17 09:06:46',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(99,	'Lock',	'Inventory-Lock',	'menu.main.inventory.lock',	'/inventory/lock',	'',	4,	21,	'2023-05-17 09:05:58',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(100,	'Customer Return',	'Inbound-CustomerReturn',	'menu.main.inbound.customer-return',	'/inbound/customer-return',	'',	5,	2,	'2023-05-17 09:06:05',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(101,	'Order Activity',	'Outbound-OrderActivity',	'menu.main.outbound.order-activity',	'/outbound/order-activity',	'',	6,	15,	'2023-05-17 09:06:20',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(102,	'Master Production Schedule',	'Work-Order-MPS',	'menu.main.work-order.mps',	'/work-order/mps',	'',	7,	12,	'2023-05-17 09:06:30',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(103,	'Material Requirements Planning',	'Work-Order-MRP',	'menu.main.work-order.mrp',	'/work-order/mrp',	'',	7,	14,	'2023-05-17 09:06:31',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(104,	'Master Production Schedule View',	'Work-Order-MPS-VIEW',	'menu.main.work-order.mps-view',	'/work-order/mps-view',	'',	7,	13,	'2023-05-17 09:06:30',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(105,	'Alert',	'Alert-Alert',	'menu.main.alert.alert',	'/alert/alert',	'',	18,	1,	'2023-05-17 09:06:41',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	1),
(106,	'Alert Configuration',	'Alert-Config',	'menu.main.alert.config',	'/alert/configuration',	'',	18,	2,	'2023-05-17 09:06:41',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	1),
(107,	'Alert Subscription',	'Alert-Subscription',	'menu.main.alert.subscription',	'/alert/subscription',	'',	18,	3,	'2023-05-17 09:06:41',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(108,	'Alert Subscription Maintenance',	'Alert-Subscription-Maint',	'menu.main.alert.subscription-maintenance',	'/alert/subscription-maintenance',	'',	18,	4,	NULL,	NULL,	'2022-03-17 16:22:47',	NULL,	1,	1),
(109,	'Allocation Transaction History',	'Outbound-AllocTransHistory',	'menu.main.outbound.allocation-transaction-history',	'/outbound/allocation-transaction-history',	'',	6,	16,	'2023-05-17 09:06:21',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(112,	'Tractor',	'transport-Tractor',	'menu.main.transport.tractor',	'/transportation/tractor',	'',	19,	1,	'2023-05-17 09:06:34',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(113,	'Trailer',	'transport-Trailer',	'menu.main.transport.trailer',	'/transportation/trailer',	'',	19,	2,	'2023-05-17 09:06:34',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(114,	'Warehouse Configuration',	'Warehouse-Config',	'menu.main.layout.warehouse-configuration',	'/warehouse-layout/warehouse-configuration',	'',	3,	4,	'2023-05-17 09:05:47',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(115,	'Location Utilization Snapshot',	'Location-Utilization-Snapshot',	'menu.main.inventory.location-util',	'/inventory/location-utilization-snapshot',	'',	4,	18,	'2023-05-17 09:05:56',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(116,	'Billing Rate',	'Billing-Rate',	'menu.main.billing.rate',	'/billing/rate',	'',	20,	1,	'2023-05-17 09:06:42',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(117,	'Invoice',	'Billing-Invoice',	'menu.main.billing.invoice',	'/billing/invoice',	'',	20,	2,	'2023-05-17 09:06:42',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(118,	'Manual Pick',	'Mobile-WorkOrder-Manual-Pick',	'menu.mobile.work-order.manual-pick',	'work_order_manual_pick',	'menu_workorder_manual_pick.png',	16,	7,	'2023-05-17 09:06:47',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(119,	'Printer',	'Report-Report-Printer',	'menu.main.report.printer',	'/report/printer',	'',	11,	4,	'2023-05-17 09:06:44',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(120,	'Printer Type',	'Report-Report-PrinterType',	'menu.main.report.printer-type',	'/report/printer-type',	'',	11,	5,	'2023-05-17 09:06:44',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(121,	'Purchase Order',	'Inbound-PurchaseOrder',	'menu.main.inbound.purchaseOrder',	'/inbound/purchase-order',	'',	5,	5,	'2023-05-17 09:06:07',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(122,	'QuickBook Auth',	'Util-QuickBookAuth',	'menu.main.util.quickbook-auth',	'/util/quickbook-auth',	'',	12,	15,	'2023-05-17 09:06:41',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	1),
(123,	'Load',	'Outbound-Load',	'menu.main.outbound.load',	'/outbound/load',	'',	6,	13,	'2023-05-17 09:06:18',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(124,	'Stop',	'Outbound-Stop',	'menu.main.outbound.stop',	'/outbound/stop',	'',	6,	13,	'2023-05-17 09:06:19',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(125,	'QuickBook Configuration',	'Util-QuickbookConfig',	'menu.main.util.quickbook-config',	'/util/quickbook/configuration',	'',	12,	16,	'2023-05-17 09:06:41',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	1),
(126,	'Inventory Status',	'Inventory-Status',	'menu.main.inventory.status',	'/inventory/status',	'',	4,	20,	'2023-05-17 09:05:58',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(127,	'RF Configuration',	'Util-RFConfiguration',	'menu.main.util.rf-configuration',	'/util/rf-configuration',	'',	12,	8,	'2023-05-17 09:06:40',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(128,	'Alert Template',	'Alert-Template',	'menu.main.alert.template',	'/alert/template',	'',	18,	4,	'2023-05-17 09:06:42',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(129,	'Production Line Status',	'Production-Line-Status',	'menu.main.work-order.production-line-status',	'/work-order/production-line-status',	'',	7,	15,	'2023-05-17 09:06:31',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(130,	'Production Line Monitor',	'Production-Line-Monitor',	'menu.main.work-order.production-line-monitor',	'/work-order/production-line-monitor',	'',	7,	17,	'2023-05-17 09:06:31',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(131,	'Production Line Monitor Transaction',	'Production-Line-Monitor-Transaction',	'menu.main.work-order.production-line-monitor-transaction',	'/work-order/production-line-monitor/transaction',	'',	7,	18,	'2023-05-17 09:06:32',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(132,	'Production Line Dashboard',	'Production-Line-Dashboard',	'menu.main.work-order.production-line-dashboard',	'/work-order/production-line-dashboard',	'',	7,	16,	'2023-05-17 09:06:31',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(133,	'Pick List Configuration',	'Outbound-ListPickConfigure',	'menu.main.outbound.list-pick-configuration',	'/outbound/list-pick-configuration',	'',	6,	5,	'2023-05-17 09:06:10',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(134,	'Production Line Status Display',	'Production-Line-Status-Display',	'menu.main.work-order.production-line-status-display',	'/work-order/production-line-status/display',	'',	7,	19,	'2023-05-17 09:06:32',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(135,	'Production Kanban',	'Dashboard-Production-Line',	'menu.dashboard.production-kanban',	'/work-order/production-line-dashboard',	'',	1,	2,	'2023-05-17 09:05:36',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(136,	'Inventory Kanban',	'Dashboard-Inventory',	'menu.dashboard.inventory-kanban',	'/inventory/inventory-dashboard',	'',	1,	3,	'2023-05-17 09:05:38',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(137,	'Location Kanban',	'Dashboard-Location',	'menu.dashboard.location-kanban',	'/warehouse-layout/location-dashboard',	'',	1,	4,	'2023-05-17 09:05:39',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(138,	'ABC Category',	'Common-ABCCategory',	'menu.main.common.abc-category',	'/common/abc-category',	'',	9,	5,	'2023-05-17 09:06:34',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(139,	'Velocity',	'Common-Velocity',	'menu.main.common.velocity',	'/common/velocity',	'',	9,	6,	'2023-05-17 09:06:34',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(140,	'Carrier',	'transport-carrier',	'menu.main.transport.carrier',	'/transportation/carrier',	'',	19,	3,	'2023-05-17 09:06:35',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(141,	'Easy Post',	'transport-EasyPost',	'menu.main.transport.easy-post',	'/transportation/easy-post',	'',	19,	3,	'2023-05-17 09:06:35',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(142,	'Inventory Mix Restriction',	'Inventory-Mix-Restriction',	'menu.main.inventory.mix-restriction',	'/inventory/mix-restriction',	'',	4,	14,	'2023-05-17 09:05:50',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(143,	'Billable Activity Type',	'Billable-Activity-Type',	'menu.main.billing.billable-activity-type',	'/billing/billable-activity-type',	'',	20,	3,	'2023-05-17 09:06:43',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(144,	'Permission',	'Auth-Permission',	'menu.main.auth.permission',	'/auth/permission',	'',	2,	3,	'2023-05-17 09:05:43',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER',	1,	0),
(145,	'Inventory Aging Snapshot',	'Inventory-Aging-Snapshot',	'menu.main.inventory.inventory-aging-snapshot',	'/inventory/inventory-aging-snapshot',	'',	4,	19,	'2023-05-17 09:05:57',	'CWMS-USER',	'2023-07-21 01:37:53',	'CWMS-USER',	1,	0),
(146,	'Silo',	'Work-Order-Silo',	'menu.main.work-order.silo',	'/work-order/silo',	'',	7,	20,	'2023-05-17 09:06:32',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(147,	'Silo Configuration',	'Work-Order-SiloConfiguration',	'menu.main.work-order.silo-configuration',	'/work-order/silo-configuration',	'',	7,	21,	'2023-05-17 09:06:32',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(148,	'Billable Activity',	'Billing-Billable-Activity',	'menu.main.billing.billable-activity',	'/billing/billable-activity',	'',	20,	4,	'2023-05-17 09:06:43',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(149,	'Barcode Receiving',	'Mobile-Inbound-BarcodeReceiving',	'menu.mobile.inbound.barcode-receiving',	'barcode_receiving',	'menu_inbound_barcode_receiving.png',	13,	2,	'2023-05-17 09:06:44',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(150,	'Pick Configuration',	'Outbound-PickConfiguration',	'menu.main.outbound.pick-configuration',	'/outbound/pick-configuration',	'',	6,	16,	'2023-05-17 09:06:22',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(151,	'Hualei Configuration',	'Outbound-HualeiConfiguration',	'menu.main.outbound.hualei-configuration',	'/outbound/hualei-configuration',	'',	6,	17,	'2023-05-17 09:06:22',	'CWMS-USER',	'2023-07-21 01:37:54',	'CWMS-USER',	1,	0),
(152,	'Work Task Configuration',	'WorkTask-WorkTaskConfiguration',	'menu.main.work-task.work-task-configuration',	'/work-task/work-task-configuration',	'',	10,	2,	'2023-05-17 09:06:43',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(153,	'Operation Type',	'WorkTask-OperationType',	'menu.main.work-task.operation-type',	'/work-task/operation-type',	'',	10,	3,	'2023-05-17 09:06:43',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(154,	'Partial Inventory Move',	'Mobile-Inventory-PartialInventoryMove',	'menu.mobile.inventory.partialInventoryMove',	'partial_inventory_move',	'menu_inventory_putaway.png',	15,	8,	'2023-05-17 09:06:46',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(155,	'Reverse Receiving',	'Mobile-Inbound-ReverseReceiving',	'menu.mobile.inbound.reverse-receiving',	'reverse_receiving',	'menu_reverse.png',	13,	3,	'2023-05-23 10:09:58',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(156,	'Reverse Production',	'Mobile-WorkOrder-ReverseProduction',	'menu.mobile.work-order.reverse-production',	'work_order_reverse_production',	'menu_reverse.png',	16,	8,	'2023-05-23 10:10:05',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(157,	'Batch Pick',	'Mobile-Outbound-PickByNumber',	'menu.mobile.outbound.pick-by-number',	'pick_by_number',	'menu_outbound_pick_by_number.png',	14,	4,	'2023-07-12 22:57:47',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0),
(158,	'Bulk Pick',	'Mobile-Outbound-BulkPick',	'menu.mobile.outbound.bulk-pick',	'pick_by_bulk',	'menu_outbound_bulk_pick.png',	14,	5,	'2023-07-12 22:57:47',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	1,	0);

DROP TABLE IF EXISTS `menu_group`;
CREATE TABLE `menu_group` (
  `menu_group_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `text` varchar(100) NOT NULL,
  `i18n` varchar(100) NOT NULL,
  `group_flag` tinyint(1) NOT NULL DEFAULT '1',
  `hide_in_breadcrumb` tinyint(1) NOT NULL DEFAULT '0',
  `sequence` int NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`menu_group_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `menu_group` (`menu_group_id`, `name`, `type`, `text`, `i18n`, `group_flag`, `hide_in_breadcrumb`, `sequence`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `image`) VALUES
(1,	'User-Menu',	'WEB',	'User Menu',	'menu.user',	1,	1,	1,	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	'Main-Menu',	'WEB',	'Main Menu',	'menu.main',	1,	0,	2,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	'Mobile-Menu',	'MOBILE',	'Mobile Menu',	'menu.mobile',	1,	0,	3,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `menu_sub_group`;
CREATE TABLE `menu_sub_group` (
  `menu_sub_group_id` bigint NOT NULL AUTO_INCREMENT,
  `text` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `i18n` varchar(100) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `shortcut_root` tinyint(1) DEFAULT NULL,
  `menu_group_id` bigint NOT NULL,
  `sequence` int NOT NULL DEFAULT '0',
  `link` varchar(100) DEFAULT NULL,
  `badge` int DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`menu_sub_group_id`),
  UNIQUE KEY `name` (`name`),
  KEY `menu_group_id` (`menu_group_id`),
  CONSTRAINT `menu_sub_group_ibfk_1` FOREIGN KEY (`menu_group_id`) REFERENCES `menu_group` (`menu_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `menu_sub_group` (`menu_sub_group_id`, `text`, `name`, `i18n`, `icon`, `shortcut_root`, `menu_group_id`, `sequence`, `link`, `badge`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	'Dashboard',	'User-Menu-Dashboard',	'menu.dashboard',	'anticon-dashboard',	NULL,	1,	1,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(2,	'Authorization',	'Main-Menu-Auth',	'menu.main.auth',	'anticon-team',	NULL,	2,	1,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	'Layout',	'Main-Menu-Layout',	'menu.main.layout',	'anticon-appstore',	NULL,	2,	2,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	'Inventory',	'Main-Menu-Inventory',	'menu.main.inventory',	'anticon-star',	NULL,	2,	3,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	'Inbound',	'Main-Menu-Inbound',	'menu.main.inbound',	'anticon-exception',	NULL,	2,	5,	'',	NULL,	'2023-05-17 09:05:16',	'CWMS-USER',	'2023-07-21 01:37:51',	'CWMS-USER'),
(6,	'Outbound',	'Main-Menu-Outbound',	'menu.main.outbound',	'anticon-global',	NULL,	2,	6,	'',	NULL,	'2023-05-17 09:05:18',	'CWMS-USER',	'2023-07-21 01:37:51',	'CWMS-USER'),
(7,	'WorkOrder',	'Main-Menu-WorkOrder',	'menu.main.work-order',	'anticon-hdd',	NULL,	2,	7,	'',	NULL,	'2023-05-17 09:05:20',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(8,	'Integration',	'Main-Menu-Integration',	'menu.main.integration',	'anticon-share-alt',	NULL,	2,	8,	'',	NULL,	'2023-05-17 09:05:21',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(9,	'Common',	'Main-Menu-Common',	'menu.main.common',	'anticon-setting',	NULL,	2,	9,	'',	NULL,	'2023-05-17 09:05:21',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(10,	'WorkTask',	'Main-Menu-WorkTask',	'menu.main.work-task',	'anticon-user',	NULL,	2,	11,	'',	NULL,	'2023-05-17 09:05:23',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(11,	'Report',	'Main-Menu-Report',	'menu.main.report',	'anticon-printer',	NULL,	2,	12,	'',	NULL,	'2023-05-17 09:05:24',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(12,	'Util',	'Main-Menu-Util',	'menu.main.util',	'anticon-tool',	NULL,	2,	13,	'',	NULL,	'2023-05-17 09:05:25',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(13,	'Inbound',	'Mobile-Menu-Inbound',	'menu.mobile.inbound',	'menu_subgroup_inbound.png',	NULL,	3,	1,	'',	NULL,	'2023-05-17 09:05:28',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(14,	'Outbound',	'Mobile-Menu-Outbound',	'menu.mobile.outbound',	'menu_subgroup_outbound.png',	NULL,	3,	2,	'',	NULL,	'2023-05-17 09:05:28',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(15,	'Inventory',	'Mobile-Menu-Inventory',	'menu.mobile.inventory',	'menu_subgroup_inventory.png',	NULL,	3,	3,	'',	NULL,	'2023-05-17 09:05:29',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(16,	'WorkOrder',	'Mobile-Menu-WorkOrder',	'menu.mobile.work-order',	'menu_subgroup_workorder.png',	NULL,	3,	4,	'',	NULL,	'2023-05-17 09:05:31',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(17,	'QC',	'Main-Menu-QC',	'menu.main.qc',	'anticon-star',	NULL,	2,	4,	'',	NULL,	'2023-05-17 09:05:14',	'CWMS-USER',	'2023-07-21 01:37:51',	'CWMS-USER'),
(18,	'Alert',	'Main-Menu-Alert',	'menu.main.alert',	'anticon-message',	NULL,	2,	14,	'',	NULL,	'2023-05-17 09:05:26',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(19,	'Transportation',	'Main-Menu-Transport',	'menu.main.transport',	'anticon-global',	NULL,	2,	10,	'',	NULL,	'2023-05-17 09:05:22',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(20,	'Billing',	'Main-Menu-Billing',	'menu.main.billing',	'anticon-shopping-cart',	NULL,	2,	15,	'',	NULL,	'2023-05-17 09:05:27',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER'),
(21,	'SystemDrivenWork',	'Mobile-Menu-SystemDrivenWork',	'menu.mobile.system-driven-work',	'menu_subgroup_systemdrivenwork.png',	NULL,	3,	5,	'system_driven_work',	NULL,	'2023-05-17 09:05:31',	'CWMS-USER',	'2023-07-21 01:37:52',	'CWMS-USER');

DROP TABLE IF EXISTS `mould`;
CREATE TABLE `mould` (
  `mould_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`mould_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `movement_path`;
CREATE TABLE `movement_path` (
  `movement_path_id` bigint NOT NULL AUTO_INCREMENT,
  `from_location_id` bigint DEFAULT NULL,
  `from_location_group_id` bigint DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `to_location_id` bigint DEFAULT NULL,
  `to_location_group_id` bigint DEFAULT NULL,
  `sequence` int NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`movement_path_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `movement_path_detail`;
CREATE TABLE `movement_path_detail` (
  `movement_path_detail_id` bigint NOT NULL AUTO_INCREMENT,
  `movement_path_id` bigint NOT NULL,
  `hop_location_id` bigint DEFAULT NULL,
  `hop_location_group_id` bigint DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `sequence` int NOT NULL,
  `strategy` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`movement_path_detail_id`),
  KEY `movement_path_id` (`movement_path_id`),
  CONSTRAINT `movement_path_detail_ibfk_1` FOREIGN KEY (`movement_path_id`) REFERENCES `movement_path` (`movement_path_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `mrp_production_line`;
CREATE TABLE `mrp_production_line` (
  `material_requirements_planning_id` bigint NOT NULL,
  `production_line_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  KEY `material_requirements_planning_id` (`material_requirements_planning_id`),
  KEY `production_line_id` (`production_line_id`),
  CONSTRAINT `mrp_production_line_ibfk_1` FOREIGN KEY (`material_requirements_planning_id`) REFERENCES `material_requirements_planning` (`material_requirements_planning_id`),
  CONSTRAINT `mrp_production_line_ibfk_2` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `operation_type`;
CREATE TABLE `operation_type` (
  `operation_type_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `default_priority` int DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`operation_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `order_activity`;
CREATE TABLE `order_activity` (
  `order_activity_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(20) NOT NULL,
  `transaction_group_id` varchar(20) NOT NULL,
  `activity_datetime` datetime NOT NULL,
  `username` varchar(50) NOT NULL,
  `rf_code` varchar(50) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `outbound_order_id` bigint DEFAULT NULL,
  `outbound_order_line_id` bigint DEFAULT NULL,
  `pick_id` bigint DEFAULT NULL,
  `short_allocation_id` bigint DEFAULT NULL,
  `shipment_id` bigint DEFAULT NULL,
  `shipment_line_id` bigint DEFAULT NULL,
  `quantity` bigint DEFAULT NULL,
  `outbound_order_number` varchar(50) DEFAULT NULL,
  `outbound_order_line_number` varchar(50) DEFAULT NULL,
  `old_order_line_expected_quantity` bigint DEFAULT NULL,
  `new_order_line_expected_quantity` bigint DEFAULT NULL,
  `old_order_line_open_quantity` bigint DEFAULT NULL,
  `new_order_line_open_quantity` bigint DEFAULT NULL,
  `old_order_line_inprocess_quantity` bigint DEFAULT NULL,
  `new_order_line_inprocess_quantity` bigint DEFAULT NULL,
  `old_order_line_shipped_quantity` bigint DEFAULT NULL,
  `new_order_line_shipped_quantity` bigint DEFAULT NULL,
  `shipment_number` varchar(50) DEFAULT NULL,
  `shipment_line_number` varchar(50) DEFAULT NULL,
  `old_shipment_line_quantity` bigint DEFAULT NULL,
  `new_shipment_line_quantity` bigint DEFAULT NULL,
  `old_shipment_line_open_quantity` bigint DEFAULT NULL,
  `new_shipment_line_open_quantity` bigint DEFAULT NULL,
  `old_shipment_line_inprocess_quantity` bigint DEFAULT NULL,
  `new_shipment_line_inprocess_quantity` bigint DEFAULT NULL,
  `old_shipment_line_loaded_quantity` bigint DEFAULT NULL,
  `new_shipment_line_loaded_quantity` bigint DEFAULT NULL,
  `old_shipment_line_shipped_quantity` bigint DEFAULT NULL,
  `new_shipment_line_shipped_quantity` bigint DEFAULT NULL,
  `pick_number` varchar(50) DEFAULT NULL,
  `old_pick_quantity` bigint DEFAULT NULL,
  `new_pick_quantity` bigint DEFAULT NULL,
  `old_pick_picked_quantity` bigint DEFAULT NULL,
  `new_pick_picked_quantity` bigint DEFAULT NULL,
  `old_short_allocation_quantity` bigint DEFAULT NULL,
  `new_short_allocation_quantity` bigint DEFAULT NULL,
  `old_short_allocation_open_quantity` bigint DEFAULT NULL,
  `new_short_allocation_open_quantity` bigint DEFAULT NULL,
  `old_short_allocation_inprocess_quantity` bigint DEFAULT NULL,
  `new_short_allocation_inprocess_quantity` bigint DEFAULT NULL,
  `old_short_allocation_delivered_quantity` bigint DEFAULT NULL,
  `new_short_allocation_delivered_quantity` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `bulk_pick_number` varchar(50) DEFAULT NULL,
  `bulk_pick_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  PRIMARY KEY (`order_activity_id`),
  KEY `outbound_order_id` (`outbound_order_id`),
  KEY `outbound_order_line_id` (`outbound_order_line_id`),
  KEY `pick_id` (`pick_id`),
  KEY `short_allocation_id` (`short_allocation_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `shipment_line_id` (`shipment_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `order_cancellation_request`;
CREATE TABLE `order_cancellation_request` (
  `order_cancellation_request_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `outbound_order_id` bigint NOT NULL,
  `cancel_requested_time` datetime DEFAULT NULL,
  `cancel_requested_username` varchar(100) DEFAULT NULL,
  `request_result` varchar(25) DEFAULT NULL,
  `message` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_cancellation_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `outbound_order`;
CREATE TABLE `outbound_order` (
  `outbound_order_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `ship_to_customer_id` bigint DEFAULT NULL,
  `bill_to_customer_id` bigint DEFAULT NULL,
  `ship_to_contactor_firstname` varchar(100) DEFAULT NULL,
  `ship_to_contactor_lastname` varchar(100) DEFAULT NULL,
  `ship_to_address_country` varchar(100) DEFAULT NULL,
  `ship_to_address_state` varchar(100) DEFAULT NULL,
  `ship_to_address_county` varchar(100) DEFAULT NULL,
  `ship_to_address_city` varchar(100) DEFAULT NULL,
  `ship_to_address_district` varchar(100) DEFAULT NULL,
  `ship_to_address_line1` varchar(100) DEFAULT NULL,
  `ship_to_address_line2` varchar(100) DEFAULT NULL,
  `ship_to_address_postcode` varchar(25) DEFAULT NULL,
  `bill_to_contactor_firstname` varchar(100) DEFAULT NULL,
  `bill_to_contactor_lastname` varchar(100) DEFAULT NULL,
  `bill_to_address_country` varchar(100) DEFAULT NULL,
  `bill_to_address_state` varchar(100) DEFAULT NULL,
  `bill_to_address_county` varchar(100) DEFAULT NULL,
  `bill_to_address_city` varchar(100) DEFAULT NULL,
  `bill_to_address_district` varchar(100) DEFAULT NULL,
  `bill_to_address_line1` varchar(100) DEFAULT NULL,
  `bill_to_address_line2` varchar(100) DEFAULT NULL,
  `bill_to_address_postcode` varchar(25) DEFAULT NULL,
  `stage_location_group_id` bigint DEFAULT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `category` varchar(50) NOT NULL DEFAULT 'SALES_ORDER',
  `transfer_receipt_number` varchar(50) DEFAULT NULL,
  `transfer_receipt_warehouse_id` bigint DEFAULT NULL,
  `stage_location_id` bigint DEFAULT NULL,
  `complete_time` datetime DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `quickbook_txnid` varchar(50) DEFAULT NULL,
  `quickbook_customer_list_id` varchar(50) DEFAULT NULL,
  `ship_to_address_line3` varchar(100) DEFAULT NULL,
  `bill_to_address_line3` varchar(100) DEFAULT NULL,
  `ship_to_contactor_phone_number` varchar(50) DEFAULT NULL,
  `cancel_requested` tinyint(1) DEFAULT NULL,
  `cancel_requested_time` datetime DEFAULT NULL,
  `cancel_requested_username` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`outbound_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `outbound_order_billable_activity`;
CREATE TABLE `outbound_order_billable_activity` (
  `outbound_order_billable_activity_id` bigint NOT NULL AUTO_INCREMENT,
  `billable_activity_type_id` bigint NOT NULL,
  `activity_time` datetime NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `outbound_order_id` bigint NOT NULL,
  `rate` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `total_charge` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`outbound_order_billable_activity_id`),
  KEY `outbound_order_id` (`outbound_order_id`),
  CONSTRAINT `outbound_order_billable_activity_ibfk_1` FOREIGN KEY (`outbound_order_id`) REFERENCES `outbound_order` (`outbound_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `outbound_order_document`;
CREATE TABLE `outbound_order_document` (
  `outbound_order_document_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `uploaded_username` varchar(100) NOT NULL,
  `file_name` varchar(200) NOT NULL,
  `outbound_order_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`outbound_order_document_id`),
  KEY `outbound_order_id` (`outbound_order_id`),
  CONSTRAINT `outbound_order_document_ibfk_1` FOREIGN KEY (`outbound_order_id`) REFERENCES `outbound_order` (`outbound_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `outbound_order_line`;
CREATE TABLE `outbound_order_line` (
  `outbound_order_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `expected_quantity` bigint NOT NULL,
  `open_quantity` bigint NOT NULL,
  `inprocess_quantity` bigint NOT NULL,
  `production_plan_inprocess_quantity` bigint NOT NULL,
  `production_plan_produced_quantity` bigint NOT NULL,
  `shipped_quantity` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `outbound_order_id` bigint NOT NULL,
  `allocation_strategy_type` varchar(25) DEFAULT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `requested_return_quantity` bigint DEFAULT NULL,
  `actual_return_quantity` bigint DEFAULT NULL,
  `quickbook_txnlineid` varchar(50) DEFAULT NULL,
  `non_allocatable` tinyint(1) DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `product_size` varchar(100) DEFAULT NULL,
  `style` varchar(100) DEFAULT NULL,
  `hualei_product_id` varchar(100) DEFAULT NULL,
  `auto_request_shipping_label` tinyint(1) NOT NULL DEFAULT '0',
  `allocate_by_receipt_number` varchar(100) DEFAULT NULL,
  `parcel_insured` tinyint(1) DEFAULT NULL,
  `parcel_insured_amount_per_unit` double DEFAULT NULL,
  `parcel_signature_required` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`outbound_order_line_id`),
  KEY `outbound_order_id` (`outbound_order_id`),
  CONSTRAINT `outbound_order_line_ibfk_1` FOREIGN KEY (`outbound_order_id`) REFERENCES `outbound_order` (`outbound_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `outbound_order_line_billable_activity`;
CREATE TABLE `outbound_order_line_billable_activity` (
  `outbound_order_line_billable_activity_id` bigint NOT NULL AUTO_INCREMENT,
  `billable_activity_type_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `activity_time` datetime NOT NULL,
  `outbound_order_line_id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `total_charge` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`outbound_order_line_billable_activity_id`),
  KEY `outbound_order_line_id` (`outbound_order_line_id`),
  CONSTRAINT `outbound_order_line_billable_activity_ibfk_1` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `outbound_order_line` (`outbound_order_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `parcel_package`;
CREATE TABLE `parcel_package` (
  `parcel_package_id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `tracking_code` varchar(100) DEFAULT NULL,
  `tracking_url` varchar(250) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `shipment_id` varchar(100) DEFAULT NULL,
  `length` double DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `carrier` varchar(50) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `delivery_days` int DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `label_resolution` varchar(100) DEFAULT NULL,
  `label_size` varchar(25) DEFAULT NULL,
  `label_url` varchar(250) DEFAULT NULL,
  `insurance` varchar(25) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `status_description` varchar(500) DEFAULT NULL,
  `request_system` varchar(30) DEFAULT NULL,
  `hualei_order_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`parcel_package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `permission_id` bigint NOT NULL AUTO_INCREMENT,
  `menu_id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`permission_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `permission_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `permission` (`permission_id`, `menu_id`, `name`, `description`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	25,	'add-order',	'Add Order',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(2,	25,	'file-upload',	'Upload Order File',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(3,	25,	'modify-order',	'Modify Order',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(4,	25,	'allocate-order',	'Allocate Order',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(5,	25,	'reassign-stage-location',	'Reassign Stage Location',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(6,	25,	'complete-order',	'Complete Order',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(7,	25,	'remove-order',	'Remove Order',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(8,	25,	'retrigger-order-confirm-integration',	'Retrigger Order Confirmation Integration',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(9,	25,	'upload-document',	'Upload Order Document',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(10,	25,	'ship-parcel',	'Shipping Parcel Package',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(11,	25,	'add-order-billable-activity-type',	'Add Order Billable Activity',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(12,	25,	'add-order-line-billable-activity-type',	'Add Order Line Billable Activity',	'2023-05-17 09:06:51',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(13,	25,	'cancel-single-pick',	'Cancel Single Pick',	'2023-05-17 09:06:51',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(14,	25,	'cancel-multiple-pick',	'Cancel Multiple Pick',	'2023-05-17 09:06:51',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(15,	25,	'confirm-multiple-pick',	'Confirm Pick',	'2023-05-17 09:06:51',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(16,	25,	'unpick',	'Unpick',	'2023-05-17 09:06:51',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(17,	25,	'allocate-short-allocation',	'Allocate Short Allocation',	'2023-05-17 09:06:51',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(18,	25,	'create-work-order',	'Create Work Order',	'2023-05-17 09:06:51',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(19,	25,	'cancel-short-allocation',	'Cancel Short Allocation',	'2023-05-17 09:06:51',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(20,	25,	'remove-order-billable-activity-type',	'Remove Order Billable Activity Type',	'2023-05-17 09:06:51',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(21,	25,	'remove-order-document',	'Remove Order Document',	'2023-05-17 09:06:52',	'CWMS-USER',	'2023-05-23 10:10:22',	'CWMS-USER'),
(22,	25,	'remove-order-line-billable-activity-type',	'Remove Order Line Billable Activity Type',	'2023-05-17 09:06:52',	'CWMS-USER',	'2023-05-23 10:10:22',	'CWMS-USER'),
(23,	50,	'items',	'Item',	'2023-05-17 09:06:52',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(24,	50,	'BOMs',	'BOM',	'2023-05-17 09:06:52',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(25,	50,	'inventory',	'Inventory',	'2023-05-17 09:06:52',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(26,	50,	'itemUnitOfMeasure',	'Item Unit of Measure',	'2023-05-17 09:06:52',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(27,	50,	'locations',	'Warehouse Locations',	'2023-05-17 09:06:53',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(28,	50,	'orders',	'Order',	'2023-05-17 09:06:53',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(29,	50,	'putaway-inventories',	'Putaway Inventory',	'2023-05-17 09:06:53',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(30,	50,	'receipts',	'Receipt',	'2023-05-17 09:06:53',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(31,	50,	'receiving-inventories',	'Receiving Inventory',	'2023-05-17 09:06:54',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(32,	50,	'shipping-trailer-appointment',	'Shipping Trailer Appointment',	'2023-05-17 09:06:54',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(33,	23,	'modify-receipt',	'Modify Receipt',	'2023-05-17 09:06:54',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(34,	23,	'check-in-receipt',	'Check In Receipt',	'2023-05-17 09:06:54',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(35,	23,	'complete-receipt',	'Complete Receipt',	'2023-05-17 09:06:54',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(36,	23,	'add-receipt-billable-activity',	'Add Receipt Billable Activity',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(37,	23,	'remove-receipt-billable-activity',	'Remove Receipt Billable Activity',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(38,	23,	'add-receipt-line-billable-activity',	'Add Receipt Line Billable Activity',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(39,	23,	'remove-receipt-line-billable-activity',	'Remove Receipt Line Billable Activity',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(40,	23,	'remove-multiple-receipt',	'Remove Multiple Receipt',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(41,	23,	'add-receipt',	'Add Receipt',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(42,	23,	'upload-receipt',	'Upload Receipt',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(43,	23,	'upload-receiving-inventory',	'Upload Receiving Inventory',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(44,	23,	'upload-putaway-inventory',	'Upload Put Away Inventory',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(45,	11,	'adjust-inventory-quantity',	'Adjust Inventory Quantity',	'2023-05-17 09:06:55',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(46,	11,	'change-inventory-attribute',	'Change Inventory Attribute',	'2023-05-17 09:06:56',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(47,	11,	'move-inventory',	'Move Inventory',	'2023-05-17 09:06:56',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(48,	11,	'remove-inventory',	'Remove Inventory',	'2023-05-17 09:06:56',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(49,	11,	'remove-inventory-in-batch',	'Remove Inventory In Batch',	'2023-05-17 09:06:56',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(50,	11,	'move-inventory-in-batch',	'Move Inventory In Batch',	'2023-05-17 09:06:56',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(51,	11,	'upload-inventory',	'Upload Inventory',	'2023-05-17 09:06:56',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(52,	13,	'add-inventory',	'Add Inventory',	'2023-05-17 09:06:56',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(53,	13,	'empty-location',	'Empty Location',	'2023-05-17 09:06:56',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(54,	13,	'adjust-inventory-quantity',	'Adjust Inventory Quantity',	'2023-05-17 09:06:56',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(55,	13,	'change-inventory-attribute',	'Change Inventory Attribute',	'2023-05-17 09:06:57',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(56,	13,	'remove-inventory',	'Remove Inventory',	'2023-05-17 09:06:57',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(57,	10,	'modify-item',	'Modify Item',	'2023-05-17 09:06:57',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(58,	10,	'remove-item',	'Remove Item',	'2023-05-17 09:06:57',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(59,	10,	'upload-item',	'Upload Item',	'2023-05-17 09:06:57',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(60,	10,	'upload-item-unit-of-measure',	'Upload Item Unit Of Measure',	'2023-05-17 09:06:57',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(61,	10,	'add-item',	'Add Item',	'2023-05-17 09:06:57',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(62,	25,	'ship-by-hualei',	'Shipping By Hualei',	'2023-05-17 09:06:50',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(63,	50,	'parcel-packages',	'Parcel Package',	'2023-05-17 09:06:53',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(64,	55,	'assign-user',	'Assign User',	'2023-05-17 09:06:58',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(65,	55,	'assign-role',	'Assign Role',	'2023-05-17 09:06:58',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(66,	55,	'assign-working-team',	'Assign Working Team',	'2023-05-17 09:06:58',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(67,	25,	'cancel-order',	'Cancel Order',	'2023-05-26 09:48:44',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(68,	25,	'clear-cancellation-request',	'Clear Order Cancellation Request',	'2023-05-26 09:48:44',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(69,	11,	'reverse-inventory',	'Reverse Inventory',	'2023-05-26 09:48:52',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(70,	50,	'loads',	'Loads',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(71,	123,	'file-upload',	'Upload Load File',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(72,	123,	'allocate-load',	'Allocate Load',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(73,	123,	'complete-load',	'Complete Load',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(74,	123,	'cancel-single-pick',	'Cancel Single Pick',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(75,	123,	'cancel-multiple-pick',	'Cancel Multiple Pick',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(76,	123,	'confirm-multiple-pick',	'Confirm Pick',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(77,	123,	'allocate-short-allocation',	'Allocate Short Allocation',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(78,	123,	'create-work-order',	'Create Work Order',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(79,	123,	'cancel-short-allocation',	'Cancel Short Allocation',	'2023-07-12 22:57:49',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(80,	50,	'walmart-shipping-carton-labels',	'Walmart Shipping Carton Labels',	'2023-07-13 00:40:35',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(81,	25,	'walmart-shipping-carton-label',	'Walmart Shipping Carton Label',	'2023-07-14 00:09:12',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER'),
(82,	27,	'file-upload',	'Upload Load File',	'2023-07-21 00:52:15',	'CWMS-USER',	NULL,	'CWMS-USER'),
(83,	27,	'allocate-load',	'Allocate Load',	'2023-07-21 00:52:15',	'CWMS-USER',	NULL,	'CWMS-USER'),
(84,	27,	'complete-load',	'Complete Load',	'2023-07-21 00:52:15',	'CWMS-USER',	NULL,	'CWMS-USER'),
(85,	27,	'cancel-single-pick',	'Cancel Single Pick',	'2023-07-21 00:52:15',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(86,	27,	'cancel-multiple-pick',	'Cancel Multiple Pick',	'2023-07-21 00:52:15',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(87,	27,	'confirm-multiple-pick',	'Confirm Pick',	'2023-07-21 00:52:15',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(88,	27,	'allocate-short-allocation',	'Allocate Short Allocation',	'2023-07-21 00:52:15',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(89,	27,	'create-work-order',	'Create Work Order',	'2023-07-21 00:52:15',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(90,	27,	'cancel-short-allocation',	'Cancel Short Allocation',	'2023-07-21 00:52:15',	'CWMS-USER',	'2023-07-21 01:37:57',	'CWMS-USER'),
(91,	27,	'allocate-wave',	'Allocate Wave',	'2023-07-21 01:37:57',	'CWMS-USER',	NULL,	'CWMS-USER'),
(92,	27,	'cancel-wave',	'Cancel Wave',	'2023-07-21 01:37:57',	'CWMS-USER',	NULL,	'CWMS-USER');

DROP TABLE IF EXISTS `pick`;
CREATE TABLE `pick` (
  `pick_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(100) NOT NULL,
  `source_location_id` bigint NOT NULL,
  `destination_location_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `status` varchar(20) NOT NULL,
  `lpn` varchar(100) DEFAULT NULL,
  `type` varchar(30) NOT NULL,
  `shipment_line_id` bigint DEFAULT NULL,
  `work_order_line_id` bigint DEFAULT NULL,
  `short_allocation_id` bigint DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `picked_quantity` bigint NOT NULL,
  `pick_list_id` bigint DEFAULT NULL,
  `inventory_status_id` bigint NOT NULL,
  `cartonization_id` bigint DEFAULT NULL,
  `unit_of_measure_id` bigint DEFAULT NULL,
  `confirm_item_flag` tinyint(1) NOT NULL DEFAULT '1',
  `confirm_location_flag` tinyint(1) NOT NULL DEFAULT '1',
  `confirm_location_code_flag` tinyint(1) NOT NULL DEFAULT '1',
  `work_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `confirm_lpn_flag` tinyint(1) NOT NULL DEFAULT '0',
  `color` varchar(100) DEFAULT NULL,
  `product_size` varchar(100) DEFAULT NULL,
  `style` varchar(100) DEFAULT NULL,
  `bulk_pick_id` bigint DEFAULT NULL,
  `work_task_id` bigint DEFAULT NULL,
  `allocate_by_receipt_number` varchar(100) DEFAULT NULL,
  `whole_lpn_pick` tinyint(1) DEFAULT NULL,
  `acknowledged_username` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`pick_id`),
  KEY `shipment_line_id` (`shipment_line_id`),
  KEY `pick_list_id` (`pick_list_id`),
  KEY `short_allocation_id` (`short_allocation_id`),
  KEY `cartonization_id` (`cartonization_id`),
  CONSTRAINT `pick_ibfk_1` FOREIGN KEY (`shipment_line_id`) REFERENCES `shipment_line` (`shipment_line_id`),
  CONSTRAINT `pick_ibfk_2` FOREIGN KEY (`pick_list_id`) REFERENCES `pick_list` (`pick_list_id`),
  CONSTRAINT `pick_ibfk_3` FOREIGN KEY (`short_allocation_id`) REFERENCES `short_allocation` (`short_allocation_id`),
  CONSTRAINT `pick_ibfk_4` FOREIGN KEY (`cartonization_id`) REFERENCES `cartonization` (`cartonization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `pick_configuration`;
CREATE TABLE `pick_configuration` (
  `pick_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `release_to_work_task` tinyint(1) NOT NULL,
  `work_task_priority` int DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `release_pick_list_to_work_task` tinyint(1) DEFAULT NULL,
  `pick_list_work_task_priority` int DEFAULT NULL,
  PRIMARY KEY (`pick_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `pick_confirm_strategy`;
CREATE TABLE `pick_confirm_strategy` (
  `pick_confirm_strategy_id` bigint NOT NULL AUTO_INCREMENT,
  `sequence` int NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `location_group_id` bigint DEFAULT NULL,
  `location_group_type_id` bigint DEFAULT NULL,
  `unit_of_measure_id` bigint DEFAULT NULL,
  `confirm_item_flag` tinyint(1) NOT NULL DEFAULT '0',
  `confirm_location_flag` tinyint(1) NOT NULL DEFAULT '0',
  `confirm_location_code_flag` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `confirm_lpn_flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pick_confirm_strategy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `pick_list`;
CREATE TABLE `pick_list` (
  `pick_list_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(20) NOT NULL,
  `group_key` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `work_task_id` bigint DEFAULT NULL,
  `acknowledged_username` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`pick_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `pick_movement`;
CREATE TABLE `pick_movement` (
  `pick_movement_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `pick_id` bigint NOT NULL,
  `location_id` bigint NOT NULL,
  `sequence` int NOT NULL,
  `arrived_quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pick_movement_id`),
  KEY `pick_id` (`pick_id`),
  CONSTRAINT `pick_movement_ibfk_1` FOREIGN KEY (`pick_id`) REFERENCES `pick` (`pick_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `pickable_unit_of_measure`;
CREATE TABLE `pickable_unit_of_measure` (
  `pickable_unit_of_measure_id` bigint NOT NULL AUTO_INCREMENT,
  `unit_of_measure_id` bigint NOT NULL,
  `location_group_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pickable_unit_of_measure_id`),
  KEY `location_group_id` (`location_group_id`),
  CONSTRAINT `pickable_unit_of_measure_ibfk_1` FOREIGN KEY (`location_group_id`) REFERENCES `location_group` (`location_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `policy`;
CREATE TABLE `policy` (
  `policy_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `policy_key` varchar(100) NOT NULL,
  `policy_value` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `policy` (`policy_id`, `warehouse_id`, `policy_key`, `policy_value`, `description`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	1,	'LOCATION-DEFAULT-REMOVED-INVENTORY-LOCATION',	'REMOVE_INV',	'Location to Save Removed Inventory',	NULL,	NULL,	NULL,	NULL),
(2,	1,	'LOCATION-AUDIT-COUNT',	'AUDIT',	'Location to Save Removed Inventory by Audit Count',	NULL,	NULL,	NULL,	NULL),
(3,	1,	'LOCATION-COUNT',	'COUNT',	'Location to Save Removed Inventory by Count',	NULL,	NULL,	NULL,	NULL),
(4,	1,	'LOCATION-INVENTORY-ADJUST',	'INVADJ',	'Location to Save Removed Inventory by Inventory Adjustment',	NULL,	NULL,	NULL,	NULL),
(5,	1,	'LOCATION-RECEIVING',	'INVRCV',	'Location to Save Removed Inventory by Inventory Receiving',	NULL,	NULL,	NULL,	NULL),
(6,	1,	'LOCATION-GROUP-RECEIPT',	'RECEIPT',	'Location Group for Receipt',	NULL,	NULL,	NULL,	NULL),
(7,	1,	'JOB-EMERGENCY-REPLENISHMENT-MAX-COUNT',	'50',	'Max emergency replenishment can be processed in one round',	NULL,	NULL,	NULL,	NULL),
(15,	3,	'LOCATION-DEFAULT-REMOVED-INVENTORY-LOCATION',	'REMOVE_INV',	'Location to Save Removed Inventory',	'2022-01-26 12:11:44',	NULL,	'2022-01-26 12:11:44',	NULL),
(16,	3,	'LOCATION-AUDIT-COUNT',	'AUDIT',	'Location to Save Removed Inventory by Audit Count',	'2022-01-26 12:11:45',	NULL,	'2022-01-26 12:11:45',	NULL),
(17,	3,	'LOCATION-COUNT',	'COUNT',	'Location to Save Removed Inventory by Count',	'2022-01-26 12:11:45',	NULL,	'2022-01-26 12:11:45',	NULL),
(18,	3,	'LOCATION-INVENTORY-ADJUST',	'INVADJ',	'Location to Save Removed Inventory by Inventory Adjustment',	'2022-01-26 12:11:45',	NULL,	'2022-01-26 12:11:45',	NULL),
(19,	3,	'LOCATION-RECEIVING',	'INVRCV',	'Location to Save Removed Inventory by Inventory Receiving',	'2022-01-26 12:11:45',	NULL,	'2022-01-26 12:11:45',	NULL),
(20,	3,	'LOCATION-GROUP-RECEIPT',	'RECEIPT',	'Location Group for Receipt',	'2022-01-26 12:11:45',	NULL,	'2022-01-26 12:11:45',	NULL),
(21,	3,	'JOB-EMERGENCY-REPLENISHMENT-MAX-COUNT',	'50',	'Max emergency replenishment can be processed in one round',	'2022-01-26 12:11:46',	NULL,	'2022-01-26 12:11:46',	NULL);

DROP TABLE IF EXISTS `printer`;
CREATE TABLE `printer` (
  `printer_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `printer_type_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`printer_id`),
  KEY `printer_type_id` (`printer_type_id`),
  CONSTRAINT `printer_ibfk_1` FOREIGN KEY (`printer_type_id`) REFERENCES `printer_type` (`printer_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `printer_type`;
CREATE TABLE `printer_type` (
  `printer_type_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`printer_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `printing_request`;
CREATE TABLE `printing_request` (
  `printing_request_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `report_history_id` bigint DEFAULT NULL,
  `printer_name` varchar(200) NOT NULL,
  `copies` int DEFAULT NULL,
  `printing_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `report_url` varchar(1000) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `result` varchar(20) DEFAULT NULL,
  `error_message` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`printing_request_id`),
  KEY `report_history_id` (`report_history_id`),
  CONSTRAINT `printing_request_ibfk_1` FOREIGN KEY (`report_history_id`) REFERENCES `report_history` (`report_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_line`;
CREATE TABLE `production_line` (
  `production_line_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `inbound_stage_location_id` bigint NOT NULL,
  `outbound_stage_location_id` bigint NOT NULL,
  `production_line_location_id` bigint NOT NULL,
  `work_order_exclusive_flag` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `generic_purpose` tinyint(1) NOT NULL,
  `model` varchar(200) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `report_printer_name` varchar(150) DEFAULT NULL,
  `label_printer_name` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_line_activity`;
CREATE TABLE `production_line_activity` (
  `production_line_activity_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL,
  `production_line_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `username` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `working_team_member_count` int DEFAULT NULL,
  `transaction_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`production_line_activity_id`),
  KEY `work_order_id` (`work_order_id`),
  KEY `production_line_id` (`production_line_id`),
  CONSTRAINT `production_line_activity_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`),
  CONSTRAINT `production_line_activity_ibfk_2` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_line_assignment`;
CREATE TABLE `production_line_assignment` (
  `production_line_assignment_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL,
  `production_line_id` bigint NOT NULL,
  `mould_id` bigint DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `estimated_reserved_timespan` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `open_quantity` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`production_line_assignment_id`),
  KEY `work_order_id` (`work_order_id`),
  KEY `production_line_id` (`production_line_id`),
  KEY `mould_id` (`mould_id`),
  CONSTRAINT `production_line_assignment_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`),
  CONSTRAINT `production_line_assignment_ibfk_2` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`),
  CONSTRAINT `production_line_assignment_ibfk_3` FOREIGN KEY (`mould_id`) REFERENCES `mould` (`mould_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_line_assignment_line`;
CREATE TABLE `production_line_assignment_line` (
  `production_line_assignment_line_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_line_id` bigint NOT NULL,
  `production_line_assignment_id` bigint NOT NULL,
  `quantity` bigint NOT NULL,
  `open_quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`production_line_assignment_line_id`),
  KEY `work_order_line_id` (`work_order_line_id`),
  KEY `production_line_assignment_id` (`production_line_assignment_id`),
  CONSTRAINT `production_line_assignment_line_ibfk_1` FOREIGN KEY (`work_order_line_id`) REFERENCES `work_order_line` (`work_order_line_id`),
  CONSTRAINT `production_line_assignment_line_ibfk_2` FOREIGN KEY (`production_line_assignment_id`) REFERENCES `production_line_assignment` (`production_line_assignment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_line_capacity`;
CREATE TABLE `production_line_capacity` (
  `production_line_capacity_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `production_line_id` bigint NOT NULL,
  `mould_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `capacity` bigint NOT NULL,
  `unit_of_measure_id` bigint NOT NULL,
  `capacity_unit` varchar(20) NOT NULL,
  `staff_count` double DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`production_line_capacity_id`),
  KEY `production_line_id` (`production_line_id`),
  KEY `mould_id` (`mould_id`),
  CONSTRAINT `production_line_capacity_ibfk_1` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`),
  CONSTRAINT `production_line_capacity_ibfk_2` FOREIGN KEY (`mould_id`) REFERENCES `mould` (`mould_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_line_delivery`;
CREATE TABLE `production_line_delivery` (
  `production_line_delivery_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_line_id` bigint NOT NULL,
  `production_line_id` bigint NOT NULL,
  `delivered_quantity` bigint NOT NULL,
  `consumed_quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`production_line_delivery_id`),
  KEY `work_order_line_id` (`work_order_line_id`),
  KEY `production_line_id` (`production_line_id`),
  CONSTRAINT `production_line_delivery_ibfk_1` FOREIGN KEY (`work_order_line_id`) REFERENCES `work_order_line` (`work_order_line_id`),
  CONSTRAINT `production_line_delivery_ibfk_2` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_line_monitor`;
CREATE TABLE `production_line_monitor` (
  `production_line_monitor_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `production_line_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`production_line_monitor_id`),
  KEY `production_line_id` (`production_line_id`),
  CONSTRAINT `production_line_monitor_ibfk_1` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_line_monitor_transaction`;
CREATE TABLE `production_line_monitor_transaction` (
  `production_line_monitor_transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `production_line_monitor_id` bigint NOT NULL,
  `production_line_id` bigint DEFAULT NULL,
  `cycle_time` double DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`production_line_monitor_transaction_id`),
  KEY `production_line_monitor_id` (`production_line_monitor_id`),
  KEY `production_line_id` (`production_line_id`),
  CONSTRAINT `production_line_monitor_transaction_ibfk_1` FOREIGN KEY (`production_line_monitor_id`) REFERENCES `production_line_monitor` (`production_line_monitor_id`),
  CONSTRAINT `production_line_monitor_transaction_ibfk_2` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_plan`;
CREATE TABLE `production_plan` (
  `production_plan_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(20) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`production_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_plan_line`;
CREATE TABLE `production_plan_line` (
  `production_plan_line_id` bigint NOT NULL AUTO_INCREMENT,
  `production_plan_id` bigint NOT NULL,
  `order_line_id` bigint DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `bill_of_material_id` bigint NOT NULL,
  `expected_quantity` bigint NOT NULL,
  `inprocess_quantity` bigint NOT NULL,
  `produced_quantity` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`production_plan_line_id`),
  KEY `bill_of_material_id` (`bill_of_material_id`),
  KEY `production_plan_id` (`production_plan_id`),
  CONSTRAINT `production_plan_line_ibfk_1` FOREIGN KEY (`bill_of_material_id`) REFERENCES `bill_of_material` (`bill_of_material_id`),
  CONSTRAINT `production_plan_line_ibfk_2` FOREIGN KEY (`production_plan_id`) REFERENCES `production_plan` (`production_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `production_shift_schedule`;
CREATE TABLE `production_shift_schedule` (
  `production_shift_schedule_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `shift_start_time` time NOT NULL,
  `shift_end_time` time NOT NULL,
  `shift_end_next_day` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`production_shift_schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `purchase_order`;
CREATE TABLE `purchase_order` (
  `purchase_order_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `quickbook_txnid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`purchase_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `purchase_order_line`;
CREATE TABLE `purchase_order_line` (
  `purchase_order_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `received_quantity` bigint NOT NULL,
  `purchase_order_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `receipt_quantity` bigint NOT NULL,
  `quickbook_txnlineid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`purchase_order_line_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  CONSTRAINT `purchase_order_line_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`purchase_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `putaway_configuration`;
CREATE TABLE `putaway_configuration` (
  `putaway_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `sequence` int NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `location_group_id` bigint DEFAULT NULL,
  `location_group_type_id` bigint DEFAULT NULL,
  `strategies` varchar(100) NOT NULL,
  `client_id` bigint DEFAULT NULL,
  PRIMARY KEY (`putaway_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `qc_configuration`;
CREATE TABLE `qc_configuration` (
  `qc_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `qc_pass_inventory_status_id` bigint NOT NULL,
  `qc_fail_inventory_status_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`qc_configuration_id`),
  KEY `qc_pass_inventory_status_id` (`qc_pass_inventory_status_id`),
  KEY `qc_fail_inventory_status_id` (`qc_fail_inventory_status_id`),
  CONSTRAINT `qc_configuration_ibfk_1` FOREIGN KEY (`qc_pass_inventory_status_id`) REFERENCES `inventory_status` (`inventory_status_id`),
  CONSTRAINT `qc_configuration_ibfk_2` FOREIGN KEY (`qc_fail_inventory_status_id`) REFERENCES `inventory_status` (`inventory_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `qc_inspection_request`;
CREATE TABLE `qc_inspection_request` (
  `qc_inspection_request_id` bigint NOT NULL AUTO_INCREMENT,
  `inventory_id` bigint DEFAULT NULL,
  `qc_inspection_result` varchar(200) DEFAULT NULL,
  `qc_username` varchar(200) DEFAULT NULL,
  `qc_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `number` varchar(25) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `work_order_qc_sample_id` bigint DEFAULT NULL,
  `qc_rf_code` varchar(50) DEFAULT NULL,
  `qc_quantity` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `receipt_id` bigint DEFAULT NULL,
  `qc_inspection_request_type` varchar(50) DEFAULT NULL,
  `document_urls` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`qc_inspection_request_id`),
  KEY `inventory_id` (`inventory_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `qc_inspection_request_ibfk_1` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`),
  CONSTRAINT `qc_inspection_request_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `qc_inspection_request_inventory`;
CREATE TABLE `qc_inspection_request_inventory` (
  `inventory_id` bigint NOT NULL,
  `qc_inspection_request_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  KEY `qc_inspection_request_id` (`qc_inspection_request_id`),
  KEY `inventory_id` (`inventory_id`),
  CONSTRAINT `qc_inspection_request_inventory_ibfk_1` FOREIGN KEY (`qc_inspection_request_id`) REFERENCES `qc_inspection_request` (`qc_inspection_request_id`),
  CONSTRAINT `qc_inspection_request_inventory_ibfk_2` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `qc_inspection_request_item`;
CREATE TABLE `qc_inspection_request_item` (
  `qc_inspection_request_item_id` bigint NOT NULL AUTO_INCREMENT,
  `qc_rule_id` bigint NOT NULL,
  `qc_inspection_result` varchar(200) DEFAULT NULL,
  `qc_inspection_request_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`qc_inspection_request_item_id`),
  KEY `qc_inspection_request_id` (`qc_inspection_request_id`),
  KEY `qc_rule_id` (`qc_rule_id`),
  CONSTRAINT `qc_inspection_request_item_ibfk_1` FOREIGN KEY (`qc_inspection_request_id`) REFERENCES `qc_inspection_request` (`qc_inspection_request_id`),
  CONSTRAINT `qc_inspection_request_item_ibfk_2` FOREIGN KEY (`qc_rule_id`) REFERENCES `qc_rule` (`qc_rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `qc_inspection_request_item_option`;
CREATE TABLE `qc_inspection_request_item_option` (
  `qc_inspection_request_item_option_id` bigint NOT NULL AUTO_INCREMENT,
  `qc_rule_item_id` bigint NOT NULL,
  `qc_inspection_result` varchar(200) DEFAULT NULL,
  `qc_inspection_request_item_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `string_value` varchar(2000) DEFAULT NULL,
  `double_value` double DEFAULT NULL,
  `boolean_value` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`qc_inspection_request_item_option_id`),
  KEY `qc_inspection_request_item_id` (`qc_inspection_request_item_id`),
  KEY `qc_rule_item_id` (`qc_rule_item_id`),
  CONSTRAINT `qc_inspection_request_item_option_ibfk_1` FOREIGN KEY (`qc_inspection_request_item_id`) REFERENCES `qc_inspection_request_item` (`qc_inspection_request_item_id`),
  CONSTRAINT `qc_inspection_request_item_option_ibfk_2` FOREIGN KEY (`qc_rule_item_id`) REFERENCES `qc_rule_item` (`qc_rule_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `qc_rule`;
CREATE TABLE `qc_rule` (
  `qc_rule_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`qc_rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `qc_rule_configuration`;
CREATE TABLE `qc_rule_configuration` (
  `qc_rule_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `sequence` bigint DEFAULT NULL,
  PRIMARY KEY (`qc_rule_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `qc_rule_configuration_rule`;
CREATE TABLE `qc_rule_configuration_rule` (
  `qc_rule_configuration_id` bigint NOT NULL,
  `qc_rule_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  KEY `qc_rule_configuration_id` (`qc_rule_configuration_id`),
  KEY `qc_rule_id` (`qc_rule_id`),
  CONSTRAINT `qc_rule_configuration_rule_ibfk_1` FOREIGN KEY (`qc_rule_configuration_id`) REFERENCES `qc_rule_configuration` (`qc_rule_configuration_id`),
  CONSTRAINT `qc_rule_configuration_rule_ibfk_2` FOREIGN KEY (`qc_rule_id`) REFERENCES `qc_rule` (`qc_rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `qc_rule_item`;
CREATE TABLE `qc_rule_item` (
  `qc_rule_item_id` bigint NOT NULL AUTO_INCREMENT,
  `check_point` varchar(1000) NOT NULL,
  `qc_rule_item_type` varchar(200) NOT NULL,
  `expected_value` varchar(200) NOT NULL,
  `qc_rule_item_comparator` varchar(20) NOT NULL,
  `qc_rule_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`qc_rule_item_id`),
  KEY `qc_rule_id` (`qc_rule_id`),
  CONSTRAINT `qc_rule_item_ibfk_1` FOREIGN KEY (`qc_rule_id`) REFERENCES `qc_rule` (`qc_rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `quickbook_online_configuration`;
CREATE TABLE `quickbook_online_configuration` (
  `quickbook_online_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `client_id` varchar(100) DEFAULT NULL,
  `client_secret` varchar(100) DEFAULT NULL,
  `webhook_verifier_token` varchar(100) DEFAULT NULL,
  `quickbook_online_url` varchar(200) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`quickbook_online_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `quickbook_online_token`;
CREATE TABLE `quickbook_online_token` (
  `quickbook_online_token_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `realm_id` varchar(100) DEFAULT NULL,
  `authorization_code` varchar(100) DEFAULT NULL,
  `token` varchar(1000) DEFAULT NULL,
  `refresh_token` varchar(100) DEFAULT NULL,
  `last_token_request_time` datetime DEFAULT NULL,
  `last_cdc_call_time` varchar(50) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`quickbook_online_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `quickbook_webhook_history`;
CREATE TABLE `quickbook_webhook_history` (
  `quickbook_webhook_history_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `realm_id` varchar(100) DEFAULT NULL,
  `signature` varchar(500) DEFAULT NULL,
  `payload` varchar(15000) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `error_message` varchar(500) DEFAULT NULL,
  `processed_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`quickbook_webhook_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `reason_code`;
CREATE TABLE `reason_code` (
  `reason_code_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `type` int NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`reason_code_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `reason_code` (`reason_code_id`, `warehouse_id`, `name`, `description`, `type`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	1,	'Damaged',	'Inventory is damaged',	0,	NULL,	NULL,	NULL,	NULL),
(2,	1,	'Office-Use',	'Used by Office',	0,	NULL,	NULL,	NULL,	NULL),
(3,	1,	'Customer-Gift',	'Used as a gift to customer',	0,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `receipt`;
CREATE TABLE `receipt` (
  `receipt_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `status` int NOT NULL,
  `allow_unexpected_item` tinyint(1) NOT NULL,
  `supplier_id` bigint DEFAULT NULL,
  `category` varchar(50) NOT NULL DEFAULT 'PURCHASE_ORDER',
  `transfer_order_number` varchar(50) DEFAULT NULL,
  `transfer_order_warehouse_id` bigint DEFAULT NULL,
  `check_in_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `purchase_order_id` bigint DEFAULT NULL,
  PRIMARY KEY (`receipt_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`purchase_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `receipt_billable_activity`;
CREATE TABLE `receipt_billable_activity` (
  `receipt_billable_activity_id` bigint NOT NULL AUTO_INCREMENT,
  `billable_activity_type_id` bigint NOT NULL,
  `activity_time` datetime NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `receipt_id` bigint NOT NULL,
  `rate` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `total_charge` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`receipt_billable_activity_id`),
  KEY `receipt_id` (`receipt_id`),
  CONSTRAINT `receipt_billable_activity_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `receipt` (`receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `receipt_line`;
CREATE TABLE `receipt_line` (
  `receipt_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(100) NOT NULL,
  `item_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `expected_quantity` bigint NOT NULL,
  `received_quantity` bigint NOT NULL,
  `receipt_id` bigint DEFAULT NULL,
  `over_receiving_quantity` bigint NOT NULL,
  `over_receiving_percent` double NOT NULL,
  `qc_quantity` bigint DEFAULT NULL,
  `qc_percentage` double DEFAULT NULL,
  `qc_quantity_requested` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `purchase_order_line_id` bigint DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `product_size` varchar(100) DEFAULT NULL,
  `style` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`receipt_line_id`),
  KEY `receipt_id` (`receipt_id`),
  KEY `purchase_order_line_id` (`purchase_order_line_id`),
  CONSTRAINT `receipt_line_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `receipt` (`receipt_id`),
  CONSTRAINT `receipt_line_ibfk_2` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `purchase_order_line` (`purchase_order_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `receipt_line_billable_activity`;
CREATE TABLE `receipt_line_billable_activity` (
  `receipt_line_billable_activity_id` bigint NOT NULL AUTO_INCREMENT,
  `billable_activity_type_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `activity_time` datetime NOT NULL,
  `receipt_line_id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `total_charge` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`receipt_line_billable_activity_id`),
  KEY `receipt_line_id` (`receipt_line_id`),
  CONSTRAINT `receipt_line_billable_activity_ibfk_1` FOREIGN KEY (`receipt_line_id`) REFERENCES `receipt_line` (`receipt_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `report_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `orientation` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `printer_type_id` bigint DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `report` (`report_id`, `company_id`, `warehouse_id`, `description`, `type`, `file_name`, `orientation`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `printer_type_id`) VALUES
(1,	NULL,	NULL,	'Order Pick Sheet',	'ORDER_PICK_SHEET',	'order_pick_sheet',	'PORTRAIT',	'2023-05-17 09:06:48',	'CWMS-USER',	'2023-07-21 01:37:55',	'CWMS-USER',	NULL),
(2,	NULL,	NULL,	'Receiving Document',	'RECEIVING_DOCUMENT',	'receiving_document',	'LANDSCAPE',	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	NULL,	NULL,	'Putaway Document',	'PUTAWAY_DOCUMENT',	'putaway_document',	'LANDSCAPE',	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	NULL,	NULL,	'Cycle Count Sheet',	'CYCLE_COUNT_SHEET',	'cycle_count_sheet',	'LANDSCAPE',	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	NULL,	NULL,	'Audit Count Sheet',	'AUDIT_COUNT_SHEET',	'audit_count_sheet',	'LANDSCAPE',	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	NULL,	NULL,	'LPN Report',	'LPN_REPORT',	'ecotech_lpn_label',	'PORTRAIT',	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	NULL,	NULL,	'Work Order Pick Sheet',	'WORK_ORDER_PICK_SHEET',	'work_order_pick_sheet',	'LANDSCAPE',	NULL,	NULL,	NULL,	NULL,	NULL),
(8,	NULL,	NULL,	'Production Line Assignment Report',	'PRODUCTION_LINE_ASSIGNMENT_REPORT',	'ecotech_production_line_assignment_report',	'PORTRAIT',	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	NULL,	NULL,	'Packing Slip',	'PACKING_SLIP',	'packing_slip',	'PORTRAIT',	NULL,	NULL,	NULL,	NULL,	NULL),
(11,	NULL,	NULL,	'bill_of_lading',	'BILL_OF_LADING',	'bill_of_lading',	'PORTRAIT',	NULL,	NULL,	NULL,	NULL,	NULL),
(13,	NULL,	NULL,	'lpn label',	'LPN_LABEL',	'lpn_label.prn',	'PORTRAIT',	'2023-05-17 09:06:49',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER',	NULL),
(14,	NULL,	NULL,	'Production Line Assignment Label',	'PRODUCTION_LINE_ASSIGNMENT_LABEL',	'ecotech_production_line_assignment_label.prn',	'PORTRAIT',	NULL,	NULL,	NULL,	NULL,	NULL),
(18,	1,	NULL,	'BOL',	'BILL_OF_LADING',	'ecotech_bill_of_lading',	'LANDSCAPE',	NULL,	NULL,	NULL,	NULL,	NULL),
(19,	1,	NULL,	'Packing',	'PACKING_SLIP',	'ecotech_packing_slip',	'LANDSCAPE',	NULL,	NULL,	NULL,	NULL,	NULL),
(33,	NULL,	NULL,	'Receiving LPN Label',	'RECEIVING_LPN_LABEL',	'ecotech_receiving_lpn_label.prn',	'PORTRAIT',	'2023-05-17 09:06:49',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER',	NULL),
(46,	NULL,	NULL,	'QC Inspection Request Report',	'QC_INSPECTION_REQUEST_REPORT',	'qc_inspection_request_report',	'PORTRAIT',	'2023-05-17 09:06:49',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER',	NULL),
(47,	1,	NULL,	'Ecotech receving',	'RECEIVING_DOCUMENT',	'eco_receiving_document',	'LANDSCAPE',	'2021-12-30 11:34:23',	NULL,	'2021-12-30 11:34:23',	NULL,	NULL),
(48,	1,	NULL,	'',	'WORK_ORDER_PICK_SHEET',	'eco_work_order_pick_sheet',	'LANDSCAPE',	'2022-01-07 11:32:37',	NULL,	'2022-01-07 11:32:37',	NULL,	NULL),
(66,	NULL,	NULL,	'Receiving LPN Report',	'RECEIVING_LPN_REPORT',	'ecotech_receiving_lpn',	'PORTRAIT',	'2023-05-17 09:06:49',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER',	NULL),
(69,	1,	NULL,	'Ecotech AR receiving LPN Report',	'RECEIVING_LPN_REPORT',	'ecotech_ar_receiving_lpn',	'LANDSCAPE',	'2022-08-04 14:51:54',	NULL,	'2022-08-04 14:51:54',	NULL,	NULL),
(73,	1,	NULL,	'',	'LPN_REPORT',	'ecotech_lpn_label',	'LANDSCAPE',	'2023-05-16 12:02:13',	'XXXX',	NULL,	'XXXX',	1),
(82,	1,	NULL,	'Production line Assignment label - DPI 300',	'PRODUCTION_LINE_ASSIGNMENT_LABEL',	'ecotech_production_line_assignment_label_300dpi.prn',	'LANDSCAPE',	'2023-05-17 12:49:53',	'XXXX',	NULL,	'XXXX',	2),
(83,	1,	NULL,	'Production lIne assignment label ',	'PRODUCTION_LINE_ASSIGNMENT_LABEL',	'ecotech_production_line_assignment_label_200dpi.prn',	'LANDSCAPE',	'2023-05-17 12:53:32',	'XXXX',	NULL,	'XXXX',	NULL),
(84,	1,	NULL,	'Ecotech Receiving LPN Label',	'RECEIVING_LPN_LABEL',	'ecotech_receiving_lpn_label_200dpi.prn',	'LANDSCAPE',	'2023-05-17 16:55:35',	'XXXX',	NULL,	'XXXX',	NULL),
(85,	1,	NULL,	'Ecoech Receiving LPN Label 300 DPI',	'RECEIVING_LPN_LABEL',	'ecotech_receiving_lpn_label_300dpi.prn',	'LANDSCAPE',	'2023-05-17 16:56:04',	'XXXX',	NULL,	'XXXX',	2),
(86,	NULL,	NULL,	'Bulk Pick Sheet',	'BULK_PICK_SHEET',	'bulk_pick_sheet',	'PORTRAIT',	'2023-07-12 22:57:48',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER',	NULL),
(87,	NULL,	NULL,	'Pick Sheet',	'PICK_SHEET',	'pick_sheet',	'PORTRAIT',	'2023-07-12 22:57:48',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER',	NULL),
(88,	NULL,	NULL,	'List Pick Sheet',	'PICK_LIST_SHEET',	'list_pick_sheet',	'PORTRAIT',	'2023-07-12 22:57:48',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER',	NULL),
(89,	NULL,	NULL,	'Walmart Shipping Carton Label',	'WALMART_SHIPPING_CARTON_LABEL',	'walmart_shipping_carton_label.prn',	'PORTRAIT',	'2023-07-13 22:12:45',	'CWMS-USER',	'2023-07-21 01:37:56',	'CWMS-USER',	NULL);

DROP TABLE IF EXISTS `report_history`;
CREATE TABLE `report_history` (
  `report_history_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `orientation` varchar(20) NOT NULL,
  `printed_date` datetime NOT NULL,
  `printed_username` varchar(100) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  PRIMARY KEY (`report_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `report_printer_configuration`;
CREATE TABLE `report_printer_configuration` (
  `report_printer_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `report_type` varchar(50) NOT NULL,
  `criteria_value` varchar(1000) NOT NULL,
  `printer_name` varchar(200) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `copies` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`report_printer_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `return_material_request`;
CREATE TABLE `return_material_request` (
  `return_material_request_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_line_complete_transaction_id` bigint NOT NULL,
  `lpn` varchar(100) NOT NULL,
  `quantity` bigint DEFAULT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `item_package_type_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`return_material_request_id`),
  KEY `work_order_line_complete_transaction_id` (`work_order_line_complete_transaction_id`),
  CONSTRAINT `return_material_request_ibfk_1` FOREIGN KEY (`work_order_line_complete_transaction_id`) REFERENCES `work_order_line_complete_transaction` (`work_order_line_complete_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `rf_app_version`;
CREATE TABLE `rf_app_version` (
  `rf_app_version_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `version_number` varchar(10) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_size` bigint NOT NULL,
  `release_note` varchar(10000) NOT NULL,
  `is_latest_version` tinyint(1) NOT NULL,
  `release_date` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rf_app_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `rf_app_version` (`rf_app_version_id`, `company_id`, `version_number`, `file_name`, `file_size`, `release_note`, `is_latest_version`, `release_date`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	1,	'1.0.3',	'app-armeabi-v7a-release.apk',	7507059,	'1. bug fix\n2. add QC sampling page',	1,	'2021-11-16 18:48:03',	'2021-11-16 10:48:43',	NULL,	'2021-12-07 17:20:07',	NULL);

DROP TABLE IF EXISTS `rf_app_version_by_rf_code`;
CREATE TABLE `rf_app_version_by_rf_code` (
  `rf_app_version_by_rf_code_id` bigint NOT NULL AUTO_INCREMENT,
  `rf_id` bigint NOT NULL,
  `rf_app_version_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rf_app_version_by_rf_code_id`),
  KEY `rf_id` (`rf_id`),
  KEY `rf_app_version_id` (`rf_app_version_id`),
  CONSTRAINT `rf_app_version_by_rf_code_ibfk_1` FOREIGN KEY (`rf_id`) REFERENCES `rf_info` (`rf_id`),
  CONSTRAINT `rf_app_version_by_rf_code_ibfk_2` FOREIGN KEY (`rf_app_version_id`) REFERENCES `rf_app_version` (`rf_app_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `rf_configuration`;
CREATE TABLE `rf_configuration` (
  `rf_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `rf_code` varchar(10) DEFAULT NULL,
  `work_order_validate_partial_lpn_pick` tinyint(1) NOT NULL,
  `work_order_pick_to_production_line_in_stage` tinyint(1) NOT NULL,
  `receiving_receive_to_stage` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `list_pick_batch_picking` tinyint(1) DEFAULT NULL,
  `printer_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rf_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `rf_configuration` (`rf_configuration_id`, `warehouse_id`, `rf_code`, `work_order_validate_partial_lpn_pick`, `work_order_pick_to_production_line_in_stage`, `receiving_receive_to_stage`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `list_pick_batch_picking`, `printer_name`) VALUES
(1,	1,	NULL,	0,	1,	0,	'2023-02-07 10:12:46',	'GZHANG',	'2023-06-16 05:48:00',	'XXXX',	NULL,	'Warehouse_label');

DROP TABLE IF EXISTS `rf_info`;
CREATE TABLE `rf_info` (
  `rf_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint DEFAULT NULL,
  `rf_code` varchar(100) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `current_location_id` bigint DEFAULT NULL,
  `printer_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rf_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `non_client_data_accessible` tinyint(1) DEFAULT NULL,
  `all_client_access` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `role_client_access`;
CREATE TABLE `role_client_access` (
  `role_client_access_id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL,
  `client_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`role_client_access_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `role_id` bigint NOT NULL,
  `menu_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `role_menu_id` bigint NOT NULL AUTO_INCREMENT,
  `display_only` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`role_menu_id`),
  KEY `role_id` (`role_id`),
  KEY `menu_id` (`menu_id`),
  CONSTRAINT `role_menu_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `role_menu_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `role_operation_type`;
CREATE TABLE `role_operation_type` (
  `role_operation_type_id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL,
  `operation_type_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`role_operation_type_id`),
  KEY `role_id` (`role_id`),
  KEY `operation_type_id` (`operation_type_id`),
  CONSTRAINT `role_operation_type_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `role_operation_type_ibfk_2` FOREIGN KEY (`operation_type_id`) REFERENCES `operation_type` (`operation_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_permission_id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  `allow_access` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`role_permission_id`),
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `shipment`;
CREATE TABLE `shipment` (
  `shipment_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `stop_id` bigint DEFAULT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `ship_to_customer_id` bigint DEFAULT NULL,
  `ship_to_contactor_firstname` varchar(100) DEFAULT NULL,
  `ship_to_contactor_lastname` varchar(100) DEFAULT NULL,
  `ship_to_address_country` varchar(100) DEFAULT NULL,
  `ship_to_address_state` varchar(100) DEFAULT NULL,
  `ship_to_address_county` varchar(100) DEFAULT NULL,
  `ship_to_address_city` varchar(100) DEFAULT NULL,
  `ship_to_address_district` varchar(100) DEFAULT NULL,
  `ship_to_address_line1` varchar(100) DEFAULT NULL,
  `ship_to_address_line2` varchar(100) DEFAULT NULL,
  `ship_to_address_postcode` varchar(25) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `complete_time` datetime DEFAULT NULL,
  `stage_location_group_id` bigint DEFAULT NULL,
  `stage_location_id` bigint DEFAULT NULL,
  PRIMARY KEY (`shipment_id`),
  KEY `stop_id` (`stop_id`),
  CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`stop_id`) REFERENCES `stop` (`stop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `shipment_line`;
CREATE TABLE `shipment_line` (
  `shipment_line_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(100) NOT NULL,
  `shipment_id` bigint NOT NULL,
  `wave_id` bigint DEFAULT NULL,
  `outbound_order_line_id` bigint DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `open_quantity` bigint NOT NULL,
  `inprocess_quantity` bigint NOT NULL,
  `loaded_quantity` bigint NOT NULL,
  `shipped_quantity` bigint NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `stage_location_group_id` bigint DEFAULT NULL,
  `stage_location_id` bigint DEFAULT NULL,
  PRIMARY KEY (`shipment_line_id`),
  KEY `shipment_id` (`shipment_id`),
  KEY `outbound_order_line_id` (`outbound_order_line_id`),
  KEY `wave_id` (`wave_id`),
  CONSTRAINT `shipment_line_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`shipment_id`),
  CONSTRAINT `shipment_line_ibfk_2` FOREIGN KEY (`outbound_order_line_id`) REFERENCES `outbound_order_line` (`outbound_order_line_id`),
  CONSTRAINT `shipment_line_ibfk_3` FOREIGN KEY (`wave_id`) REFERENCES `wave` (`wave_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `shipping_cartonization`;
CREATE TABLE `shipping_cartonization` (
  `shipping_cartonization_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(20) NOT NULL,
  `carton_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipping_cartonization_id`),
  KEY `carton_id` (`carton_id`),
  CONSTRAINT `shipping_cartonization_ibfk_1` FOREIGN KEY (`carton_id`) REFERENCES `carton` (`carton_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `shipping_stage_area_configuration`;
CREATE TABLE `shipping_stage_area_configuration` (
  `shipping_stage_area_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `sequence` int NOT NULL,
  `location_group_id` bigint NOT NULL,
  `location_reserve_strategy` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipping_stage_area_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `short_allocation`;
CREATE TABLE `short_allocation` (
  `short_allocation_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `shipment_line_id` bigint DEFAULT NULL,
  `work_order_line_id` bigint DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `open_quantity` bigint NOT NULL,
  `inprocess_quantity` bigint NOT NULL,
  `delivered_quantity` bigint NOT NULL,
  `allocation_count` bigint NOT NULL,
  `last_allocation_datetime` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `work_order_quantity` bigint DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `product_size` varchar(100) DEFAULT NULL,
  `style` varchar(100) DEFAULT NULL,
  `allocate_by_receipt_number` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`short_allocation_id`),
  KEY `shipment_line_id` (`shipment_line_id`),
  CONSTRAINT `short_allocation_ibfk_1` FOREIGN KEY (`shipment_line_id`) REFERENCES `shipment_line` (`shipment_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `short_allocation_configuration`;
CREATE TABLE `short_allocation_configuration` (
  `short_allocation_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `last_modify_datetime` datetime DEFAULT NULL,
  `last_modify_username` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `retry_interval` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`short_allocation_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `silo_api_call_history`;
CREATE TABLE `silo_api_call_history` (
  `silo_api_call_history_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `method` varchar(50) NOT NULL,
  `parameters` varchar(500) DEFAULT NULL,
  `response` varchar(20000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`silo_api_call_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `silo_configuration`;
CREATE TABLE `silo_configuration` (
  `silo_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `web_api_protocol` varchar(50) NOT NULL,
  `web_api_url` varchar(200) NOT NULL,
  `web_api_username` varchar(100) NOT NULL,
  `web_api_password` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `inventory_information_from_wms` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`silo_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `silo_device_api_call_history`;
CREATE TABLE `silo_device_api_call_history` (
  `silo_device_api_call_history_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `web_api_call_timestamp` bigint NOT NULL,
  `location_name` varchar(200) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `device_id` bigint DEFAULT NULL,
  `material` varchar(200) DEFAULT NULL,
  `item_name` varchar(200) DEFAULT NULL,
  `distance` double DEFAULT NULL,
  `timestamp` bigint DEFAULT NULL,
  `status_code` varchar(200) DEFAULT NULL,
  `token` varchar(300) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`silo_device_api_call_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `spare_part`;
CREATE TABLE `spare_part` (
  `spare_part_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `number` varchar(50) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `quantity` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`spare_part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `spare_part_detail`;
CREATE TABLE `spare_part_detail` (
  `spare_part_detail_id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `spare_part_id` bigint NOT NULL,
  `quantity` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`spare_part_detail_id`),
  KEY `spare_part_id` (`spare_part_id`),
  CONSTRAINT `spare_part_detail_ibfk_1` FOREIGN KEY (`spare_part_id`) REFERENCES `spare_part` (`spare_part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `stop`;
CREATE TABLE `stop` (
  `stop_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `stop_sequence` bigint DEFAULT NULL,
  `trailer_appointment_id` bigint DEFAULT NULL,
  `contactor_firstname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contactor_lastname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_country` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_state` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_county` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(25) DEFAULT NULL,
  `number` varchar(25) NOT NULL,
  `trailer_id` bigint DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `ship_to_customer_id` bigint DEFAULT NULL,
  PRIMARY KEY (`stop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `supplier_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `contactor_firstname` varchar(100) NOT NULL,
  `contactor_lastname` varchar(100) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_county` varchar(100) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) NOT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(25) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `user_defined_field_1` varchar(100) DEFAULT NULL,
  `user_defined_field_2` varchar(100) DEFAULT NULL,
  `user_defined_field_3` varchar(100) DEFAULT NULL,
  `user_defined_field_4` varchar(100) DEFAULT NULL,
  `user_defined_field_5` varchar(100) DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `quickbook_listid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `system_configuration`;
CREATE TABLE `system_configuration` (
  `system_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `allow_data_initial` tinyint(1) NOT NULL DEFAULT '0',
  `server_side_printing` tinyint(1) NOT NULL DEFAULT '1',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`system_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `system_configuration` (`system_configuration_id`, `company_id`, `warehouse_id`, `allow_data_initial`, `server_side_printing`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	1,	1,	1,	1,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `system_controlled_number`;
CREATE TABLE `system_controlled_number` (
  `system_controlled_number_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `variable` varchar(100) NOT NULL,
  `prefix` varchar(10) NOT NULL,
  `postfix` varchar(10) NOT NULL,
  `length` int NOT NULL,
  `current_number` varchar(100) NOT NULL,
  `rollover` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`system_controlled_number_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `system_controlled_number` (`system_controlled_number_id`, `warehouse_id`, `variable`, `prefix`, `postfix`, `length`, `current_number`, `rollover`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	1,	'cycle-count-batch-id',	'CB',	'',	10,	'1',	1,	'2023-05-17 09:04:38',	'ADMIN_USER',	'2023-06-07 13:43:31',	'ADMIN_USER'),
(2,	1,	'lpn',	'L',	'',	10,	'1',	1,	'2023-05-17 09:04:46',	'ADMIN_USER',	'2023-07-12 09:12:54',	'XXXX'),
(3,	1,	'receipt-number',	'RECPT',	'',	10,	'1',	1,	'2023-05-17 09:04:55',	'ADMIN_USER',	'2023-06-07 13:43:45',	'ADMIN_USER'),
(4,	1,	'shipment-number',	'SHIP',	'',	10,	'1',	1,	'2023-05-17 09:04:57',	'ADMIN_USER',	'2023-07-21 23:40:45',	'GZHANG'),
(5,	1,	'shipment-line-number',	'SL',	'',	10,	'1',	1,	'2023-05-17 09:04:56',	'ADMIN_USER',	'2023-06-07 13:43:46',	'ADMIN_USER'),
(6,	1,	'wave-number',	'WAV',	'',	10,	'1',	1,	'2023-05-17 09:05:01',	'ADMIN_USER',	'2023-07-21 23:40:44',	'GZHANG'),
(7,	1,	'pick-number',	'PICK',	'',	10,	'1',	1,	'2023-05-17 09:04:51',	'ADMIN_USER',	'2023-07-21 23:12:59',	'GZHANG'),
(8,	1,	'work-order-number',	'WO',	'',	10,	'1',	1,	'2023-05-17 09:05:02',	'ADMIN_USER',	'2023-07-07 15:22:02',	'XXXX'),
(9,	1,	'cancelled-pick-number',	'CPK',	'',	10,	'1',	1,	'2023-05-17 09:04:33',	'ADMIN_USER',	'2023-07-21 23:37:38',	'GZHANG'),
(10,	1,	'inventory-activity-transaction-id',	'INVACT',	'',	10,	'1',	1,	'2023-05-17 09:04:39',	'ADMIN_USER',	'2023-07-12 09:38:47',	'rf113'),
(11,	1,	'inventory-activity-transaction-group-id',	'INVACTGRP',	'',	10,	'1',	1,	'2023-05-17 09:04:39',	'ADMIN_USER',	'2023-07-12 09:38:47',	'rf113'),
(12,	1,	'list-pick',	'LPICK',	'',	10,	'1',	1,	'2023-05-17 09:04:44',	'ADMIN_USER',	'2023-06-07 13:43:38',	'ADMIN_USER'),
(13,	1,	'cartonization-number',	'CTN',	'',	10,	'1',	1,	'2023-05-17 09:04:35',	'ADMIN_USER',	'2023-06-07 13:43:28',	'ADMIN_USER'),
(14,	1,	'shipping-cartonization-number',	'SCTN',	'',	10,	'1',	1,	'2023-05-17 09:04:59',	'ADMIN_USER',	'2023-06-07 13:43:47',	'ADMIN_USER'),
(15,	1,	'production-plan',	'PRP',	'',	10,	'1',	1,	'2023-05-17 09:04:51',	'ADMIN_USER',	'2023-06-07 13:43:45',	'ADMIN_USER'),
(16,	1,	'bill-of-material',	'BOM',	'',	10,	'1',	1,	'2023-05-17 09:04:32',	'ADMIN_USER',	'2023-06-07 13:43:25',	'ADMIN_USER'),
(17,	1,	'work-task',	'WT',	'',	10,	'1',	0,	'2023-05-17 09:05:04',	'ADMIN_USER',	'2023-06-07 13:43:51',	'ADMIN_USER'),
(18,	1,	'inventory-snapshot-batch-number',	'INVSNAP',	'',	10,	'1',	1,	'2023-05-17 09:04:42',	'ADMIN_USER',	'2023-06-07 13:43:35',	'ADMIN_USER'),
(19,	1,	'order-number',	'FY',	'',	9,	'1',	0,	'2023-05-17 09:04:50',	'ADMIN_USER',	'2023-06-07 13:43:42',	'ADMIN_USER'),
(20,	1,	'qc-inspection-request',	'QCR',	'',	10,	'1',	1,	'2021-10-07 09:56:32',	'ADMIN_USER',	'2023-07-12 09:38:34',	'rf003'),
(21,	1,	'work-order-qc-sample-number',	'WQC',	'',	8,	'1',	1,	'2021-10-12 11:32:46',	'ADMIN_USER',	'2023-07-11 18:11:46',	'rf008'),
(22,	1,	'work-order-lpn-number',	'W1',	'',	10,	'1',	0,	'2021-10-20 12:30:53',	'ADMIN_USER',	'2023-07-12 08:41:22',	'XXXX'),
(23,	1,	'receiving-lpn-number',	'R1',	'',	10,	'1',	0,	'2021-10-20 13:46:06',	'ADMIN_USER',	'2023-07-12 09:35:36',	'XXXX'),
(24,	1,	'item-sampling-number',	'IS',	'',	10,	'1',	1,	'2021-12-11 09:34:57',	'ADMIN_USER',	'2023-06-07 13:43:36',	'ADMIN_USER'),
(25,	1,	'order-activity-number',	'OA',	'',	10,	'1',	1,	'2021-12-29 12:03:22',	'ADMIN_USER',	'2023-07-21 23:40:46',	'GZHANG'),
(26,	1,	'order-activity-transaction-group-id',	'OAG',	'',	10,	'1',	1,	'2021-12-29 12:13:23',	'ADMIN_USER',	'2023-07-21 23:40:44',	'GZHANG'),
(27,	1,	'mps-number',	'MPS',	'',	10,	'1',	1,	'2022-01-14 15:14:21',	'ADMIN_USER',	'2023-06-07 13:43:40',	'ADMIN_USER'),
(28,	1,	'mrp-number',	'MRP',	'',	10,	'1',	1,	'2022-01-28 10:47:40',	'ADMIN_USER',	'2023-06-07 13:43:40',	'ADMIN_USER'),
(29,	1,	'allocation-transaction-history-number',	'ATH',	'',	10,	'1',	1,	'2022-02-08 20:17:01',	'ADMIN_USER',	'2023-07-21 23:12:43',	'GZHANG'),
(30,	1,	'allocation-transaction-history-group-id',	'ATHG',	'',	10,	'1',	1,	'2022-02-08 20:17:19',	'ADMIN_USER',	'2023-07-21 23:08:05',	'GZHANG'),
(31,	1,	'trailer-appointment-number',	'TAP',	'',	10,	'1',	1,	'2022-02-24 11:25:11',	'ADMIN_USER',	'2023-06-07 13:43:48',	'ADMIN_USER'),
(32,	1,	'stop',	'STP',	'',	10,	'1',	1,	'2022-02-24 19:07:48',	'ADMIN_USER',	'2023-06-07 13:43:48',	'ADMIN_USER'),
(33,	1,	'csr-order-number',	'CSR',	'',	10,	'1',	1,	'2022-03-21 11:44:34',	'ADMIN_USER',	'2023-06-07 13:43:30',	'ADMIN_USER'),
(34,	1,	'location-utilization-snapshot-number',	'LUS',	'',	10,	'1',	1,	'2022-03-27 08:42:42',	'ADMIN_USER',	'2023-06-07 13:43:39',	'ADMIN_USER'),
(35,	1,	'invoice-number',	'INVOICE',	'',	10,	'1',	1,	'2022-03-31 13:17:07',	'ADMIN_USER',	'2023-06-07 13:43:34',	'ADMIN_USER'),
(36,	1,	'billing-request-number',	'BR',	'',	10,	'1',	1,	'2022-03-31 15:10:13',	'ADMIN_USER',	'2023-06-07 13:43:27',	'ADMIN_USER'),
(37,	2,	'allocation-transaction-history-group-id',	'ATHG',	'',	10,	'1',	1,	'2022-08-09 14:00:29',	'ADMIN_USER',	'2023-06-07 13:43:53',	'ADMIN_USER'),
(38,	2,	'allocation-transaction-history-number',	'ATH',	'',	10,	'1',	1,	'2022-08-09 14:00:30',	'ADMIN_USER',	'2023-06-07 13:43:53',	'ADMIN_USER'),
(39,	2,	'bill-of-material',	'BOM',	'',	10,	'1',	1,	'2022-08-09 14:00:31',	'ADMIN_USER',	'2023-06-07 13:43:54',	'ADMIN_USER'),
(40,	2,	'billing-request-number',	'BR',	'',	10,	'1',	1,	'2022-08-09 14:00:31',	'ADMIN_USER',	'2023-06-07 13:43:56',	'ADMIN_USER'),
(41,	2,	'cancelled-pick-number',	'CPK',	'',	10,	'1',	1,	'2022-08-09 14:00:31',	'ADMIN_USER',	'2023-06-07 13:43:57',	'ADMIN_USER'),
(42,	2,	'cartonization-number',	'CTN',	'',	10,	'1',	1,	'2022-08-09 14:00:32',	'ADMIN_USER',	'2023-06-07 13:43:57',	'ADMIN_USER'),
(43,	2,	'csr-order-number',	'CSR',	'',	10,	'1',	1,	'2022-08-09 14:00:32',	'ADMIN_USER',	'2023-06-07 13:43:58',	'ADMIN_USER'),
(44,	2,	'cycle-count-batch-id',	'CB',	'',	10,	'1',	1,	'2022-08-09 14:00:33',	'ADMIN_USER',	'2023-06-07 13:43:58',	'ADMIN_USER'),
(45,	2,	'inventory-activity-transaction-group-id',	'INVACTGRP',	'',	10,	'23',	1,	'2022-08-09 14:00:33',	'ADMIN_USER',	'2023-06-07 13:43:59',	'ADMIN_USER'),
(46,	2,	'inventory-activity-transaction-id',	'INVACT',	'',	10,	'23',	1,	'2022-08-09 14:00:33',	'ADMIN_USER',	'2023-06-07 13:43:59',	'ADMIN_USER'),
(47,	2,	'invoice-number',	'INVOICE',	'',	10,	'23',	1,	'2022-08-09 14:00:34',	'ADMIN_USER',	'2023-06-07 13:43:59',	'ADMIN_USER'),
(48,	2,	'item-sampling-number',	'IS',	'',	10,	'23',	1,	'2022-08-09 14:00:35',	'ADMIN_USER',	'2023-06-07 13:44:00',	'ADMIN_USER'),
(49,	2,	'list-pick',	'LPICK',	'',	10,	'23',	1,	'2022-08-09 14:00:35',	'ADMIN_USER',	'2023-06-07 13:44:01',	'ADMIN_USER'),
(50,	2,	'location-utilization-snapshot-number',	'LUS',	'',	10,	'23',	1,	'2022-08-09 14:00:35',	'ADMIN_USER',	'2023-06-07 13:44:01',	'ADMIN_USER'),
(51,	2,	'lpn',	'L',	'',	10,	'23',	1,	'2022-08-09 14:00:36',	'ADMIN_USER',	'2023-06-07 13:44:01',	'ADMIN_USER'),
(52,	2,	'mps-number',	'MPS',	'',	10,	'23',	1,	'2022-08-09 14:00:36',	'ADMIN_USER',	'2023-06-07 13:44:02',	'ADMIN_USER'),
(53,	2,	'mrp-number',	'MRP',	'',	10,	'23',	1,	'2022-08-09 14:00:36',	'ADMIN_USER',	'2023-06-07 13:44:03',	'ADMIN_USER'),
(54,	2,	'order-activity-number',	'OA',	'',	10,	'23',	1,	'2022-08-09 14:00:37',	'ADMIN_USER',	'2023-06-07 13:44:05',	'ADMIN_USER'),
(55,	2,	'order-activity-transaction-group-id',	'OAG',	'',	10,	'23',	1,	'2022-08-09 14:00:37',	'ADMIN_USER',	'2023-06-07 13:44:05',	'ADMIN_USER'),
(56,	2,	'order-number',	'ORDER',	'',	10,	'23',	1,	'2022-08-09 14:00:38',	'ADMIN_USER',	'2023-06-07 13:44:06',	'ADMIN_USER'),
(57,	2,	'pick-number',	'PICK',	'',	10,	'23',	1,	'2022-08-09 14:00:38',	'ADMIN_USER',	'2023-06-07 13:44:07',	'ADMIN_USER'),
(58,	2,	'production-plan',	'PRP',	'',	10,	'23',	1,	'2022-08-09 14:00:39',	'ADMIN_USER',	'2023-06-07 13:44:07',	'ADMIN_USER'),
(59,	2,	'qc-inspection-request',	'QCR',	'',	10,	'23',	1,	'2022-08-09 14:00:39',	'ADMIN_USER',	'2023-06-07 13:44:08',	'ADMIN_USER'),
(60,	2,	'receipt-number',	'RECPT',	'',	10,	'23',	1,	'2022-08-09 14:00:40',	'ADMIN_USER',	'2023-06-07 13:44:08',	'ADMIN_USER'),
(61,	2,	'receiving-lpn-number',	'R1',	'',	10,	'23',	1,	'2022-08-09 14:00:40',	'ADMIN_USER',	'2023-06-07 13:44:09',	'ADMIN_USER'),
(62,	2,	'shipment-line-number',	'SL',	'',	10,	'23',	1,	'2022-08-09 14:00:40',	'ADMIN_USER',	'2023-06-07 13:44:10',	'ADMIN_USER'),
(63,	2,	'shipment-number',	'SHIP',	'',	10,	'23',	1,	'2022-08-09 14:00:41',	'ADMIN_USER',	'2023-06-07 13:44:11',	'ADMIN_USER'),
(64,	2,	'shipping-cartonization-number',	'SCTN',	'',	10,	'23',	1,	'2022-08-09 14:00:41',	'ADMIN_USER',	'2023-06-07 13:44:12',	'ADMIN_USER'),
(65,	2,	'stop',	'STP',	'',	10,	'23',	1,	'2022-08-09 14:00:41',	'ADMIN_USER',	'2023-06-07 13:44:12',	'ADMIN_USER'),
(66,	2,	'trailer-appointment-number',	'TAP',	'',	10,	'23',	1,	'2022-08-09 14:00:42',	'ADMIN_USER',	'2023-06-07 13:44:12',	'ADMIN_USER'),
(67,	2,	'wave-number',	'WAV',	'',	10,	'23',	1,	'2022-08-09 14:00:42',	'ADMIN_USER',	'2023-06-07 13:44:13',	'ADMIN_USER'),
(68,	2,	'work-order-lpn-number',	'W1',	'',	10,	'23',	1,	'2022-08-09 14:00:43',	'ADMIN_USER',	'2023-06-07 13:44:13',	'ADMIN_USER'),
(69,	2,	'work-order-number',	'WO',	'',	10,	'23',	1,	'2022-08-09 14:00:43',	'ADMIN_USER',	'2023-06-07 13:44:13',	'ADMIN_USER'),
(70,	2,	'work-order-qc-sample-number',	'WQC',	'',	10,	'23',	1,	'2022-08-09 14:00:43',	'ADMIN_USER',	'2023-06-07 13:44:13',	'ADMIN_USER'),
(71,	2,	'work-task',	'WORK',	'',	10,	'23',	1,	'2022-08-09 14:00:43',	'ADMIN_USER',	'2023-06-07 13:44:14',	'ADMIN_USER'),
(72,	3,	'allocation-transaction-history-group-id',	'ATHG',	'',	10,	'23',	1,	'2022-08-09 14:00:43',	'ADMIN_USER',	'2023-06-07 13:44:14',	'ADMIN_USER'),
(73,	3,	'allocation-transaction-history-number',	'ATH',	'',	10,	'23',	1,	'2022-08-09 14:00:44',	'ADMIN_USER',	'2023-06-07 13:44:14',	'ADMIN_USER'),
(74,	3,	'bill-of-material',	'BOM',	'',	10,	'23',	1,	'2022-08-09 14:00:44',	'ADMIN_USER',	'2023-06-07 13:44:15',	'ADMIN_USER'),
(75,	3,	'billing-request-number',	'BR',	'',	10,	'23',	1,	'2022-08-09 14:00:44',	'ADMIN_USER',	'2023-06-07 13:44:15',	'ADMIN_USER'),
(76,	3,	'cancelled-pick-number',	'CPK',	'',	10,	'23',	1,	'2022-08-09 14:00:45',	'ADMIN_USER',	'2023-06-07 13:44:17',	'ADMIN_USER'),
(77,	3,	'cartonization-number',	'CTN',	'',	10,	'23',	1,	'2022-08-09 14:00:45',	'ADMIN_USER',	'2023-06-07 13:44:17',	'ADMIN_USER'),
(78,	3,	'csr-order-number',	'CSR',	'',	10,	'23',	1,	'2022-08-09 14:00:45',	'ADMIN_USER',	'2023-06-07 13:44:17',	'ADMIN_USER'),
(79,	3,	'cycle-count-batch-id',	'CB',	'',	10,	'23',	1,	'2022-08-09 14:00:46',	'ADMIN_USER',	'2023-06-07 13:44:18',	'ADMIN_USER'),
(80,	3,	'inventory-activity-transaction-group-id',	'INVACTGRP',	'',	10,	'23',	1,	'2022-08-09 14:00:46',	'ADMIN_USER',	'2023-06-07 13:44:18',	'ADMIN_USER'),
(81,	3,	'inventory-activity-transaction-id',	'INVACT',	'',	10,	'23',	1,	'2022-08-09 14:00:46',	'ADMIN_USER',	'2023-06-07 13:44:19',	'ADMIN_USER'),
(82,	3,	'invoice-number',	'INVOICE',	'',	10,	'23',	1,	'2022-08-09 14:00:47',	'ADMIN_USER',	'2023-06-07 13:44:19',	'ADMIN_USER'),
(83,	3,	'item-sampling-number',	'IS',	'',	10,	'23',	1,	'2022-08-09 14:00:47',	'ADMIN_USER',	'2023-06-07 13:44:20',	'ADMIN_USER'),
(84,	3,	'list-pick',	'LPICK',	'',	10,	'23',	1,	'2022-08-09 14:00:47',	'ADMIN_USER',	'2023-06-07 13:44:20',	'ADMIN_USER'),
(85,	3,	'location-utilization-snapshot-number',	'LUS',	'',	10,	'23',	1,	'2022-08-09 14:00:47',	'ADMIN_USER',	'2023-06-07 13:44:21',	'ADMIN_USER'),
(86,	3,	'lpn',	'L',	'',	10,	'23',	1,	'2022-08-09 14:00:48',	'ADMIN_USER',	'2023-06-07 13:44:21',	'ADMIN_USER'),
(87,	3,	'mps-number',	'MPS',	'',	10,	'23',	1,	'2022-08-09 14:00:48',	'ADMIN_USER',	'2023-06-07 13:44:22',	'ADMIN_USER'),
(88,	3,	'mrp-number',	'MRP',	'',	10,	'23',	1,	'2022-08-09 14:00:48',	'ADMIN_USER',	'2023-06-07 13:44:22',	'ADMIN_USER'),
(89,	3,	'order-activity-number',	'OA',	'',	10,	'23',	1,	'2022-08-09 14:00:49',	'ADMIN_USER',	'2023-06-07 13:44:23',	'ADMIN_USER'),
(90,	3,	'order-activity-transaction-group-id',	'OAG',	'',	10,	'23',	1,	'2022-08-09 14:00:49',	'ADMIN_USER',	'2023-06-07 13:44:23',	'ADMIN_USER'),
(91,	3,	'order-number',	'ORDER',	'',	10,	'23',	1,	'2022-08-09 14:00:49',	'ADMIN_USER',	'2023-06-07 13:44:23',	'ADMIN_USER'),
(92,	3,	'pick-number',	'PICK',	'',	10,	'23',	1,	'2022-08-09 14:00:49',	'ADMIN_USER',	'2023-06-07 13:44:23',	'ADMIN_USER'),
(93,	3,	'production-plan',	'PRP',	'',	10,	'23',	1,	'2022-08-09 14:00:49',	'ADMIN_USER',	'2023-06-07 13:44:24',	'ADMIN_USER'),
(94,	3,	'qc-inspection-request',	'QCR',	'',	10,	'23',	1,	'2022-08-09 14:00:50',	'ADMIN_USER',	'2023-06-07 13:44:24',	'ADMIN_USER'),
(95,	3,	'receipt-number',	'RECPT',	'',	10,	'23',	1,	'2022-08-09 14:00:50',	'ADMIN_USER',	'2023-06-07 13:44:24',	'ADMIN_USER'),
(96,	3,	'receiving-lpn-number',	'R1',	'',	10,	'23',	1,	'2022-08-09 14:00:50',	'ADMIN_USER',	'2023-06-07 13:44:24',	'ADMIN_USER'),
(97,	3,	'shipment-line-number',	'SL',	'',	10,	'23',	1,	'2022-08-09 14:00:50',	'ADMIN_USER',	'2023-06-07 13:44:25',	'ADMIN_USER'),
(98,	3,	'shipment-number',	'SHIP',	'',	10,	'23',	1,	'2022-08-09 14:00:50',	'ADMIN_USER',	'2023-06-07 13:44:25',	'ADMIN_USER'),
(99,	3,	'shipping-cartonization-number',	'SCTN',	'',	10,	'23',	1,	'2022-08-09 14:00:51',	'ADMIN_USER',	'2023-06-07 13:44:26',	'ADMIN_USER'),
(100,	3,	'stop',	'STP',	'',	10,	'23',	1,	'2022-08-09 14:00:51',	'ADMIN_USER',	'2023-06-07 13:44:26',	'ADMIN_USER'),
(101,	3,	'trailer-appointment-number',	'TAP',	'',	10,	'23',	1,	'2022-08-09 14:00:51',	'ADMIN_USER',	'2023-06-07 13:44:27',	'ADMIN_USER'),
(102,	3,	'wave-number',	'WAV',	'',	10,	'23',	1,	'2022-08-09 14:00:51',	'ADMIN_USER',	'2023-06-07 13:44:27',	'ADMIN_USER'),
(103,	3,	'work-order-lpn-number',	'W1',	'',	10,	'23',	1,	'2022-08-09 14:00:51',	'ADMIN_USER',	'2023-06-07 13:44:27',	'ADMIN_USER'),
(104,	3,	'work-order-number',	'WO',	'',	10,	'23',	1,	'2022-08-09 14:00:51',	'ADMIN_USER',	'2023-06-07 13:44:28',	'ADMIN_USER'),
(105,	3,	'work-order-qc-sample-number',	'WQC',	'',	10,	'23',	1,	'2022-08-09 14:00:52',	'ADMIN_USER',	'2023-06-07 13:44:28',	'ADMIN_USER'),
(106,	3,	'work-task',	'WORK',	'',	10,	'23',	1,	'2022-08-09 14:00:52',	'ADMIN_USER',	'2023-06-07 13:44:28',	'ADMIN_USER'),
(107,	2,	'inventory-snapshot-batch-number',	'INVSNAP',	'',	10,	'8',	1,	'2023-01-10 10:18:00',	'ADMIN_USER',	'2023-06-07 13:44:00',	'ADMIN_USER'),
(108,	3,	'inventory-snapshot-batch-number',	'INVSNAP',	'',	10,	'8',	1,	'2023-01-10 10:18:07',	'ADMIN_USER',	'2023-06-07 13:44:19',	'ADMIN_USER'),
(109,	1,	'bulk-pick-number',	'BPCK',	'',	10,	'7',	0,	'2023-05-17 08:34:21',	'XXXX',	'2023-07-21 23:12:59',	'GZHANG');

DROP TABLE IF EXISTS `tractor`;
CREATE TABLE `tractor` (
  `tractor_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `license_plate_number` varchar(50) DEFAULT NULL,
  `number` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `tractor_appointment_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tractor_id`),
  KEY `tractor_appointment_id` (`tractor_appointment_id`),
  CONSTRAINT `tractor_ibfk_1` FOREIGN KEY (`tractor_appointment_id`) REFERENCES `tractor_appointment` (`tractor_appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `tractor_appointment`;
CREATE TABLE `tractor_appointment` (
  `tractor_appointment_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `driver_first_name` varchar(50) DEFAULT NULL,
  `driver_last_name` varchar(50) DEFAULT NULL,
  `driver_phone` varchar(50) DEFAULT NULL,
  `number` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `tractor_id` bigint NOT NULL,
  `carrier_id` bigint DEFAULT NULL,
  `carrier_service_level_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tractor_appointment_id`),
  KEY `carrier_id` (`carrier_id`),
  KEY `carrier_service_level_id` (`carrier_service_level_id`),
  CONSTRAINT `tractor_appointment_ibfk_1` FOREIGN KEY (`carrier_id`) REFERENCES `carrier` (`carrier_id`),
  CONSTRAINT `tractor_appointment_ibfk_2` FOREIGN KEY (`carrier_service_level_id`) REFERENCES `carrier_service_level` (`carrier_service_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `tractor_appointment_trailer`;
CREATE TABLE `tractor_appointment_trailer` (
  `tractor_appointment_id` bigint NOT NULL,
  `trailer_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  KEY `tractor_appointment_id` (`tractor_appointment_id`),
  KEY `trailer_id` (`trailer_id`),
  CONSTRAINT `tractor_appointment_trailer_ibfk_1` FOREIGN KEY (`tractor_appointment_id`) REFERENCES `tractor_appointment` (`tractor_appointment_id`),
  CONSTRAINT `tractor_appointment_trailer_ibfk_2` FOREIGN KEY (`trailer_id`) REFERENCES `trailer` (`trailer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `tractor_attached_trailer`;
CREATE TABLE `tractor_attached_trailer` (
  `tractor_id` bigint NOT NULL,
  `trailer_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  KEY `tractor_id` (`tractor_id`),
  KEY `trailer_id` (`trailer_id`),
  CONSTRAINT `tractor_attached_trailer_ibfk_1` FOREIGN KEY (`tractor_id`) REFERENCES `tractor` (`tractor_id`),
  CONSTRAINT `tractor_attached_trailer_ibfk_2` FOREIGN KEY (`trailer_id`) REFERENCES `trailer` (`trailer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `tractor_schedule`;
CREATE TABLE `tractor_schedule` (
  `tractor_schedule_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `tractor_id` bigint NOT NULL,
  `check_in_time` datetime DEFAULT NULL,
  `dispatch_time` datetime DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `comment` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tractor_schedule_id`),
  KEY `tractor_id` (`tractor_id`),
  CONSTRAINT `tractor_schedule_ibfk_1` FOREIGN KEY (`tractor_id`) REFERENCES `tractor` (`tractor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `trailer`;
CREATE TABLE `trailer` (
  `trailer_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `number` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `trailer_appointment_id` bigint DEFAULT NULL,
  `size` double DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`trailer_id`),
  KEY `trailer_appointment_id` (`trailer_appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `trailer_appointment`;
CREATE TABLE `trailer_appointment` (
  `trailer_appointment_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `number` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `tractor_id` bigint DEFAULT NULL,
  `trailer_id` bigint DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `completed_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`trailer_appointment_id`),
  KEY `trailer_id` (`trailer_id`),
  KEY `tractor_id` (`tractor_id`),
  CONSTRAINT `trailer_appointment_ibfk_1` FOREIGN KEY (`trailer_id`) REFERENCES `trailer` (`trailer_id`),
  CONSTRAINT `trailer_appointment_ibfk_2` FOREIGN KEY (`tractor_id`) REFERENCES `tractor` (`tractor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `trailer_template`;
CREATE TABLE `trailer_template` (
  `trailer_template_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `driver_first_name` varchar(50) NOT NULL,
  `driver_last_name` varchar(50) NOT NULL,
  `driver_phone` varchar(50) NOT NULL,
  `license_plate_number` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `size` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`trailer_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit` (
  `unit_id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ratio` double DEFAULT NULL,
  `base_unit_flag` tinyint(1) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `unit` (`unit_id`, `type`, `name`, `description`, `ratio`, `base_unit_flag`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	'LENGTH',	'inch',	'inch',	1,	1,	'2023-05-17 09:02:48',	'CWMS-USER',	'2023-06-21 10:24:22',	'CWMS-USER'),
(2,	'LENGTH',	'foot',	'foot',	12,	0,	'2023-05-17 09:02:51',	'CWMS-USER',	'2023-06-21 10:24:22',	'CWMS-USER'),
(3,	'LENGTH',	'cm',	'centimeter',	0.394,	0,	'2023-05-17 09:02:51',	'CWMS-USER',	'2023-06-21 10:24:22',	'CWMS-USER'),
(4,	'LENGTH',	'm',	'meter',	39.4,	0,	'2023-05-17 09:02:52',	'CWMS-USER',	'2023-06-21 10:24:22',	'CWMS-USER'),
(5,	'WEIGHT',	'lb',	'pound',	1,	1,	'2023-05-17 09:02:52',	'CWMS-USER',	'2023-06-21 10:24:23',	'CWMS-USER'),
(6,	'WEIGHT',	'g',	'gram',	0.002205,	0,	'2023-05-17 09:02:53',	'CWMS-USER',	'2023-06-21 10:24:23',	'CWMS-USER'),
(7,	'WEIGHT',	'kg',	'kilogram',	2.205,	0,	'2023-05-17 09:02:53',	'CWMS-USER',	'2023-06-21 10:24:24',	'CWMS-USER'),
(8,	'WEIGHT',	'oz',	'ounce',	0.0625,	0,	'2023-05-17 09:02:53',	'CWMS-USER',	'2023-06-21 10:24:24',	'CWMS-USER'),
(9,	'VOLUME',	'cube_inch',	'cube inch',	0.000579,	0,	'2023-05-17 09:02:53',	'CWMS-USER',	'2023-06-21 10:24:25',	'CWMS-USER'),
(10,	'VOLUME',	'cube_foot',	'cube foot',	1,	1,	'2023-05-17 09:02:53',	'CWMS-USER',	'2023-06-21 10:24:25',	'CWMS-USER'),
(11,	'VOLUME',	'cube_cm',	'cube centimeter',	0.0000353,	0,	'2023-05-17 09:02:54',	'CWMS-USER',	'2023-06-21 10:24:25',	'CWMS-USER'),
(12,	'VOLUME',	'cube_m',	'cube meter',	34.96,	0,	'2023-05-17 09:02:55',	'CWMS-USER',	'2023-06-21 10:24:25',	'CWMS-USER');

DROP TABLE IF EXISTS `unit_of_measure`;
CREATE TABLE `unit_of_measure` (
  `unit_of_measure_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `company_id` bigint NOT NULL,
  PRIMARY KEY (`unit_of_measure_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `unit_of_measure` (`unit_of_measure_id`, `warehouse_id`, `name`, `description`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `company_id`) VALUES
(1,	NULL,	'PCS',	'Piece',	NULL,	NULL,	NULL,	NULL,	1),
(2,	NULL,	'LBS',	'Pound',	NULL,	NULL,	NULL,	NULL,	1),
(3,	NULL,	'CS',	'Case',	NULL,	NULL,	NULL,	NULL,	1),
(4,	NULL,	'PL',	'Pallet',	NULL,	NULL,	NULL,	NULL,	1);

DROP TABLE IF EXISTS `user_auth`;
CREATE TABLE `user_auth` (
  `user_auth_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(100) DEFAULT NULL,
  `current_token` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `user_auth` (`user_auth_id`, `company_id`, `username`, `password`, `enabled`, `locked`, `email`, `current_token`) VALUES
(1,	-1,	'ADMIN',	'ADMIN',	1,	0,	'xxxxxxxx',	'');

DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `company_id` bigint NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `change_password_at_next_logon` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `is_system_admin` tinyint(1) NOT NULL DEFAULT '0',
  `last_login_company_id` bigint DEFAULT NULL,
  `last_login_warehouse_id` bigint DEFAULT NULL,
  `last_login_token` varchar(100) DEFAULT NULL,
  `department_id` bigint DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `on_board_time` datetime DEFAULT NULL,
  `worker_type` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_department_id` (`department_id`),
  CONSTRAINT `fk_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `user_info` (`user_id`, `username`, `company_id`, `first_name`, `last_name`, `is_admin`, `change_password_at_next_logon`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `is_system_admin`, `last_login_company_id`, `last_login_warehouse_id`, `last_login_token`, `department_id`, `position`, `on_board_time`, `worker_type`, `email`, `type`) VALUES
(1,	'ADMIN',	-1,	'ADMIN',	'ADMIN',	1,	0,	'2023-07-12 17:01:32',	'CWMS-USER',	'2023-07-21 20:37:02',	'CWMS-USER',	1,	1,	1,	'-Qewniz1W6w',	NULL,	NULL,	NULL,	NULL,	'xxxxxxxx',	NULL);

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `role_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  KEY `role_id` (`role_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `velocity`;
CREATE TABLE `velocity` (
  `velocity_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(500) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`velocity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `walmart_shipping_carton_label`;
CREATE TABLE `walmart_shipping_carton_label` (
  `walmart_shipping_carton_label_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `partner_id` varchar(100) NOT NULL,
  `doc_type` varchar(100) NOT NULL,
  `po_number` varchar(100) NOT NULL,
  `po_date` varchar(100) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `dept` varchar(100) DEFAULT NULL,
  `vendor_id` varchar(100) DEFAULT NULL,
  `ship_to` varchar(200) DEFAULT NULL,
  `address_1` varchar(300) DEFAULT NULL,
  `city_state_zip` varchar(100) DEFAULT NULL,
  `DC` varchar(100) DEFAULT NULL,
  `GLN` varchar(100) DEFAULT NULL,
  `item_number` varchar(100) DEFAULT NULL,
  `WMIT` varchar(100) DEFAULT NULL,
  `UPC` varchar(100) DEFAULT NULL,
  `UK` varchar(100) DEFAULT NULL,
  `GTIN14` varchar(100) DEFAULT NULL,
  `weight` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `order_quantity` varchar(100) DEFAULT NULL,
  `UOM` varchar(100) DEFAULT NULL,
  `piece_carton` varchar(100) DEFAULT NULL,
  `carton_quantity` varchar(100) DEFAULT NULL,
  `SSCC18` varchar(100) DEFAULT NULL,
  `ship_date` varchar(100) DEFAULT NULL,
  `eta_date` varchar(100) DEFAULT NULL,
  `SCAC` varchar(100) DEFAULT NULL,
  `transportation_method` varchar(100) DEFAULT NULL,
  `BOL` varchar(100) DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `invoice_number` varchar(100) DEFAULT NULL,
  `FOB` varchar(100) DEFAULT NULL,
  `load_id` varchar(100) DEFAULT NULL,
  `appointment_number` varchar(100) DEFAULT NULL,
  `carrier_number` varchar(100) DEFAULT NULL,
  `equipment_type` varchar(100) DEFAULT NULL,
  `equipment_initial` varchar(100) DEFAULT NULL,
  `equipment_number` varchar(100) DEFAULT NULL,
  `seal_number` varchar(100) DEFAULT NULL,
  `FOB_Mira` varchar(100) DEFAULT NULL,
  `LOMA_COLTON_FAYETEVILLE` varchar(100) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`walmart_shipping_carton_label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse` (
  `warehouse_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `size` double NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_county` varchar(100) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_district` varchar(100) DEFAULT NULL,
  `address_line1` varchar(300) NOT NULL,
  `address_line2` varchar(300) DEFAULT NULL,
  `address_postcode` varchar(10) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `contactor_firstname` varchar(100) DEFAULT NULL,
  `contactor_lastname` varchar(100) DEFAULT NULL,
  `address_phone` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `warehouse_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `warehouse` (`warehouse_id`, `company_id`, `name`, `size`, `address_country`, `address_state`, `address_county`, `address_city`, `address_district`, `address_line1`, `address_line2`, `address_postcode`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `contactor_firstname`, `contactor_lastname`, `address_phone`) VALUES
(1,	1,	'WM01',	50000,	'U.S',	'CA',	'LA',	'LA',	'',	'XXXX MAIN ST',	'',	'90001',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `warehouse_access`;
CREATE TABLE `warehouse_access` (
  `warehouse_access_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`warehouse_access_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `warehouse_access_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `warehouse_configuration`;
CREATE TABLE `warehouse_configuration` (
  `warehouse_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `three_party_logistics_flag` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `list_pick_enabled_flag` tinyint(1) NOT NULL DEFAULT '0',
  `printing_strategy` varchar(50) DEFAULT NULL,
  `new_lpn_print_label_at_receiving_flag` tinyint(1) NOT NULL DEFAULT '0',
  `new_lpn_print_label_at_producing_flag` tinyint(1) NOT NULL DEFAULT '0',
  `new_lpn_print_label_at_adjustment_flag` tinyint(1) NOT NULL DEFAULT '0',
  `reuse_lpn_after_removed` tinyint(1) NOT NULL DEFAULT '0',
  `reuse_lpn_after_shipped` tinyint(1) NOT NULL DEFAULT '0',
  `billing_request_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `working_on_sunday` tinyint(1) NOT NULL DEFAULT '0',
  `working_on_monday` tinyint(1) NOT NULL DEFAULT '0',
  `working_on_tuesday` tinyint(1) NOT NULL DEFAULT '0',
  `working_on_wednesday` tinyint(1) NOT NULL DEFAULT '0',
  `working_on_thursday` tinyint(1) NOT NULL DEFAULT '0',
  `working_on_friday` tinyint(1) NOT NULL DEFAULT '0',
  `working_on_saturday` tinyint(1) NOT NULL DEFAULT '0',
  `time_zone` varchar(50) DEFAULT NULL,
  `location_utilization_snapshot_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `inventory_aging_snapshot_enabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`warehouse_configuration_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `warehouse_configuration_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `warehouse_configuration` (`warehouse_configuration_id`, `warehouse_id`, `three_party_logistics_flag`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`, `list_pick_enabled_flag`, `printing_strategy`, `new_lpn_print_label_at_receiving_flag`, `new_lpn_print_label_at_producing_flag`, `new_lpn_print_label_at_adjustment_flag`, `reuse_lpn_after_removed`, `reuse_lpn_after_shipped`, `billing_request_enabled`, `working_on_sunday`, `working_on_monday`, `working_on_tuesday`, `working_on_wednesday`, `working_on_thursday`, `working_on_friday`, `working_on_saturday`, `time_zone`, `location_utilization_snapshot_enabled`, `inventory_aging_snapshot_enabled`) VALUES
(1,	1,	0,	NULL,	NULL,	'2022-12-29 14:12:36',	'XXXX',	0,	'SERVER_PRINTER',	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	NULL,	0,	0);

DROP TABLE IF EXISTS `warehouse_holiday`;
CREATE TABLE `warehouse_holiday` (
  `warehouse_holiday_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `holiday_date` date NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`warehouse_holiday_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `warehouse_holiday_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `wave`;
CREATE TABLE `wave` (
  `wave_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `status` varchar(20) NOT NULL,
  `number` varchar(100) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`wave_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `web_client_tab_display_configuration`;
CREATE TABLE `web_client_tab_display_configuration` (
  `web_client_tab_display_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `display_flag` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`web_client_tab_display_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `web_client_tab_display_configuration` (`web_client_tab_display_configuration_id`, `name`, `description`, `company_id`, `warehouse_id`, `user_id`, `display_flag`, `created_time`, `created_by`, `last_modified_time`, `last_modified_by`) VALUES
(1,	'work-order.work-order.work-order.line',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(2,	'work-order.work-order.work-order.by-product',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(3,	'work-order.work-order.production-line',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(4,	'work-order.work-order.work-order.kpi',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(5,	'work-order.work-order.work-order.kpi-transaction',	'work order line',	1,	NULL,	NULL,	0,	NULL,	NULL,	NULL,	NULL),
(6,	'work-order.work-order.work-order-instruction',	'work order line',	1,	NULL,	NULL,	0,	NULL,	NULL,	NULL,	NULL),
(7,	'work-order.work-order.work-order.assigned-users',	'work order line',	1,	NULL,	NULL,	0,	NULL,	NULL,	NULL,	NULL),
(8,	'work-order.work-order.pick',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(9,	'work-order.work-order.short-allocation',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(10,	'work-order.work-order.work-order.delivered-inventory',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(11,	'work-order.work-order.work-order.produced-inventory',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(12,	'work-order.work-order.work-order.by-product.produced',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL),
(13,	'work-order.work-order.work-order.returned-inventory',	'work order line',	1,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `web_message_alert`;
CREATE TABLE `web_message_alert` (
  `web_message_alert_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `alert_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `read_flag` tinyint(1) NOT NULL DEFAULT '0',
  `read_date` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`web_message_alert_id`),
  KEY `alert_id` (`alert_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `web_message_alert_ibfk_1` FOREIGN KEY (`alert_id`) REFERENCES `alert` (`alert_id`),
  CONSTRAINT `web_message_alert_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order`;
CREATE TABLE `work_order` (
  `work_order_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(20) NOT NULL,
  `bill_of_material_id` bigint DEFAULT NULL,
  `production_plan_line_id` bigint DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  `po_number` varchar(100) DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `expected_quantity` bigint NOT NULL,
  `produced_quantity` bigint NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `material_consume_timing` varchar(25) DEFAULT NULL,
  `consume_by_bom_only` tinyint(1) DEFAULT NULL,
  `consume_by_bom_id` bigint DEFAULT NULL,
  `qc_quantity` bigint DEFAULT NULL,
  `qc_percentage` double DEFAULT NULL,
  `qc_quantity_requested` bigint DEFAULT NULL,
  `qc_quantity_completed` bigint DEFAULT NULL,
  `bto_outbound_order_id` bigint DEFAULT NULL,
  `bto_customer_id` bigint DEFAULT NULL,
  `short_allocation_id` bigint DEFAULT NULL,
  PRIMARY KEY (`work_order_id`),
  KEY `bill_of_material_id` (`bill_of_material_id`),
  KEY `production_plan_line_id` (`production_plan_line_id`),
  CONSTRAINT `work_order_ibfk_1` FOREIGN KEY (`bill_of_material_id`) REFERENCES `bill_of_material` (`bill_of_material_id`),
  CONSTRAINT `work_order_ibfk_2` FOREIGN KEY (`production_plan_line_id`) REFERENCES `production_plan_line` (`production_plan_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_assignment`;
CREATE TABLE `work_order_assignment` (
  `work_order_assignment_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `work_order_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_assignment_id`),
  KEY `work_order_id` (`work_order_id`),
  CONSTRAINT `work_order_assignment_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_by_product`;
CREATE TABLE `work_order_by_product` (
  `work_order_by_product_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `expected_quantity` bigint NOT NULL,
  `produced_quantity` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_by_product_id`),
  KEY `work_order_id` (`work_order_id`),
  CONSTRAINT `work_order_by_product_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_by_product_produce_transaction`;
CREATE TABLE `work_order_by_product_produce_transaction` (
  `work_order_by_product_produce_transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_complete_transaction_id` bigint DEFAULT NULL,
  `work_order_produce_transaction_id` bigint DEFAULT NULL,
  `work_order_by_product_id` bigint NOT NULL,
  `lpn` varchar(100) NOT NULL,
  `quantity` bigint DEFAULT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `item_package_type_id` bigint DEFAULT NULL,
  `location_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_by_product_produce_transaction_id`),
  KEY `work_order_produce_transaction_id` (`work_order_produce_transaction_id`),
  KEY `work_order_complete_transaction_id` (`work_order_complete_transaction_id`),
  KEY `work_order_by_product_id` (`work_order_by_product_id`),
  CONSTRAINT `work_order_by_product_produce_transaction_ibfk_1` FOREIGN KEY (`work_order_produce_transaction_id`) REFERENCES `work_order_produce_transaction` (`work_order_produce_transaction_id`),
  CONSTRAINT `work_order_by_product_produce_transaction_ibfk_2` FOREIGN KEY (`work_order_complete_transaction_id`) REFERENCES `work_order_complete_transaction` (`work_order_complete_transaction_id`),
  CONSTRAINT `work_order_by_product_produce_transaction_ibfk_3` FOREIGN KEY (`work_order_by_product_id`) REFERENCES `work_order_by_product` (`work_order_by_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_complete_transaction`;
CREATE TABLE `work_order_complete_transaction` (
  `work_order_complete_transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_complete_transaction_id`),
  KEY `work_order_id` (`work_order_id`),
  CONSTRAINT `work_order_complete_transaction_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_configuration`;
CREATE TABLE `work_order_configuration` (
  `work_order_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint DEFAULT NULL,
  `warehouse_id` bigint DEFAULT NULL,
  `material_consume_timing` varchar(50) NOT NULL,
  `over_consume_is_allowed` tinyint(1) NOT NULL,
  `over_produce_is_allowed` tinyint(1) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_instruction`;
CREATE TABLE `work_order_instruction` (
  `work_order_instruction_id` bigint NOT NULL AUTO_INCREMENT,
  `sequence` int NOT NULL,
  `work_order_id` bigint NOT NULL,
  `instruction` varchar(500) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_instruction_id`),
  KEY `work_order_id` (`work_order_id`),
  CONSTRAINT `work_order_instruction_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_instruction_template`;
CREATE TABLE `work_order_instruction_template` (
  `work_order_instruction_template_id` bigint NOT NULL AUTO_INCREMENT,
  `sequence` int NOT NULL,
  `bill_of_material_id` bigint NOT NULL,
  `instruction` varchar(500) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_instruction_template_id`),
  KEY `bill_of_material_id` (`bill_of_material_id`),
  CONSTRAINT `work_order_instruction_template_ibfk_1` FOREIGN KEY (`bill_of_material_id`) REFERENCES `bill_of_material` (`bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_kpi`;
CREATE TABLE `work_order_kpi` (
  `work_order_kpi_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL,
  `production_line_id` bigint DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `working_team_name` varchar(50) DEFAULT NULL,
  `working_team_member_count` int DEFAULT NULL,
  `kpi_measurement` varchar(20) NOT NULL,
  `amount` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_kpi_id`),
  KEY `work_order_id` (`work_order_id`),
  KEY `production_line_id` (`production_line_id`),
  CONSTRAINT `work_order_kpi_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`),
  CONSTRAINT `work_order_kpi_ibfk_2` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_kpi_transaction`;
CREATE TABLE `work_order_kpi_transaction` (
  `work_order_kpi_transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL,
  `work_order_complete_transaction_id` bigint DEFAULT NULL,
  `work_order_produce_transaction_id` bigint DEFAULT NULL,
  `work_order_kpi_id` bigint DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `working_team_name` varchar(50) DEFAULT NULL,
  `kpi_measurement` varchar(20) NOT NULL,
  `amount` double NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_kpi_transaction_id`),
  KEY `work_order_kpi_id` (`work_order_kpi_id`),
  KEY `work_order_produce_transaction_id` (`work_order_produce_transaction_id`),
  KEY `work_order_complete_transaction_id` (`work_order_complete_transaction_id`),
  KEY `work_order_id` (`work_order_id`),
  CONSTRAINT `work_order_kpi_transaction_ibfk_1` FOREIGN KEY (`work_order_kpi_id`) REFERENCES `work_order_kpi` (`work_order_kpi_id`),
  CONSTRAINT `work_order_kpi_transaction_ibfk_2` FOREIGN KEY (`work_order_produce_transaction_id`) REFERENCES `work_order_produce_transaction` (`work_order_produce_transaction_id`),
  CONSTRAINT `work_order_kpi_transaction_ibfk_3` FOREIGN KEY (`work_order_complete_transaction_id`) REFERENCES `work_order_complete_transaction` (`work_order_complete_transaction_id`),
  CONSTRAINT `work_order_kpi_transaction_ibfk_4` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_labor`;
CREATE TABLE `work_order_labor` (
  `work_order_labor_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `production_line_id` bigint NOT NULL,
  `username` varchar(50) NOT NULL,
  `last_check_in_time` datetime DEFAULT NULL,
  `last_check_out_time` datetime DEFAULT NULL,
  `labor_status` varchar(20) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_labor_id`),
  KEY `production_line_id` (`production_line_id`),
  CONSTRAINT `work_order_labor_ibfk_1` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_labor_activity_history`;
CREATE TABLE `work_order_labor_activity_history` (
  `work_order_labor_activity_history_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `work_order_labor_id` bigint NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `original_value` varchar(100) DEFAULT NULL,
  `new_value` varchar(100) DEFAULT NULL,
  `activity_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_labor_activity_history_id`),
  KEY `work_order_labor_id` (`work_order_labor_id`),
  CONSTRAINT `work_order_labor_activity_history_ibfk_1` FOREIGN KEY (`work_order_labor_id`) REFERENCES `work_order_labor` (`work_order_labor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_line`;
CREATE TABLE `work_order_line` (
  `work_order_line_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(20) NOT NULL,
  `work_order_id` bigint NOT NULL,
  `item_id` bigint NOT NULL,
  `expected_quantity` bigint NOT NULL,
  `open_quantity` bigint NOT NULL,
  `inprocess_quantity` bigint NOT NULL,
  `delivered_quantity` bigint NOT NULL,
  `consumed_quantity` bigint NOT NULL,
  `scrapped_quantity` bigint NOT NULL,
  `returned_quantity` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `allocation_strategy_type` varchar(25) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `material_work_order_id` bigint DEFAULT NULL,
  `spare_part_quantity` bigint DEFAULT NULL,
  PRIMARY KEY (`work_order_line_id`),
  KEY `work_order_id` (`work_order_id`),
  CONSTRAINT `work_order_line_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_line_complete_transaction`;
CREATE TABLE `work_order_line_complete_transaction` (
  `work_order_line_complete_transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_complete_transaction_id` bigint NOT NULL,
  `work_order_line_id` bigint NOT NULL,
  `adjusted_consumed_quantity` bigint DEFAULT NULL,
  `scrapped_quantity` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_line_complete_transaction_id`),
  KEY `work_order_complete_transaction_id` (`work_order_complete_transaction_id`),
  KEY `work_order_line_id` (`work_order_line_id`),
  CONSTRAINT `work_order_line_complete_transaction_ibfk_1` FOREIGN KEY (`work_order_complete_transaction_id`) REFERENCES `work_order_complete_transaction` (`work_order_complete_transaction_id`),
  CONSTRAINT `work_order_line_complete_transaction_ibfk_2` FOREIGN KEY (`work_order_line_id`) REFERENCES `work_order_line` (`work_order_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_line_consume_lpn_transaction`;
CREATE TABLE `work_order_line_consume_lpn_transaction` (
  `work_order_line_consume_lpn_transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_line_consume_transaction_id` bigint NOT NULL,
  `lpn` varchar(100) DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `consumed_quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_line_consume_lpn_transaction_id`),
  KEY `work_order_line_consume_transaction_id` (`work_order_line_consume_transaction_id`),
  CONSTRAINT `work_order_line_consume_lpn_transaction_ibfk_1` FOREIGN KEY (`work_order_line_consume_transaction_id`) REFERENCES `work_order_line_consume_transaction` (`work_order_line_consume_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_line_consume_transaction`;
CREATE TABLE `work_order_line_consume_transaction` (
  `work_order_line_consume_transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_produce_transaction_id` bigint NOT NULL,
  `work_order_line_id` bigint NOT NULL,
  `consumed_quantity` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `consume_from_work_order_id` bigint DEFAULT NULL,
  `consume_from_work_order_production_line_id` bigint DEFAULT NULL,
  `consume_from_work_order_quantity` bigint DEFAULT NULL,
  PRIMARY KEY (`work_order_line_consume_transaction_id`),
  KEY `work_order_produce_transaction_id` (`work_order_produce_transaction_id`),
  KEY `work_order_line_id` (`work_order_line_id`),
  KEY `consume_from_work_order_id` (`consume_from_work_order_id`),
  KEY `consume_from_work_order_production_line_id` (`consume_from_work_order_production_line_id`),
  CONSTRAINT `work_order_line_consume_transaction_ibfk_1` FOREIGN KEY (`work_order_produce_transaction_id`) REFERENCES `work_order_produce_transaction` (`work_order_produce_transaction_id`),
  CONSTRAINT `work_order_line_consume_transaction_ibfk_2` FOREIGN KEY (`work_order_line_id`) REFERENCES `work_order_line` (`work_order_line_id`),
  CONSTRAINT `work_order_line_consume_transaction_ibfk_3` FOREIGN KEY (`consume_from_work_order_id`) REFERENCES `work_order` (`work_order_id`),
  CONSTRAINT `work_order_line_consume_transaction_ibfk_4` FOREIGN KEY (`consume_from_work_order_production_line_id`) REFERENCES `production_line` (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_line_spare_part`;
CREATE TABLE `work_order_line_spare_part` (
  `work_order_line_spare_part_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_line_id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `quantity` bigint DEFAULT NULL,
  `inprocess_quantity` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_line_spare_part_id`),
  KEY `work_order_line_id` (`work_order_line_id`),
  CONSTRAINT `work_order_line_spare_part_ibfk_1` FOREIGN KEY (`work_order_line_id`) REFERENCES `work_order_line` (`work_order_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_line_spare_part_detail`;
CREATE TABLE `work_order_line_spare_part_detail` (
  `work_order_line_spare_part_detail_id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` bigint DEFAULT NULL,
  `item_id` bigint NOT NULL,
  `inventory_status_id` bigint NOT NULL,
  `work_order_line_spare_part_id` bigint NOT NULL,
  `quantity` bigint DEFAULT NULL,
  `open_quantity` bigint DEFAULT NULL,
  `inprocess_quantity` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_line_spare_part_detail_id`),
  KEY `work_order_line_spare_part_id` (`work_order_line_spare_part_id`),
  CONSTRAINT `work_order_line_spare_part_detail_ibfk_1` FOREIGN KEY (`work_order_line_spare_part_id`) REFERENCES `work_order_line_spare_part` (`work_order_line_spare_part_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_produce_transaction`;
CREATE TABLE `work_order_produce_transaction` (
  `work_order_produce_transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_id` bigint NOT NULL,
  `consume_by_bom_quantity` tinyint(1) NOT NULL DEFAULT '1',
  `production_line_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `consume_by_bom_id` bigint DEFAULT NULL,
  PRIMARY KEY (`work_order_produce_transaction_id`),
  KEY `work_order_id` (`work_order_id`),
  KEY `production_line_id` (`production_line_id`),
  KEY `consume_by_bom_id` (`consume_by_bom_id`),
  CONSTRAINT `work_order_produce_transaction_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`),
  CONSTRAINT `work_order_produce_transaction_ibfk_2` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`),
  CONSTRAINT `work_order_produce_transaction_ibfk_3` FOREIGN KEY (`consume_by_bom_id`) REFERENCES `bill_of_material` (`bill_of_material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_produced_inventory`;
CREATE TABLE `work_order_produced_inventory` (
  `work_order_produced_inventory_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_produce_transaction_id` bigint NOT NULL,
  `lpn` varchar(100) NOT NULL,
  `quantity` bigint DEFAULT NULL,
  `inventory_status_id` bigint DEFAULT NULL,
  `item_package_type_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_produced_inventory_id`),
  KEY `work_order_produce_transaction_id` (`work_order_produce_transaction_id`),
  CONSTRAINT `work_order_produced_inventory_ibfk_1` FOREIGN KEY (`work_order_produce_transaction_id`) REFERENCES `work_order_produce_transaction` (`work_order_produce_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_qc_result`;
CREATE TABLE `work_order_qc_result` (
  `work_order_qc_result_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(50) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `work_order_qc_sample_id` bigint NOT NULL,
  `qc_inspection_result` varchar(20) DEFAULT NULL,
  `qc_username` varchar(200) DEFAULT NULL,
  `qc_rf_code` varchar(200) DEFAULT NULL,
  `qc_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `qc_quantity` int DEFAULT NULL,
  PRIMARY KEY (`work_order_qc_result_id`),
  KEY `work_order_qc_sample_id` (`work_order_qc_sample_id`),
  CONSTRAINT `work_order_qc_result_ibfk_1` FOREIGN KEY (`work_order_qc_sample_id`) REFERENCES `work_order_qc_sample` (`work_order_qc_sample_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_qc_rule_configuration`;
CREATE TABLE `work_order_qc_rule_configuration` (
  `work_order_qc_rule_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint DEFAULT NULL,
  `production_line_id` bigint DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `qc_quantity` bigint DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `item_family_id` bigint DEFAULT NULL,
  `item_id` bigint DEFAULT NULL,
  `outbound_order_id` bigint DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  `qc_quantity_per_work_order` bigint DEFAULT NULL,
  `qc_percentage_per_work_order` double DEFAULT NULL,
  `from_inventory_status_id` bigint DEFAULT NULL,
  `to_inventory_status_id` bigint DEFAULT NULL,
  `inventory_lock_id` bigint DEFAULT NULL,
  `future_inventory_lock_id` bigint DEFAULT NULL,
  PRIMARY KEY (`work_order_qc_rule_configuration_id`),
  KEY `work_order_id` (`work_order_id`),
  KEY `production_line_id` (`production_line_id`),
  CONSTRAINT `work_order_qc_rule_configuration_ibfk_1` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`),
  CONSTRAINT `work_order_qc_rule_configuration_ibfk_2` FOREIGN KEY (`production_line_id`) REFERENCES `production_line` (`production_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_qc_rule_configuration_rule`;
CREATE TABLE `work_order_qc_rule_configuration_rule` (
  `work_order_qc_rule_configuration_rule_id` bigint NOT NULL AUTO_INCREMENT,
  `qc_rule_id` bigint NOT NULL,
  `work_order_qc_rule_configuration_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_qc_rule_configuration_rule_id`),
  KEY `work_order_qc_rule_configuration_id` (`work_order_qc_rule_configuration_id`),
  CONSTRAINT `work_order_qc_rule_configuration_rule_ibfk_1` FOREIGN KEY (`work_order_qc_rule_configuration_id`) REFERENCES `work_order_qc_rule_configuration` (`work_order_qc_rule_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_qc_sample`;
CREATE TABLE `work_order_qc_sample` (
  `work_order_qc_sample_id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(50) NOT NULL,
  `warehouse_id` bigint NOT NULL,
  `production_line_assignment_id` bigint NOT NULL,
  `image_urls` varchar(2000) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `work_order_id` bigint DEFAULT NULL,
  `production_line_id` bigint DEFAULT NULL,
  PRIMARY KEY (`work_order_qc_sample_id`),
  KEY `production_line_assignment_id` (`production_line_assignment_id`),
  CONSTRAINT `work_order_qc_sample_ibfk_1` FOREIGN KEY (`production_line_assignment_id`) REFERENCES `production_line_assignment` (`production_line_assignment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_order_reversed_production_inventory`;
CREATE TABLE `work_order_reversed_production_inventory` (
  `work_order_reversed_production_inventory_id` bigint NOT NULL AUTO_INCREMENT,
  `work_order_produce_transaction_id` bigint NOT NULL,
  `lpn` varchar(50) NOT NULL,
  `quantity` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_order_reversed_production_inventory_id`),
  KEY `work_order_produce_transaction_id` (`work_order_produce_transaction_id`),
  CONSTRAINT `work_order_reversed_production_inventory_ibfk_1` FOREIGN KEY (`work_order_produce_transaction_id`) REFERENCES `work_order_produce_transaction` (`work_order_produce_transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_task`;
CREATE TABLE `work_task` (
  `work_task_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `number` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `priority` int DEFAULT NULL,
  `skip_count` int NOT NULL DEFAULT '0',
  `source_location_id` bigint DEFAULT NULL,
  `destination_location_id` bigint DEFAULT NULL,
  `reference_number` varchar(100) NOT NULL,
  `operation_type_id` bigint DEFAULT NULL,
  `assigned_user_id` bigint DEFAULT NULL,
  `assigned_role_id` bigint DEFAULT NULL,
  `assigned_working_team_id` bigint DEFAULT NULL,
  `current_user_id` bigint DEFAULT NULL,
  `complete_user_id` bigint DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `complete_time` datetime DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_task_id`),
  KEY `operation_type_id` (`operation_type_id`),
  KEY `assigned_user_id` (`assigned_user_id`),
  KEY `assigned_role_id` (`assigned_role_id`),
  KEY `assigned_working_team_id` (`assigned_working_team_id`),
  KEY `current_user_id` (`current_user_id`),
  KEY `complete_user_id` (`complete_user_id`),
  CONSTRAINT `work_task_ibfk_1` FOREIGN KEY (`operation_type_id`) REFERENCES `operation_type` (`operation_type_id`),
  CONSTRAINT `work_task_ibfk_2` FOREIGN KEY (`assigned_user_id`) REFERENCES `user_info` (`user_id`),
  CONSTRAINT `work_task_ibfk_3` FOREIGN KEY (`assigned_role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `work_task_ibfk_4` FOREIGN KEY (`assigned_working_team_id`) REFERENCES `working_team` (`working_team_id`),
  CONSTRAINT `work_task_ibfk_5` FOREIGN KEY (`current_user_id`) REFERENCES `user_info` (`user_id`),
  CONSTRAINT `work_task_ibfk_6` FOREIGN KEY (`complete_user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `work_task_configuration`;
CREATE TABLE `work_task_configuration` (
  `work_task_configuration_id` bigint NOT NULL AUTO_INCREMENT,
  `warehouse_id` bigint NOT NULL,
  `source_location_group_type_id` bigint DEFAULT NULL,
  `source_location_group_id` bigint DEFAULT NULL,
  `source_location_id` bigint DEFAULT NULL,
  `destination_location_group_type_id` bigint DEFAULT NULL,
  `destination_location_group_id` bigint DEFAULT NULL,
  `destination_location_id` bigint DEFAULT NULL,
  `work_task_type` varchar(50) NOT NULL,
  `operation_type_id` varchar(50) NOT NULL,
  `priority` int DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`work_task_configuration_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `working_team`;
CREATE TABLE `working_team` (
  `working_team_id` bigint NOT NULL AUTO_INCREMENT,
  `company_id` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `warehouse_id` bigint NOT NULL,
  PRIMARY KEY (`working_team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 

DROP TABLE IF EXISTS `working_team_user`;
CREATE TABLE `working_team_user` (
  `working_team_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  KEY `working_team_id` (`working_team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `working_team_user_ibfk_1` FOREIGN KEY (`working_team_id`) REFERENCES `working_team` (`working_team_id`),
  CONSTRAINT `working_team_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 2023-07-31 23:32:49
