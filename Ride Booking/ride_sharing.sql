CREATE TABLE `customer_dim`(
    `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `customer_name` VARCHAR(255) NOT NULL,
    `DOB` DATE NOT NULL,
    `email_bridge_id` INT NOT NULL,
    `phone_bridge_id` INT NOT NULL
);
CREATE TABLE `email_dim`(
    `customer_id` INT UNSIGNED NOT NULL,
    `email_id` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`email_id`)
);
CREATE TABLE `phone_dim`(
    `customer_id` INT UNSIGNED NOT NULL,
    `mob_no` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`mob_no`)
);
CREATE TABLE `driver_dim`(
    `driver_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `driver_name` VARCHAR(255) NOT NULL,
    `DOB` DATE NOT NULL,
    `phone_no` VARCHAR(255) NOT NULL,
    `driver_detail_id` INT NOT NULL
);
CREATE TABLE `booking_fact`(
    `booking_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `customer_id` INT NOT NULL,
    `driver_id` INT NOT NULL,
    `booking_datetime_id` INT NOT NULL,
    `track_id` INT NOT NULL,
    `pickup_location` POINT NOT NULL,
    `drop_off_location` POINT NOT NULL
);
CREATE TABLE `track_dim`(
    `track_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `driver_id` INT NOT NULL,
    `status` ENUM('') NOT NULL,
    `pickUp_time_id` DATETIME NOT NULL,
    `drop_off_time_id` DATETIME NOT NULL,
    `calculate_charge` INT NOT NULL,
    `fair_status` ENUM('') NOT NULL,
    `payment_method_id` INT NOT NULL,
    `fair_amount` INT NOT NULL,
    `total_distance` INT NOT NULL,
    `remaining_distance` INT NOT NULL,
    `is_cancelled` BOOLEAN NOT NULL,
    `cancelled_reason` VARCHAR(255) NOT NULL
);
CREATE TABLE `driver_details_dim`(
    `driver__detail_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `status` ENUM('Available', 'Booked') NOT NULL,
    `current_location` POINT NOT NULL,
    `updated_time` DATETIME NOT NULL,
    `Is_Cancalled` BOOLEAN NOT NULL
);
CREATE TABLE `payment_method_dim`(
    `payment_method_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `payment_method_name` VARCHAR(255) NOT NULL
);
CREATE TABLE `ride_history_dim`(
    `ride_history_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `booking_id` INT NOT NULL,
    `driver_earning` INT NOT NULL,
    `total_trip_fair` INT NOT NULL
);
CREATE TABLE `datetime_dim`(
    `datetime_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `date_time` DATETIME NOT NULL,
    `day` INT NOT NULL,
    `year` INT NOT NULL,
    `quarter_number` INT NOT NULL,
    `weekend` BOOLEAN NOT NULL,
    `holiday` BOOLEAN NOT NULL,
    `holiday_reason` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `track_dim` ADD CONSTRAINT `track_dim_payment_method_id_foreign` FOREIGN KEY(`payment_method_id`) REFERENCES `payment_method_dim`(`payment_method_id`);
ALTER TABLE
    `email_dim` ADD CONSTRAINT `email_dim_customer_id_foreign` FOREIGN KEY(`customer_id`) REFERENCES `customer_dim`(`customer_id`);
ALTER TABLE
    `driver_details_dim` ADD CONSTRAINT `driver_details_dim_current_location_foreign` FOREIGN KEY(`current_location`) REFERENCES `track_dim`(`remaining_distance`);
ALTER TABLE
    `booking_fact` ADD CONSTRAINT `booking_fact_driver_id_foreign` FOREIGN KEY(`driver_id`) REFERENCES `track_dim`(`driver_id`);
ALTER TABLE
    `booking_fact` ADD CONSTRAINT `booking_fact_driver_id_foreign` FOREIGN KEY(`driver_id`) REFERENCES `driver_dim`(`driver_id`);
ALTER TABLE
    `booking_fact` ADD CONSTRAINT `booking_fact_drop_off_location_foreign` FOREIGN KEY(`drop_off_location`) REFERENCES `track_dim`(`remaining_distance`);
ALTER TABLE
    `customer_dim` ADD CONSTRAINT `customer_dim_phone_bridge_id_foreign` FOREIGN KEY(`phone_bridge_id`) REFERENCES `phone_dim`(`mob_no`);
ALTER TABLE
    `phone_dim` ADD CONSTRAINT `phone_dim_customer_id_foreign` FOREIGN KEY(`customer_id`) REFERENCES `customer_dim`(`customer_id`);
ALTER TABLE
    `booking_fact` ADD CONSTRAINT `booking_fact_booking_datetime_id_foreign` FOREIGN KEY(`booking_datetime_id`) REFERENCES `datetime_dim`(`datetime_id`);
ALTER TABLE
    `booking_fact` ADD CONSTRAINT `booking_fact_track_id_foreign` FOREIGN KEY(`track_id`) REFERENCES `track_dim`(`track_id`);
ALTER TABLE
    `booking_fact` ADD CONSTRAINT `booking_fact_drop_off_location_foreign` FOREIGN KEY(`drop_off_location`) REFERENCES `track_dim`(`total_distance`);
ALTER TABLE
    `track_dim` ADD CONSTRAINT `track_dim_pickup_time_id_foreign` FOREIGN KEY(`pickUp_time_id`) REFERENCES `datetime_dim`(`datetime_id`);
ALTER TABLE
    `track_dim` ADD CONSTRAINT `track_dim_fair_status_foreign` FOREIGN KEY(`fair_status`) REFERENCES `track_dim`(`is_cancelled`);
ALTER TABLE
    `booking_fact` ADD CONSTRAINT `booking_fact_pickup_location_foreign` FOREIGN KEY(`pickup_location`) REFERENCES `track_dim`(`total_distance`);
ALTER TABLE
    `track_dim` ADD CONSTRAINT `track_dim_is_cancelled_foreign` FOREIGN KEY(`is_cancelled`) REFERENCES `track_dim`(`cancelled_reason`);
ALTER TABLE
    `booking_fact` ADD CONSTRAINT `booking_fact_customer_id_foreign` FOREIGN KEY(`customer_id`) REFERENCES `customer_dim`(`customer_id`);
ALTER TABLE
    `driver_details_dim` ADD CONSTRAINT `driver_details_dim_is_cancalled_foreign` FOREIGN KEY(`Is_Cancalled`) REFERENCES `track_dim`(`is_cancelled`);
ALTER TABLE
    `track_dim` ADD CONSTRAINT `track_dim_drop_off_time_id_foreign` FOREIGN KEY(`drop_off_time_id`) REFERENCES `datetime_dim`(`datetime_id`);
ALTER TABLE
    `customer_dim` ADD CONSTRAINT `customer_dim_email_bridge_id_foreign` FOREIGN KEY(`email_bridge_id`) REFERENCES `email_dim`(`email_id`);
ALTER TABLE
    `ride_history_dim` ADD CONSTRAINT `ride_history_dim_booking_id_foreign` FOREIGN KEY(`booking_id`) REFERENCES `booking_fact`(`booking_id`);
ALTER TABLE
    `driver_dim` ADD CONSTRAINT `driver_dim_driver_detail_id_foreign` FOREIGN KEY(`driver_detail_id`) REFERENCES `driver_details_dim`(`driver__detail_id`);