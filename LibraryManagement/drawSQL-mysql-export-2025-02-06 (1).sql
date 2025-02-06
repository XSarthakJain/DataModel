CREATE TABLE `Book_dim`(
    `book_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `book_Name` VARCHAR(255) NOT NULL,
    `book_Price` INT NOT NULL,
    `category_Id` INT NOT NULL,
    `edition_Id` BIGINT NOT NULL,
    `publisher_Id` BIGINT NOT NULL,
    `library_id` INT NOT NULL
);
CREATE TABLE `Author_dim`(
    `author_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `author_Name` VARCHAR(255) NOT NULL
);
CREATE TABLE `Category_dim`(
    `category_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `category` VARCHAR(255) NOT NULL
);
CREATE TABLE `Edition_dim`(
    `edition_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `edition_Name` VARCHAR(255) NOT NULL
);
CREATE TABLE `publisher_dim`(
    `publisher_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `publisher_Name` VARCHAR(255) NOT NULL
);
CREATE TABLE `Member_dim`(
    `member_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `member_Name` VARCHAR(255) NOT NULL,
    `DOB` DATE NOT NULL,
    `date_Id` INT NOT NULL,
    `gender` VARCHAR(255) NOT NULL,
    `mobile_Number` VARCHAR(255) NOT NULL,
    `email_Id` VARCHAR(255) NOT NULL
);
CREATE TABLE `library_dim`(
    `library_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `library_name` VARCHAR(255) NOT NULL,
    `library_establish_day_Id` INT NOT NULL,
    `library_add_Id` BIGINT NOT NULL,
    `library_store_Number` BIGINT NOT NULL
);
CREATE TABLE `address_dim`(
    `address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `country` VARCHAR(255) NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `pincode` BIGINT NOT NULL,
    `landmark` VARCHAR(255) NOT NULL
);
CREATE TABLE `date_dim`(
    `date_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `datetime` DATETIME NOT NULL,
    `day` INT NOT NULL,
    `month` INT NOT NULL,
    `year` INT NOT NULL,
    `quarter_Number` INT NOT NULL,
    `fiscal_Year` INT NOT NULL,
    `weekend` BOOLEAN NOT NULL,
    `Holiday` BOOLEAN NOT NULL,
    `Holiday_Reason` VARCHAR(255) NOT NULL
);
CREATE TABLE `checkout_Fact`(
    `checkout_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `member_Id` INT NOT NULL,
    `book_Id` INT NOT NULL,
    `issue_datetime_Id` INT NOT NULL,
    `return_datetime_Id` INT NOT NULL,
    `Payment` INT NOT NULL,
    `Payment_type_Id` INT NOT NULL,
    `is_Fine` BOOLEAN NOT NULL,
    `fine_id` INT NOT NULL,
    `staff_Id` INT NOT NULL,
    `library_id` INT NOT NULL
);
CREATE TABLE `paymentType_dim`(
    `paymentType_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `payment_method` VARCHAR(255) NOT NULL,
    `vandor_tax_charge` INT NOT NULL
);
CREATE TABLE `staff_dim`(
    `staff_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `staff_Person_Name` VARCHAR(255) NOT NULL,
    `DOB` DATE NOT NULL,
    `mobile_Number` VARCHAR(255) NOT NULL,
    `email_Id` VARCHAR(255) NOT NULL,
    `gender` VARCHAR(255) NOT NULL,
    `library_id` INT NOT NULL
);
CREATE TABLE `book_Quantity_dim`(
    `book_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `quantity` INT NOT NULL,
    `available_Quantity` INT NOT NULL,
    `update_date_id` INT NOT NULL
);
CREATE TABLE `book_author_bridge_dim`(
    `book_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `author_id` BIGINT NOT NULL,
    PRIMARY KEY(`author_id`)
);
CREATE TABLE `fineStatus_History_Fact`(
    `fine_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `checkout_Id` BIGINT NOT NULL,
    `status` ENUM('') NOT NULL,
    `paid_amount` INT NOT NULL,
    `fine_applied_date_Id` INT NOT NULL,
    `fine_paid_date_Id` BIGINT NOT NULL
);
ALTER TABLE
    `checkout_Fact` ADD CONSTRAINT `checkout_fact_payment_type_id_foreign` FOREIGN KEY(`Payment_type_Id`) REFERENCES `paymentType_dim`(`paymentType_Id`);
ALTER TABLE
    `checkout_Fact` ADD CONSTRAINT `checkout_fact_return_datetime_id_foreign` FOREIGN KEY(`return_datetime_Id`) REFERENCES `date_dim`(`date_Id`);
ALTER TABLE
    `checkout_Fact` ADD CONSTRAINT `checkout_fact_staff_id_foreign` FOREIGN KEY(`staff_Id`) REFERENCES `staff_dim`(`staff_Id`);
ALTER TABLE
    `checkout_Fact` ADD CONSTRAINT `checkout_fact_issue_datetime_id_foreign` FOREIGN KEY(`issue_datetime_Id`) REFERENCES `date_dim`(`date_Id`);
ALTER TABLE
    `checkout_Fact` ADD CONSTRAINT `checkout_fact_fine_id_foreign` FOREIGN KEY(`fine_id`) REFERENCES `fineStatus_History_Fact`(`fine_Id`);
ALTER TABLE
    `Book_dim` ADD CONSTRAINT `book_dim_edition_id_foreign` FOREIGN KEY(`edition_Id`) REFERENCES `Edition_dim`(`edition_Id`);
ALTER TABLE
    `fineStatus_History_Fact` ADD CONSTRAINT `finestatus_history_fact_fine_applied_date_id_foreign` FOREIGN KEY(`fine_applied_date_Id`) REFERENCES `date_dim`(`date_Id`);
ALTER TABLE
    `book_Quantity_dim` ADD CONSTRAINT `book_quantity_dim_update_date_id_foreign` FOREIGN KEY(`update_date_id`) REFERENCES `date_dim`(`date_Id`);
ALTER TABLE
    `fineStatus_History_Fact` ADD CONSTRAINT `finestatus_history_fact_checkout_id_foreign` FOREIGN KEY(`checkout_Id`) REFERENCES `checkout_Fact`(`checkout_id`);
ALTER TABLE
    `Book_dim` ADD CONSTRAINT `book_dim_publisher_id_foreign` FOREIGN KEY(`publisher_Id`) REFERENCES `publisher_dim`(`publisher_Id`);
ALTER TABLE
    `Author_dim` ADD CONSTRAINT `author_dim_author_id_foreign` FOREIGN KEY(`author_Id`) REFERENCES `book_author_bridge_dim`(`author_id`);
ALTER TABLE
    `checkout_Fact` ADD CONSTRAINT `checkout_fact_book_id_foreign` FOREIGN KEY(`book_Id`) REFERENCES `Book_dim`(`book_Id`);
ALTER TABLE
    `library_dim` ADD CONSTRAINT `library_dim_library_establish_day_id_foreign` FOREIGN KEY(`library_establish_day_Id`) REFERENCES `date_dim`(`date_Id`);
ALTER TABLE
    `book_Quantity_dim` ADD CONSTRAINT `book_quantity_dim_book_id_foreign` FOREIGN KEY(`book_id`) REFERENCES `Book_dim`(`book_Id`);
ALTER TABLE
    `Member_dim` ADD CONSTRAINT `member_dim_date_id_foreign` FOREIGN KEY(`date_Id`) REFERENCES `date_dim`(`date_Id`);
ALTER TABLE
    `staff_dim` ADD CONSTRAINT `staff_dim_library_id_foreign` FOREIGN KEY(`library_id`) REFERENCES `library_dim`(`library_id`);
ALTER TABLE
    `checkout_Fact` ADD CONSTRAINT `checkout_fact_member_id_foreign` FOREIGN KEY(`member_Id`) REFERENCES `Member_dim`(`member_Id`);
ALTER TABLE
    `library_dim` ADD CONSTRAINT `library_dim_library_add_id_foreign` FOREIGN KEY(`library_add_Id`) REFERENCES `address_dim`(`address_id`);
ALTER TABLE
    `checkout_Fact` ADD CONSTRAINT `checkout_fact_library_id_foreign` FOREIGN KEY(`library_id`) REFERENCES `library_dim`(`library_id`);
ALTER TABLE
    `Book_dim` ADD CONSTRAINT `book_dim_category_id_foreign` FOREIGN KEY(`category_Id`) REFERENCES `Category_dim`(`category_Id`);
ALTER TABLE
    `Book_dim` ADD CONSTRAINT `book_dim_library_id_foreign` FOREIGN KEY(`library_id`) REFERENCES `library_dim`(`library_id`);
ALTER TABLE
    `fineStatus_History_Fact` ADD CONSTRAINT `finestatus_history_fact_fine_paid_date_id_foreign` FOREIGN KEY(`fine_paid_date_Id`) REFERENCES `date_dim`(`date_Id`);
ALTER TABLE
    `book_author_bridge_dim` ADD CONSTRAINT `book_author_bridge_dim_book_id_foreign` FOREIGN KEY(`book_id`) REFERENCES `Book_dim`(`book_Id`);