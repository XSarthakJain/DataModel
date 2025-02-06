CREATE TABLE `Customer_dim`(
    `customerId` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `customerName` VARCHAR(255) NOT NULL,
    `DateOfBirth` DATE NOT NULL,
    `Gender` VARCHAR(255) NOT NULL,
    `HouseNumber` VARCHAR(255) NOT NULL,
    `location_id` INT NOT NULL
);
CREATE TABLE `Product_dim`(
    `product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `productName` VARCHAR(255) NOT NULL,
    `productCategory` VARCHAR(255) NOT NULL,
    `Brand` VARCHAR(255) NOT NULL,
    `Restricated_Age` INT NOT NULL,
    `Price` INT NOT NULL,
    `currency_id` INT NOT NULL
);
CREATE TABLE `Order_Fact`(
    `Order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `product_id` INT NOT NULL,
    `Quantity` INT NOT NULL,
    `customer_id` BIGINT NOT NULL,
    `dateId` INT NOT NULL,
    `Payment` INT NOT NULL,
    `currency_Id` INT NOT NULL,
    `order_Track` INT NOT NULL
);
CREATE TABLE `time_dim`(
    `time_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `date` DATE NOT NULL,
    `month` INT NOT NULL,
    `day` INT NOT NULL,
    `year` INT NOT NULL,
    `Holiday` BOOLEAN NOT NULL,
    `HolidayReason` VARCHAR(255) NOT NULL,
    `Is_Weekend` BOOLEAN NOT NULL,
    `week_number` INT NOT NULL,
    `quarter` INT NOT NULL
);
CREATE TABLE `currency_dim`(
    `currency_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `currency_sign` VARCHAR(255) NOT NULL,
    `currency_value` DECIMAL(8, 2) NOT NULL,
    `currency_code` VARCHAR(255) NOT NULL
);
CREATE TABLE `OrderTrack_dim`(
    `order_Track_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `productId` INT NOT NULL,
    `Status` VARCHAR(255) NOT NULL,
    `Order_date` DATE NOT NULL,
    `WarehouseDepartureDate` DATE NOT NULL
);
CREATE TABLE `Address_dim`(
    `location_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Country` VARCHAR(255) NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `pincode` VARCHAR(255) NOT NULL,
    `Landmark` BIGINT NOT NULL
);
CREATE TABLE `PricveHistorySCD_dim`(
    `product_Id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `new_Price` INT NOT NULL,
    `currency_id` BIGINT NOT NULL,
    `old_Price` INT NOT NULL,
    `new_Price` INT NOT NULL,
    `valid_From` DATE NOT NULL,
    `valid_till` DATE NOT NULL,
    `active` ENUM('') NOT NULL
);
CREATE TABLE `orderTrackStatusHistory`(
    `orderHistoryId` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `orderTrackId` INT NOT NULL,
    `status` VARCHAR(255) NOT NULL,
    `order_date` DATE NOT NULL,
    `status_modify_date` DATE NOT NULL
);
ALTER TABLE
    `Order_Fact` ADD CONSTRAINT `order_fact_dateid_foreign` FOREIGN KEY(`dateId`) REFERENCES `time_dim`(`time_id`);
ALTER TABLE
    `Order_Fact` ADD CONSTRAINT `order_fact_order_id_foreign` FOREIGN KEY(`Order_id`) REFERENCES `Order_Fact`(`product_id`);
ALTER TABLE
    `Order_Fact` ADD CONSTRAINT `order_fact_currency_id_foreign` FOREIGN KEY(`currency_Id`) REFERENCES `currency_dim`(`currency_id`);
ALTER TABLE
    `Customer_dim` ADD CONSTRAINT `customer_dim_location_id_foreign` FOREIGN KEY(`location_id`) REFERENCES `Address_dim`(`location_id`);
ALTER TABLE
    `Order_Fact` ADD CONSTRAINT `order_fact_dateid_foreign` FOREIGN KEY(`dateId`) REFERENCES `OrderTrack_dim`(`Order_date`);
ALTER TABLE
    `PricveHistorySCD_dim` ADD CONSTRAINT `pricvehistoryscd_dim_product_id_foreign` FOREIGN KEY(`product_Id`) REFERENCES `Product_dim`(`product_id`);
ALTER TABLE
    `Order_Fact` ADD CONSTRAINT `order_fact_order_track_foreign` FOREIGN KEY(`order_Track`) REFERENCES `OrderTrack_dim`(`order_Track_Id`);
ALTER TABLE
    `Order_Fact` ADD CONSTRAINT `order_fact_customer_id_foreign` FOREIGN KEY(`customer_id`) REFERENCES `Customer_dim`(`customerId`);
ALTER TABLE
    `Product_dim` ADD CONSTRAINT `product_dim_currency_id_foreign` FOREIGN KEY(`currency_id`) REFERENCES `currency_dim`(`currency_id`);
ALTER TABLE
    `orderTrackStatusHistory` ADD CONSTRAINT `ordertrackstatushistory_ordertrackid_foreign` FOREIGN KEY(`orderTrackId`) REFERENCES `OrderTrack_dim`(`order_Track_Id`);
ALTER TABLE
    `Order_Fact` ADD CONSTRAINT `order_fact_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `Product_dim`(`product_id`);
ALTER TABLE
    `Order_Fact` ADD CONSTRAINT `order_fact_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `OrderTrack_dim`(`productId`);