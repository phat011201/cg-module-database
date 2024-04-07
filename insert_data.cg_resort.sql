-- Active: 1711366250156@@127.0.0.1@3306@cg_resort
-- Insert 10 data of resort into the attach_facility table
INSERT INTO `attach_facility` (`name`, `cost`, `unit`, `status`, `is_delete`)
VALUES
 ('Swimming pool', 100000, 'hour', 'active', 0),
 ('Gym', 50000, 'hour', 'active', 0),
 ('Spa', 200000, 'hour', 'active', 0),
 ('Restaurant', 50000, 'meal', 'active', 0),
 ('Bar', 50000, 'drink', 'active', 0),
 ('Karaoke', 100000, 'hour', 'active', 0),
 ('Cinema', 100000, 'hour', 'active', 0),
 ('Bowling', 100000, 'hour', 'active', 0),
 ('Tennis court', 100000, 'hour', 'active', 0),
 ('Football field', 100000, 'hour', 'active', 0);

-- Insert 3 data of resort into the education_degree table
INSERT INTO `education_degree` (`name`, `is_delete`)
VALUES
 ('Intermediate', 0),
 ('College', 0),
 ('University', 0);

-- Insert 3 data of resort into the division table
INSERT INTO `division` (`name`, `is_delete`)
VALUES
 ('Administration', 0),
 ('Human Resource', 0),
 ('Marketing', 0);

-- Insert 3 data of resort into the position table
INSERT INTO `position` (`name`, `is_delete`)
VALUES
 ('Manager', 0),
 ('Staff', 0),
 ('Intern', 0);

-- Insert 3 data of resort into the customer_type table
INSERT INTO `customer_type` (`name`, `is_delete`)
VALUES
 ('VIP', 0),
 ('Normal', 0),
 ('Platinum', 0),
 ('Diamond', 0);

-- Insert 10 data of resort into the customer table
INSERT INTO `customer` (`customer_type_id`, `name`, `gender`, `date_of_birth`, `id_card_number`, `phone_number`,
                        `email_address`, `address`, `position_id`, `division_id`, `education_degree_id`, `is_delete`)
VALUES
 (1, 'Nguyen Van A', 1, '1990-01-01', '123456789012', '0123456789', 'test@gmail.com', 'Hanoi', 1, 1, 3, 0),
 (2, 'Nguyen Van B', 1, '1991-01-01', '123456789013', '0123456788', 'test2@gmail.com', 'Hanoi', 2, 2, 2, 0),
 (4, 'Nguyen Van C', 1, '1992-01-01', '123456789014', '0123456787', 'test3@gmail.com', 'Vinh', 3, 3, 1, 0),
 (4, 'Nguyen Van D', 1, '1993-01-01', '123456789015', '0123456786', 'test4@gmail.com', 'Quang Ngai', 1, 1, 3, 0),
 (2, 'Nguyen Van E', 1, '1994-01-01', '123456789016', '0123456785', 'test5@gmail.com', 'Vinh', 2, 2, 2, 0),
 (3, 'Nguyen Van F', 1, '1995-01-01', '123456789017', '0123456784', 'test6@gmail.com', 'Hanoi', 3, 3, 1, 0),
 (1, 'Nguyen Van G', 1, '1996-01-01', '123456789018', '0123456783', 'test7@gmail.com', 'Quang Ngai', 1, 1, 3, 0),
 (2, 'Nguyen Van H', 1, '1997-01-01', '123456789019', '0123456782', 'test8@gmail.com', 'Ho Chi Minh', 2, 2, 2, 0),
 (3, 'Nguyen Van I', 1, '1998-01-01', '123456789020', '0123456781', 'test9@gmail.com', 'Ho Chi Minh', 3, 3, 1, 0),
 (1, 'Nguyen Van K', 1, '1999-01-01', '123456789021', '0123456780', 'test10@gmail.com', 'Ho Chi Minh', 1, 1, 3, 0),
 (1, 'Tran Van A', 1, '1990-01-01', '123456789012', '0123456789', 'tran11@gmail.com', 'Saigon', 1, 1, 3, 0),
 (2, 'Tran Van B', 1, '1991-01-01', '123456789013', '0123456788', 'tran12@gmail.com', 'Quang Nam', 2, 2, 2, 0);

-- Insert 3 data of resort into the user table
INSERT INTO `user` (`user_name`, `password`, `is_delete`)
VALUES
 ('admin', 'admin', 0),
 ('staff', 'staff', 0),
 ('intern', 'intern', 0);

-- Insert 10 data of resort into the role table
INSERT INTO `role` (`role_id`, `role_name`, `is_delete`)
VALUES
 (1, 'Admin', 0),
 (2, 'Staff', 0),
 (3, 'Intern', 0);

