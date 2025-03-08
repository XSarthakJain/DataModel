CREATE TABLE `product_Fact`(
    `product_id` INT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `category_id` INT NOT NULL,
    `SKU` INT NOT NULL,
    `price` INT NOT NULL,
    `supplier_id` INT NOT NULL,
    `Stock_fullfilment_date_id` INT NOT NULL,
    PRIMARY KEY(`product_id`)
);
CREATE TABLE `category_dim`(
    `category_id` INT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`category_id`)
);
CREATE TABLE `supplier_dim`(
    `supplier_id` INT NOT NULL,
    `supplier_name` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`supplier_id`)
);
CREATE TABLE `warehouse_Dim`(
    `warehouse_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `SKU` INT NOT NULL,
    `updated_date_id` INT NOT NULL
);
CREATE TABLE `customer_order_Fact`(
    `customer_id` INT NOT NULL,
    `order_date_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `quantity` INT NOT NULL,
    `tracking_id` INT NOT NULL,
    `order_id` INT NOT NULL
);
CREATE TABLE `track_dim`(
    `tracking_id` INT NOT NULL,
    `status` ENUM('Successful', 'Pending', 'Completed') NOT NULL,
    `warehouse_id` INT NOT NULL,
    `payment_method` ENUM('') NOT NULL,
    `payment_amount` INT NOT NULL,
    `payment_status` ENUM('') NOT NULL,
    `payment_date_id` INT NOT NULL,
    `is_Discount` BOOLEAN NOT NULL,
    `discount_percent` INT NOT NULL,
    `is_Return` BOOLEAN NOT NULL,
    `return_id` INT NOT NULL,
    `is_canceled` BOOLEAN NOT NULL,
    `canceled_id` INT NOT NULL,
    PRIMARY KEY(`tracking_id`)
);
CREATE TABLE `datetime_dim`(
    `datetime_id` INT NOT NULL,
    `datetime` DATETIME NOT NULL,
    `date` INT NOT NULL,
    `month` INT NOT NULL,
    `year` INT NOT NULL,
    `quarter` INT NOT NULL,
    `is_Holiday` BOOLEAN NOT NULL,
    `Holiday_reason` VARCHAR(255) NOT NULL,
    `is_Weekend` BOOLEAN NOT NULL,
    `Weekend_reason` VARCHAR(255) NOT NULL,
    `fiscal_year` BOOLEAN NOT NULL,
    PRIMARY KEY(`datetime_id`)
);
CREATE TABLE `return_dim`(
    `return_id` INT NOT NULL,
    `tracking_id` INT NOT NULL,
    `return_reason` ENUM('') NOT NULL,
    `return_date_id` INT NOT NULL,
    PRIMARY KEY(`return_id`)
);
CREATE TABLE `cancelled_dim`(
    `cancelled_id` INT NOT NULL,
    `tracking_id` INT NOT NULL,
    `cancelled_reason` ENUM('') NOT NULL,
    `cancelled_date_id` INT NOT NULL,
    PRIMARY KEY(`cancelled_id`)
);
ALTER TABLE
    `product_Fact` ADD CONSTRAINT `product_fact_sku_foreign` FOREIGN KEY(`SKU`) REFERENCES `warehouse_Dim`(`SKU`);
ALTER TABLE
    `track_dim` ADD CONSTRAINT `track_dim_warehouse_id_foreign` FOREIGN KEY(`warehouse_id`) REFERENCES `warehouse_Dim`(`warehouse_id`);
ALTER TABLE
    `warehouse_Dim` ADD CONSTRAINT `warehouse_dim_updated_date_id_foreign` FOREIGN KEY(`updated_date_id`) REFERENCES `datetime_dim`(`datetime_id`);
ALTER TABLE
    `cancelled_dim` ADD CONSTRAINT `cancelled_dim_cancelled_date_id_foreign` FOREIGN KEY(`cancelled_date_id`) REFERENCES `datetime_dim`(`datetime_id`);
ALTER TABLE
    `customer_order_Fact` ADD CONSTRAINT `customer_order_fact_order_date_id_foreign` FOREIGN KEY(`order_date_id`) REFERENCES `datetime_dim`(`datetime_id`);
ALTER TABLE
    `customer_order_Fact` ADD CONSTRAINT `customer_order_fact_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `product_Fact`(`product_id`);
ALTER TABLE
    `warehouse_Dim` ADD CONSTRAINT `warehouse_dim_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `product_Fact`(`product_id`);
ALTER TABLE
    `track_dim` ADD CONSTRAINT `track_dim_return_id_foreign` FOREIGN KEY(`return_id`) REFERENCES `return_dim`(`return_id`);
ALTER TABLE
    `customer_order_Fact` ADD CONSTRAINT `customer_order_fact_tracking_id_foreign` FOREIGN KEY(`tracking_id`) REFERENCES `track_dim`(`tracking_id`);
ALTER TABLE
    `product_Fact` ADD CONSTRAINT `product_fact_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `category_dim`(`category_id`);
ALTER TABLE
    `customer_order_Fact` ADD CONSTRAINT `customer_order_fact_quantity_foreign` FOREIGN KEY(`quantity`) REFERENCES `warehouse_Dim`(`SKU`);
ALTER TABLE
    `track_dim` ADD CONSTRAINT `track_dim_payment_date_id_foreign` FOREIGN KEY(`payment_date_id`) REFERENCES `datetime_dim`(`datetime_id`);
ALTER TABLE
    `return_dim` ADD CONSTRAINT `return_dim_return_date_id_foreign` FOREIGN KEY(`return_date_id`) REFERENCES `datetime_dim`(`datetime_id`);
ALTER TABLE
    `product_Fact` ADD CONSTRAINT `product_fact_supplier_id_foreign` FOREIGN KEY(`supplier_id`) REFERENCES `supplier_dim`(`supplier_id`);
ALTER TABLE
    `track_dim` ADD CONSTRAINT `track_dim_canceled_id_foreign` FOREIGN KEY(`canceled_id`) REFERENCES `cancelled_dim`(`cancelled_id`);