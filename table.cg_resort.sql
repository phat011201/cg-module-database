-- Active: 1711366250156@@127.0.0.1@3306@cg_resort

-- Drop all tables
DROP TABLE `contract_detail`;

DROP TABLE `contract`;

DROP TABLE `facility`;

DROP TABLE `rent_type`;

DROP TABLE `facility_type`;

DROP TABLE `employee`;

DROP TABLE `user_role`;

DROP TABLE `role`;

DROP TABLE `user`;

DROP TABLE `customer`;

DROP TABLE `customer_type`;

DROP TABLE `position`;

DROP TABLE `division`;

DROP TABLE `education_degree`;

DROP TABLE `attach_facility`;

-- Create the attach_facility table
CREATE TABLE `attach_facility`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `cost` DOUBLE NULL,
  `unit` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  `is_delete` BIT NULL
);

-- Create the education_degree table
CREATE TABLE `education_degree`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `is_delete` BIT NULL
);

-- Create the division table
CREATE TABLE `division`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(45),
  `is_delete` BIT
);

-- Create the position table
CREATE TABLE `position`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(45),
  `is_delete` BIT
);

-- Create the customer_type table
CREATE TABLE `customer_type`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50),
  `is_delete` BIT
);

-- Create the customer table
CREATE TABLE `customer`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `customer_type_id` INT,
  `name` VARCHAR(50),
  `gender` BIT NOT NULL CHECK (gender IN (0, 1)),
  `date_of_birth` DATE NOT NULL,
  `id_card_number` CHAR(12) NOT NULL,
  `phone_number` CHAR(10) NOT NULL,
  `email_address` CHAR(255) NOT NULL,
  `address` TEXT NOT NULL,
  `position_id` INT,
  `division_id` INT,
  `education_degree_id` INT,
  `is_delete` BIT,
  FOREIGN KEY (`customer_type_id`) REFERENCES `customer_type` (`id`),
  FOREIGN KEY (`position_id`) REFERENCES `position` (`id`),
  FOREIGN KEY (`division_id`) REFERENCES `division` (`id`)
);

-- Create the user table
CREATE TABLE `user`
(
  `user_name` VARCHAR(255) PRIMARY KEY,
  `password` VARCHAR(255),
  `is_delete` BIT
);

-- Create the role table
CREATE TABLE `role`
(
  `role_id` INT PRIMARY KEY,
  `role_name` VARCHAR(45) NOT NULL,
  `is_delete` BIT
);

-- Create the user_role table
CREATE TABLE `user_role`
(
  `role_id` INT NOT NULL,
  `user_name` VARCHAR(255) NOT NULL,
  `is_delete` BIT NULL,
  PRIMARY KEY (`role_id`, `user_name`),
  FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  FOREIGN KEY (`user_name`) REFERENCES `user` (`user_name`)
);

-- Create the employee table
CREATE TABLE `employee`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `date_of_birth` VARCHAR(50) NOT NULL,
  `id_card` VARCHAR(12) NOT NULL,
  `salary` DOUBLE NOT NULL,
  `phone_number` VARCHAR(12) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `position_id` INT NULL,
  `education_degree_id` INT NULL,
  `division_id` INT NULL,
  `user_name` VARCHAR(255) NULL,
  `is_delete` BIT NULL,
  FOREIGN KEY (`position_id`) REFERENCES `position` (`id`),
  FOREIGN KEY (`education_degree_id`) REFERENCES `education_degree` (`id`),
  FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  Foreign Key (`user_name`) REFERENCES `user` (`user_name`)
);

-- Create the facility_type table
CREATE TABLE `facility_type`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `is_delete` BIT NULL
);

-- Create the rent_type table
CREATE TABLE `rent_type`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `is_delete` BIT NULL
);

-- Create the facility table
CREATE Table `facility`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `area` INT NULL,
  `cost` DOUBLE NULL,
  `max_people` INT NULL,
  `rent_type_id` INT NULL,
  `facility_type_id` INT NULL,
  `standard_room` VARCHAR(45) NULL,
  `description_other_convenience` VARCHAR(45) NULL,
  `pool_area` DOUBLE NULL,
  `number_of_floors` INT NULL,
  `facility_tree` TEXT NULL,
  `is_delete` BIT NULL,
  Foreign Key (`rent_type_id`) REFERENCES `rent_type` (`id`),
  Foreign Key (`facility_type_id`) REFERENCES `facility_type` (`id`)
);

-- Create the contract table
CREATE TABLE `contract`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `deposit` DOUBLE NULL,
  `employee_id` INT NULL,
  `customer_id` INT NULL,
  `facility_id` INT NULL,
  `is_delete` BIT NULL,
  FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  FOREIGN KEY (`facility_id`) REFERENCES `attach_facility` (`id`)
);

-- Create the contract_detail table
CREATE TABLE `contract_detail`
(
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `contract_id` INT NULL,
  `attach_facility_id` INT NULL,
  `quantity` INT NULL,
  `is_delete` BIT NULL,
  FOREIGN KEY (`contract_id`) REFERENCES `contract` (`id`),
  FOREIGN KEY (`attach_facility_id`) REFERENCES `attach_facility` (`id`)
);