-- Insert 3 data of resort into the user_role table
INSERT INTO `user_role` (`user_name`, `role_id`, `is_delete`)
VALUES
 ('admin', 1, 0),
 ('staff', 2, 0),
 ('intern', 3, 0);

-- Insert 10 data of resort into the employee table
INSERT INTO `employee` (`name`, `date_of_birth`, `id_card`, `salary`, `phone_number`, `email`, `address`, `position_id`, `education_degree_id`, `division_id`, `user_name`, `is_delete`)
VALUES
 ('John Doe', '1990-01-01', '1234567890', 5000, '1234567890', 'john.doe@example.com', '123 Main St', 1, 1, 1, 'admin', 0),
 ('Kane', '1990-01-01', '1234567890', 5000, '1234567890', 'kane.doe@example.com', '123 Main St', 1, 1, 1, 'admin', 0),
 ('Tane Doe', '1991-01-01', '1234567891', 4000, '1234567891', 'john.doe@example.com', '123 Main St', 2, 2, 2, 'staff', 0),
 ('John Smith', '1992-01-01', '1234567892', 3000, '1234567892', 'john.doe@example.com', '123 Main St', 3, 3, 3, 'intern', 0);

-- Insert 10 data of resort into the facility_type table
INSERT INTO `facility_type` (`name`, `is_delete`)
VALUES
 ('Room', 0),
 ('Service', 0),
 ('Food', 0);

-- Insert 10 data of resort into the rent_type table
INSERT INTO `rent_type` (`name`, `is_delete`)
VALUES
 ('Hour', 0),
 ('Day', 0),
 ('Month', 0);

-- Insert 10 data of resort into the facility table
INSERT INTO `facility` (`name`, `area`, `cost`, `max_people`, `rent_type_id`, `facility_type_id`, `standard_room`, `description_other_convenience`, `pool_area`, `number_of_floors`, `facility_tree`, `is_delete`)
VALUES
 ('Room 1', 100, 100000, 2, 1, 1, 'Standard', 'Good', 50, 2, 'Tree', 0),
 ('Room 2', 200, 200000, 4, 2, 2, 'Standard', 'Good', 50, 2, 'Tree', 0),
 ('Room 3', 300, 300000, 6, 3, 3, 'Standard', 'Good', 50, 2, 'Tree', 0),
 ('Room 4', 400, 400000, 8, 1, 1, 'Standard', 'Good', 50, 2, 'Tree', 0),
 ('Room 5', 500, 500000, 10, 2, 2, 'Standard', 'Good', 50, 2, 'Tree', 0),
 ('Room 6', 600, 600000, 12, 3, 3, 'Standard', 'Good', 50, 2, 'Tree', 0),
 ('Room 7', 700, 700000, 14, 1, 1, 'Standard', 'Good', 50, 2, 'Tree', 0),
 ('Room 8', 800, 800000, 16, 2, 2, 'Standard', 'Good', 50, 2, 'Tree', 0),
 ('Room 9', 900, 900000, 18, 3, 3, 'Standard', 'Good', 50, 2, 'Tree', 0),
 ('Room 10', 1000, 1000000, 20, 1, 1, 'Standard', 'Good', 50, 2, 'Tree', 0);

-- Insert 10 data of resort into the contract table
INSERT INTO `contract` (`start_date`, `end_date`, `deposit`, `employee_id`, `customer_id`, `facility_id`, `is_delete`)
VALUES
 ('2022-01-01', '2022-01-02', 1000000, 1, 1, 1, 0),
 ('2023-02-01', '2023-02-02', 1000000, 4, 2, 2, 0),
 ('2024-03-01', '2024-03-02', 1000000, 2, 5, 3, 0),
 ('2022-04-01', '2022-04-02', 1000000, 1, 4, 4, 0),
 ('2023-05-01', '2023-05-02', 1000000, 2, 5, 1, 0),
 ('2024-06-01', '2024-06-02', 1000000, 1, 2, 6, 0),
 ('2022-07-01', '2022-07-02', 1000000, 4, 5, 1, 0),
 ('2023-08-01', '2023-08-02', 1000000, 2, 8, 8, 0),
 ('2024-09-01', '2024-09-02', 1000000, 1, 2, 1, 0),
 ('2022-10-01', '2022-10-02', 1000000, 4, 5, 10, 0);

-- Insert 10 data of resort into the contract_detail table
INSERT INTO `contract_detail` (`contract_id`, `attach_facility_id`, `quantity`, `is_delete`)
VALUES
 (1, 1, 1, 0),
 (2, 2, 1, 0),
 (3, 3, 1, 0),
 (4, 4, 1, 0),
 (5, 5, 1, 0),
 (6, 6, 1, 0),
 (7, 7, 1, 0),
 (8, 8, 1, 0),
 (9, 9, 1, 0),
 (10, 10, 1, 0);