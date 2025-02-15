CREATE TABLE `user_dim`(
    `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `DOB` DATE NOT NULL,
    `phone_no` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `modify_date` DATE NOT NULL
);
CREATE TABLE `booking_seat_bridge`(
    `show_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `seat_id` INT NOT NULL,
    `booking_id` INT NOT NULL
);
CREATE TABLE `payment_dim`(
    `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `payment_method_id` INT NOT NULL
);
CREATE TABLE `movie_dim`(
    `movie_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `genre` VARCHAR(255) NOT NULL,
    `duration` VARCHAR(255) NOT NULL,
    `release_date` DATE NOT NULL
);
CREATE TABLE `show_dim`(
    `show_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `show_time` DATETIME NOT NULL,
    `movie_id` INT NOT NULL,
    `screen_id` BIGINT NOT NULL
);
CREATE TABLE `language_movie_bridge_dim`(
    `movie_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `language_id` BIGINT NOT NULL
);
CREATE TABLE `movie_format`(
    `format_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `format` VARCHAR(255) NOT NULL
);
CREATE TABLE `movie_format_bridge`(
    `movie_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `format_id` BIGINT NOT NULL
);
CREATE TABLE `Theater_dim`(
    `theater_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    `pincode` VARCHAR(255) NOT NULL,
    `full_address` VARCHAR(255) NOT NULL
);
CREATE TABLE `Theater_screen_dim`(
    `screen_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `theater_id` INT NOT NULL,
    `establish_date` DATE NOT NULL,
    `total_seat` INT NOT NULL
);
CREATE TABLE `Booking_fact`(
    `booking_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `movie_id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `theater_id` INT NOT NULL,
    `screen_id` INT NOT NULL,
    `price` INT NOT NULL,
    `booking_date` DATETIME NOT NULL,
    `watch_date` DATETIME NOT NULL,
    `payment_method_id` BIGINT NOT NULL,
    `status` ENUM('Successful', 'Pending', 'Failed') NOT NULL,
    `e_ticket` INT NOT NULL
);
CREATE TABLE `theater_seat_dim`(
    `screen_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `seat_id` INT NOT NULL,
    `seat_category` VARCHAR(255) NOT NULL
);
CREATE TABLE `theater_seat_pricing_dim`(
    `screen_seat_category_pricing` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `pricing` INT NOT NULL
);
CREATE TABLE `seat_format_quantity_dim`(
    `screen_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `seat_category` VARCHAR(255) NOT NULL,
    `no_of_Seat` INT NOT NULL
);
CREATE TABLE `payment_method_dim`(
    `method_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `payment_dim` ADD CONSTRAINT `payment_dim_payment_method_id_foreign` FOREIGN KEY(`payment_method_id`) REFERENCES `payment_method_dim`(`method_id`);
ALTER TABLE
    `Booking_fact` ADD CONSTRAINT `booking_fact_payment_method_id_foreign` FOREIGN KEY(`payment_method_id`) REFERENCES `payment_dim`(`payment_method_id`);
ALTER TABLE
    `Theater_screen_dim` ADD CONSTRAINT `theater_screen_dim_theater_id_foreign` FOREIGN KEY(`theater_id`) REFERENCES `Theater_dim`(`theater_id`);
ALTER TABLE
    `Booking_fact` ADD CONSTRAINT `booking_fact_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `user_dim`(`user_id`);
ALTER TABLE
    `user_dim` ADD CONSTRAINT `user_dim_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `payment_dim`(`user_id`);
ALTER TABLE
    `show_dim` ADD CONSTRAINT `show_dim_movie_id_foreign` FOREIGN KEY(`movie_id`) REFERENCES `movie_dim`(`movie_id`);
ALTER TABLE
    `seat_format_quantity_dim` ADD CONSTRAINT `seat_format_quantity_dim_screen_id_foreign` FOREIGN KEY(`screen_id`) REFERENCES `Theater_screen_dim`(`screen_id`);
ALTER TABLE
    `language_movie_bridge_dim` ADD CONSTRAINT `language_movie_bridge_dim_movie_id_foreign` FOREIGN KEY(`movie_id`) REFERENCES `movie_dim`(`movie_id`);
ALTER TABLE
    `booking_seat_bridge` ADD CONSTRAINT `booking_seat_bridge_booking_id_foreign` FOREIGN KEY(`booking_id`) REFERENCES `Booking_fact`(`booking_id`);
ALTER TABLE
    `show_dim` ADD CONSTRAINT `show_dim_movie_id_foreign` FOREIGN KEY(`movie_id`) REFERENCES `Booking_fact`(`movie_id`);
ALTER TABLE
    `theater_seat_dim` ADD CONSTRAINT `theater_seat_dim_seat_category_foreign` FOREIGN KEY(`seat_category`) REFERENCES `theater_seat_pricing_dim`(`screen_seat_category_pricing`);
ALTER TABLE
    `movie_format_bridge` ADD CONSTRAINT `movie_format_bridge_movie_id_foreign` FOREIGN KEY(`movie_id`) REFERENCES `movie_dim`(`movie_id`);
ALTER TABLE
    `booking_seat_bridge` ADD CONSTRAINT `booking_seat_bridge_seat_id_foreign` FOREIGN KEY(`seat_id`) REFERENCES `theater_seat_dim`(`seat_id`);
ALTER TABLE
    `Booking_fact` ADD CONSTRAINT `booking_fact_theater_id_foreign` FOREIGN KEY(`theater_id`) REFERENCES `Theater_dim`(`theater_id`);
ALTER TABLE
    `theater_seat_dim` ADD CONSTRAINT `theater_seat_dim_seat_category_foreign` FOREIGN KEY(`seat_category`) REFERENCES `seat_format_quantity_dim`(`seat_category`);
ALTER TABLE
    `theater_seat_dim` ADD CONSTRAINT `theater_seat_dim_screen_id_foreign` FOREIGN KEY(`screen_id`) REFERENCES `Theater_screen_dim`(`screen_id`);
ALTER TABLE
    `movie_format_bridge` ADD CONSTRAINT `movie_format_bridge_format_id_foreign` FOREIGN KEY(`format_id`) REFERENCES `movie_format`(`format_id`);
ALTER TABLE
    `Booking_fact` ADD CONSTRAINT `booking_fact_e_ticket_foreign` FOREIGN KEY(`e_ticket`) REFERENCES `Booking_fact`(`status`);
ALTER TABLE
    `booking_seat_bridge` ADD CONSTRAINT `booking_seat_bridge_show_id_foreign` FOREIGN KEY(`show_id`) REFERENCES `show_dim`(`show_id`);
ALTER TABLE
    `show_dim` ADD CONSTRAINT `show_dim_screen_id_foreign` FOREIGN KEY(`screen_id`) REFERENCES `Theater_screen_dim`(`screen_id`);
ALTER TABLE
    `show_dim` ADD CONSTRAINT `show_dim_screen_id_foreign` FOREIGN KEY(`screen_id`) REFERENCES `Booking_fact`(`screen_id`);
ALTER TABLE
    `theater_seat_dim` ADD CONSTRAINT `theater_seat_dim_screen_id_foreign` FOREIGN KEY(`screen_id`) REFERENCES `theater_seat_pricing_dim`(`screen_seat_category_pricing`);