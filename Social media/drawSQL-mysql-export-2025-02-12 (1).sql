CREATE TABLE `user_fact`(
    `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(255) NOT NULL,
    `DOB` DATE NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone_no` VARCHAR(255) NOT NULL,
    `gender` VARCHAR(255) NOT NULL,
    `bio` VARCHAR(255) NOT NULL,
    `profile_pic_path` VARCHAR(255) NOT NULL
);
CREATE TABLE `follower_relationship`(
    `follower_id` INT NOT NULL,
    `followed_id` INT NOT NULL,
    `date` DATE NOT NULL
);
CREATE TABLE `post_fact`(
    `post_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `datetime` DATETIME NOT NULL,
    `caption` VARCHAR(255) NOT NULL,
    `visibility` VARCHAR(255) NOT NULL
);
CREATE TABLE `media_dim`(
    `media_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `url` VARCHAR(255) NOT NULL,
    `media_type` VARCHAR(255) NOT NULL,
    `modify_date` DATETIME NOT NULL,
    `post_id` BIGINT NOT NULL
);
CREATE TABLE `post_like_dim`(
    `like_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `post_id` INT NOT NULL
);
CREATE TABLE `post_history_scd_dim`(
    `like_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `like_by` INT NOT NULL,
    `datetime` DATETIME NOT NULL
);
CREATE TABLE `comment_dim`(
    `comment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `post_id` INT NOT NULL,
    `is_deleted` BOOLEAN NOT NULL
);
CREATE TABLE `comment_history_dim`(
    `comment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `upload_time` DATETIME NOT NULL,
    `comment_text` VARCHAR(255) NOT NULL,
    `start_date` DATETIME NOT NULL,
    `end_date` DATETIME NOT NULL,
    `active_flag` BOOLEAN NOT NULL,
    `comment_by` INT NOT NULL
);
ALTER TABLE
    `follower_relationship` ADD CONSTRAINT `follower_relationship_followed_id_foreign` FOREIGN KEY(`followed_id`) REFERENCES `user_fact`(`user_id`);
ALTER TABLE
    `comment_history_dim` ADD CONSTRAINT `comment_history_dim_comment_id_foreign` FOREIGN KEY(`comment_id`) REFERENCES `comment_dim`(`comment_id`);
ALTER TABLE
    `media_dim` ADD CONSTRAINT `media_dim_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `post_fact`(`post_id`);
ALTER TABLE
    `post_like_dim` ADD CONSTRAINT `post_like_dim_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `post_fact`(`post_id`);
ALTER TABLE
    `post_history_scd_dim` ADD CONSTRAINT `post_history_scd_dim_like_id_foreign` FOREIGN KEY(`like_id`) REFERENCES `post_like_dim`(`like_id`);
ALTER TABLE
    `post_history_scd_dim` ADD CONSTRAINT `post_history_scd_dim_like_by_foreign` FOREIGN KEY(`like_by`) REFERENCES `user_fact`(`user_id`);
ALTER TABLE
    `comment_history_dim` ADD CONSTRAINT `comment_history_dim_comment_by_foreign` FOREIGN KEY(`comment_by`) REFERENCES `user_fact`(`user_id`);
ALTER TABLE
    `post_fact` ADD CONSTRAINT `post_fact_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `user_fact`(`user_id`);
ALTER TABLE
    `follower_relationship` ADD CONSTRAINT `follower_relationship_follower_id_foreign` FOREIGN KEY(`follower_id`) REFERENCES `user_fact`(`user_id`);
ALTER TABLE
    `comment_dim` ADD CONSTRAINT `comment_dim_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `post_fact`(`post_id`);