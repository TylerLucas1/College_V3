-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema af25nathm1_collegev2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema af25nathm1_collegev2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `af25nathm1_collegev2` ;
USE `af25nathm1_collegev2` ;

-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`building` (
  `building_id` INT(11) NOT NULL AUTO_INCREMENT,
  `building_name` VARCHAR(255) NULL DEFAULT NULL,
  `building_room_number` INT(11) NULL DEFAULT NULL,
  `building_room_capacity` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`building_id`),
  INDEX `BUILDING_NAME` (`building_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`course` (
  `course_id` INT(11) NOT NULL AUTO_INCREMENT,
  `course_name` VARCHAR(255) NULL DEFAULT NULL,
  `course_credit_hours` INT(11) NULL DEFAULT NULL,
  `course_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `course_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  PRIMARY KEY (`course_id`),
  INDEX `course_name` (`course_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`lookup_employee_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`lookup_employee_role` (
  `lookup_employee_role_id` INT(11) NOT NULL AUTO_INCREMENT,
  `lookup_employee_role_name` VARCHAR(255) NULL DEFAULT NULL,
  `lookup_employee_role_security_level` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`lookup_employee_role_id`),
  INDEX `role` (`lookup_employee_role_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 9;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`employee` (
  `employee_id` INT(11) NOT NULL AUTO_INCREMENT,
  `employee_start_date` DATE NULL DEFAULT NULL,
  `employee_end_date` DATE NULL DEFAULT NULL,
  `employee_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `employee_edited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `lookup_employee_role_id` INT(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_lookup_employee_role1_idx` (`lookup_employee_role_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_lookup_employee_role1`
    FOREIGN KEY (`lookup_employee_role_id`)
    REFERENCES `af25nathm1_collegev2`.`lookup_employee_role` (`lookup_employee_role_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`department` (
  `department_id` INT(11) NOT NULL,
  `department_name` VARCHAR(255) NULL DEFAULT NULL,
  `department_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `department_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `department_name` (`department_name` ASC) VISIBLE,
  INDEX `fk_department_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `af25nathm1_collegev2`.`employee` (`employee_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`course_has_department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`course_has_department` (
  `department_id` INT(11) NOT NULL,
  `course_id` INT(11) NOT NULL,
  INDEX `fk_course_has_department_department1_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_course_has_department_course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_has_department_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `af25nathm1_collegev2`.`course` (`course_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_course_has_department_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `af25nathm1_collegev2`.`department` (`department_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`lookup_grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`lookup_grade` (
  `lookup_grade_id` INT(11) NOT NULL AUTO_INCREMENT,
  `lookup_grade_letter` VARCHAR(255) NULL DEFAULT NULL,
  `lookup_grade_point_value` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`lookup_grade_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`semester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`semester` (
  `semester_id` INT(11) NOT NULL,
  `semester_season` VARCHAR(255) NULL DEFAULT NULL,
  `audit_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`semester_id`),
  INDEX `semester_season` (`semester_season` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`student` (
  `student_id` INT(11) NOT NULL AUTO_INCREMENT,
  `student_admission_date` DATE NULL DEFAULT NULL,
  `student_graduation_date` DATE NULL DEFAULT NULL,
  `student_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `faculty_edited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`enrollment` (
  `enrollment_id` INT(11) NOT NULL AUTO_INCREMENT,
  `enrollment_status` VARCHAR(255) NULL DEFAULT NULL,
  `enrolment_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `enrollment_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `student_student_id` INT(11) NOT NULL,
  `semester_id` INT(11) NOT NULL,
  `lookup_grade_id` INT(11) NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `fk_enrollment_student1_idx` (`student_student_id` ASC) VISIBLE,
  INDEX `fk_enrollment_semester1_idx` (`semester_id` ASC) VISIBLE,
  INDEX `fk_enrollment_lookup_grade1_idx` (`lookup_grade_id` ASC) VISIBLE,
  CONSTRAINT `fk_enrollment_lookup_grade1`
    FOREIGN KEY (`lookup_grade_id`)
    REFERENCES `af25nathm1_collegev2`.`lookup_grade` (`lookup_grade_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_enrollment_semester1`
    FOREIGN KEY (`semester_id`)
    REFERENCES `af25nathm1_collegev2`.`semester` (`semester_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_enrollment_student1`
    FOREIGN KEY (`student_student_id`)
    REFERENCES `af25nathm1_collegev2`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`section` (
  `section_id` INT(11) NOT NULL AUTO_INCREMENT,
  `section_days` VARCHAR(255) NULL DEFAULT NULL,
  `section_times` VARCHAR(255) NULL DEFAULT NULL,
  `section_delivery_method` VARCHAR(255) NULL DEFAULT NULL,
  `course_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  `student_id` INT(11) NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_section_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `af25nathm1_collegev2`.`course` (`course_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_section_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `af25nathm1_collegev2`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_section_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `af25nathm1_collegev2`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`room` (
  `room_id` INT(11) NOT NULL AUTO_INCREMENT,
  `room_name` VARCHAR(255) NULL DEFAULT NULL,
  `room_capacity` INT(11) NULL DEFAULT NULL,
  `room_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_user_id` INT(11) NOT NULL,
  `room_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `section_id` INT(11) NOT NULL,
  `student_id` INT(11) NOT NULL,
  `building_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`room_id`),
  INDEX `fk_room_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_room_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_room_building1_idx` (`building_id` ASC) VISIBLE,
  INDEX `fk_room_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_room_building1`
    FOREIGN KEY (`building_id`)
    REFERENCES `af25nathm1_collegev2`.`building` (`building_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `af25nathm1_collegev2`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `af25nathm1_collegev2`.`section` (`section_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `af25nathm1_collegev2`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev2`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev2`.`user` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_fname` VARCHAR(255) NULL DEFAULT NULL,
  `user_lname` VARCHAR(255) NULL DEFAULT NULL,
  `user_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `audit_id` INT(11) NOT NULL,
  `user_audited` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
  `employee_employee_id` INT(11) NULL DEFAULT NULL,
  `student_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_user_employee_idx` (`employee_employee_id` ASC) VISIBLE,
  INDEX `first_name` (`user_fname` ASC) VISIBLE,
  INDEX `last_name` (`user_lname` ASC) VISIBLE,
  INDEX `fk_user_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_employee`
    FOREIGN KEY (`employee_employee_id`)
    REFERENCES `af25nathm1_collegev2`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `af25nathm1_collegev2`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;

-- ---------------------------
-- Employees (continued, total 60)
-- ---------------------------
INSERT INTO employee (employee_start_date, employee_end_date, audit_user_id, lookup_employee_role_id) VALUES
('2020-05-05', NULL, 1, 1),
('2020-06-06', NULL, 1, 2),
('2020-07-07', NULL, 2, 3),
('2020-08-08', NULL, 2, 4),
('2020-09-09', NULL, 3, 1),
('2020-10-10', NULL, 3, 2),
('2020-11-11', NULL, 4, 3),
('2020-12-12', NULL, 4, 4),
('2021-01-01', NULL, 1, 1),
('2021-02-02', NULL, 1, 2),
('2021-03-03', NULL, 2, 3),
('2021-04-04', NULL, 2, 4),
('2021-05-05', NULL, 3, 1),
('2021-06-06', NULL, 3, 2),
('2021-07-07', NULL, 4, 3),
('2021-08-08', NULL, 4, 4),
('2021-09-09', NULL, 1, 1),
('2021-10-10', NULL, 1, 2),
('2021-11-11', NULL, 2, 3),
('2021-12-12', NULL, 2, 4);

-- ---------------------------
-- Students (50)
-- ---------------------------
INSERT INTO student (student_admission_date, student_graduation_date, audit_user_id) VALUES
('2019-08-20', '2023-05-15', 1),
('2020-01-15', NULL, 2),
('2020-09-01', NULL, 3),
('2021-01-10', NULL, 4),
('2021-08-20', NULL, 1),
('2022-01-15', NULL, 2),
('2022-09-01', NULL, 3),
('2023-01-10', NULL, 4),
('2023-08-20', NULL, 1),
('2024-01-15', NULL, 2),
('2024-09-01', NULL, 3),
('2025-01-10', NULL, 4),
('2020-08-20', NULL, 1),
('2021-08-20', NULL, 2),
('2022-08-20', NULL, 3),
('2023-08-20', NULL, 4),
('2019-01-10', '2022-05-15', 1),
('2019-08-20', '2023-05-15', 2),
('2020-01-15', NULL, 3),
('2020-09-01', NULL, 4),
('2021-01-10', NULL, 1),
('2021-08-20', NULL, 2),
('2022-01-15', NULL, 3),
('2022-09-01', NULL, 4),
('2023-01-10', NULL, 1),
('2023-08-20', NULL, 2),
('2024-01-15', NULL, 3),
('2024-09-01', NULL, 4),
('2025-01-10', NULL, 1),
('2020-05-05', NULL, 2),
('2020-06-06', NULL, 3),
('2020-07-07', NULL, 4),
('2020-08-08', NULL, 1),
('2020-09-09', NULL, 2),
('2020-10-10', NULL, 3),
('2020-11-11', NULL, 4),
('2020-12-12', NULL, 1),
('2021-01-01', NULL, 2),
('2021-02-02', NULL, 3),
('2021-03-03', NULL, 4),
('2021-04-04', NULL, 1),
('2021-05-05', NULL, 2),
('2021-06-06', NULL, 3),
('2021-07-07', NULL, 4),
('2021-08-08', NULL, 1),
('2021-09-09', NULL, 2),
('2021-10-10', NULL, 3),
('2021-11-11', NULL, 4),
('2021-12-12', NULL, 1);

-- ---------------------------
-- Additional Courses (20)
-- ---------------------------
INSERT INTO course (course_name, course_credit_hours, audit_user_id) VALUES
('Data Structures', 3, 1),
('Algorithms', 3, 1),
('Software Engineering', 3, 2),
('Artificial Intelligence', 3, 2),
('Machine Learning', 3, 3),
('Operating Systems', 4, 3),
('Database Design', 3, 4),
('Network Security', 3, 4),
('Calculus II', 4, 1),
('Statistics', 3, 1),
('Linear Programming', 3, 2),
('Econometrics', 3, 2),
('Philosophy 101', 3, 3),
('Sociology', 3, 3),
('Political Science', 3, 4),
('Psychology 201', 3, 4),
('Cognitive Science', 3, 1),
('Web Development', 3, 2),
('Mobile App Development', 3, 3),
('Game Development', 3, 4);

-- ---------------------------
-- Departments (10)
-- ---------------------------
INSERT INTO department (department_id, department_name, audit_user_id, employee_id) VALUES
(107, 'Engineering', 1, 5),
(108, 'Physics', 2, 6),
(109, 'Chemistry', 3, 7),
(110, 'Biology', 4, 8),
(111, 'Philosophy', 1, 9),
(112, 'Sociology', 2, 10),
(113, 'Political Science', 3, 11),
(114, 'Psychology', 4, 12),
(115, 'Cognitive Science', 1, 13),
(116, 'Information Technology', 2, 14);

-- ---------------------------
-- Sections (30)
-- ---------------------------
INSERT INTO section (section_days, section_times, section_delivery_method, course_id, employee_id, student_id) VALUES
('MWF', '09:00-09:50', 'In-Person', 1, 1, 1),
('TTh', '10:00-11:15', 'Online', 2, 2, 2),
('MWF', '13:00-13:50', 'Hybrid', 3, 3, 3),
('TTh', '15:00-16:15', 'In-Person', 4, 4, 4),
('MWF', '08:00-08:50', 'In-Person', 5, 5, 5),
('TTh', '12:00-13:15', 'Hybrid', 6, 6, 6),
('MWF', '10:00-10:50', 'Online', 7, 7, 7),
('TTh', '13:00-14:15', 'In-Person', 8, 8, 8),
('MWF', '09:00-09:50', 'Hybrid', 9, 9, 9),
('TTh', '14:00-15:15', 'Online', 10, 10, 10),
('MWF', '11:00-11:50', 'In-Person', 11, 11, 11),
('TTh', '10:00-11:15', 'Hybrid', 12, 12, 12),
('MWF', '13:00-13:50', 'Online', 13, 13, 13),
('TTh', '15:00-16:15', 'In-Person', 14, 14, 14),
('MWF', '08:00-08:50', 'Hybrid', 15, 15, 15),
('TTh', '12:00-13:15', 'Online', 16, 16, 16),
('MWF', '10:00-10:50', 'In-Person', 17, 17, 17),
('TTh', '13:00-14:15', 'Hybrid', 18, 18, 18),
('MWF', '09:00-09:50', 'Online', 19, 19, 19),
('TTh', '14:00-15:15', 'In-Person', 20, 20, 20),
('MWF', '11:00-11:50', 'Hybrid', 21, 21, 21),
('TTh', '10:00-11:15', 'Online', 22, 22, 22),
('MWF', '13:00-13:50', 'In-Person', 23, 23, 23),
('TTh', '15:00-16:15', 'Hybrid', 24, 24, 24),
('MWF', '08:00-08:50', 'Online', 25, 25, 25),
('TTh', '12:00-13:15', 'In-Person', 26, 26, 26),
('MWF', '10:00-10:50', 'Hybrid', 27, 27, 27),
('TTh', '13:00-14:15', 'Online', 28, 28, 28),
('MWF', '09:00-09:50', 'In-Person', 29, 29, 29),
('TTh', '14:00-15:15', 'Hybrid', 30, 30, 30);

-- -----------------------------------------------------
-- Rooms (20)
-- -----------------------------------------------------
INSERT INTO building (building_name, building_room_number, building_room_capacity) VALUES
('Engineering Hall', 101, 50),
('Physics Lab', 102, 40),
('Chemistry Lab', 103, 35),
('Biology Hall', 104, 45),
('Philosophy Hall', 105, 30),
('Sociology Center', 106, 40),
('Political Science Hall', 107, 50),
('Psychology Lab', 108, 35),
('Cognitive Science Hall', 109, 45),
('IT Center', 110, 60);

INSERT INTO room (room_name, room_capacity, audit_user_id, section_id, student_id, building_id, employee_id) VALUES
('Eng 101A', 50, 1, 1, 1, 1, 1),
('Physics 102B', 40, 2, 2, 2, 2, 2),
('Chem 103C', 35, 3, 3, 3, 3, 3),
('Bio 104D', 45, 4, 4, 4, 4, 4),
('Phil 105E', 30, 1, 5, 5, 5, 5),
('Soc 106F', 40, 2, 6, 6, 6, 6),
('Pol 107G', 50, 3, 7, 7, 7, 7),
('Psych 108H', 35, 4, 8, 8, 8, 8),
('CogSci 109I', 45, 1, 9, 9, 9, 9),
('IT 110J', 60, 2, 10, 10, 10, 10),
('Eng 101B', 50, 3, 11, 11, 1, 11),
('Physics 102C', 40, 4, 12, 12, 2, 12),
('Chem 103D', 35, 1, 13, 13, 3, 13),
('Bio 104E', 45, 2, 14, 14, 4, 14),
('Phil 105F', 30, 3, 15, 15, 5, 15),
('Soc 106G', 40, 4, 16, 16, 6, 16),
('Pol 107H', 50, 1, 17, 17, 7, 17),
('Psych 108I', 35, 2, 18, 18, 8, 18),
('CogSci 109J', 45, 3, 19, 19, 9, 19),
('IT 110K', 60, 4, 20, 20, 10, 20);

-- -----------------------------------------------------
-- Enrollments (50)
-- -----------------------------------------------------
INSERT INTO enrollment (enrollment_status, audit_user_id, student_student_id, semester_id, lookup_grade_id) VALUES
('Active', 1, 1, 1, 1),
('Completed', 2, 2, 1, 2),
('Active', 3, 3, 1, 1),
('Withdrawn', 4, 4, 1, 5),
('Active', 1, 5, 2, 2),
('Completed', 2, 6, 2, 3),
('Active', 3, 7, 2, 1),
('Withdrawn', 4, 8, 2, 4),
('Active', 1, 9, 1, 2),
('Completed', 2, 10, 1, 3),
('Active', 3, 11, 2, 1),
('Withdrawn', 4, 12, 2, 5),
('Active', 1, 13, 1, 2),
('Completed', 2, 14, 1, 3),
('Active', 3, 15, 2, 1),
('Withdrawn', 4, 16, 2, 4),
('Active', 1, 17, 1, 2),
('Completed', 2, 18, 1, 3),
('Active', 3, 19, 2, 1),
('Withdrawn', 4, 20, 2, 5),
('Active', 1, 21, 1, 2),
('Completed', 2, 22, 1, 3),
('Active', 3, 23, 2, 1),
('Withdrawn', 4, 24, 2, 4),
('Active', 1, 25, 1, 2),
('Completed', 2, 26, 1, 3),
('Active', 3, 27, 2, 1),
('Withdrawn', 4, 28, 2, 4),
('Active', 1, 29, 1, 2),
('Completed', 2, 30, 1, 3),
('Active', 3, 31, 2, 1),
('Withdrawn', 4, 32, 2, 4),
('Active', 1, 33, 1, 2),
('Completed', 2, 34, 1, 3),
('Active', 3, 35, 2, 1),
('Withdrawn', 4, 36, 2, 4),
('Active', 1, 37, 1, 2),
('Completed', 2, 38, 1, 3),
('Active', 3, 39, 2, 1),
('Withdrawn', 4, 40, 2, 4),
('Active', 1, 41, 1, 2),
('Completed', 2, 42, 1, 3),
('Active', 3, 43, 2, 1),
('Withdrawn', 4, 44, 2, 4),
('Active', 1, 45, 1, 2),
('Completed', 2, 46, 1, 3),
('Active', 3, 47, 2, 1),
('Withdrawn', 4, 48, 2, 4),
('Active', 1, 49, 1, 2),
('Completed', 2, 50, 1, 3);

-- -----------------------------------------------------
-- Users (110)
-- -----------------------------------------------------
INSERT INTO user (user_fname, user_lname, audit_id, employee_employee_id, student_id) VALUES
('Alice','Johnson',1,1,NULL),
('Bob','Smith',2,2,NULL),
('Charlie','Brown',3,NULL,1),
('Diana','Lopez',4,NULL,2),
('Ethan','Wright',1,3,NULL),
('Fiona','Hall',2,4,NULL),
('George','Adams',3,NULL,3),
('Hannah','Scott',4,NULL,4),
('Isaac','Green',1,5,NULL),
('Jasmine','Lee',2,6,NULL),
('Kevin','Clark',3,NULL,5),
('Lily','Evans',4,NULL,6),
('Mason','Turner',1,7,NULL),
('Nora','Perry',2,8,NULL),
('Owen','Collins',3,NULL,7),
('Paige','Mitchell',4,NULL,8),
('Quinn','Roberts',1,9,NULL),
('Riley','Carter',2,10,NULL),
('Sophia','Bennett',3,NULL,9),
('Tyler','Gray',4,NULL,10),
('Uma','Hughes',1,11,NULL),
('Victor','Murphy',2,12,NULL),
('Wendy','Foster',3,NULL,11),
('Xander','Diaz',4,NULL,12),
('Yara','Price',1,13,NULL),
('Zane','Russell',2,14,NULL),
('Abby','Jordan',3,NULL,13),
('Blake','Reed',4,NULL,14),
('Cara','Watson',1,15,NULL),
('Dante','Kelly',2,16,NULL),
('Ella','Bryant',3,NULL,15),
('Finn','Howard',4,NULL,16),
('Gina','Sanders',1,17,NULL),
('Hugo','Powell',2,18,NULL),
('Ivy','Bates',3,NULL,17),
('Jack','Hunt',4,NULL,18);
('Oliver','King',1,1,NULL),
('Emma','Scott',1,2,NULL),
('Noah','Reed',1,3,NULL),
('Ava','Murphy',1,4,NULL),
('Liam','Brooks',1,5,NULL),
('Sophia','Jenkins',1,6,NULL),
('Mason','Perez',1,7,NULL),
('Isabella','Long',1,8,NULL),
('Lucas','Cruz',1,9,NULL),
('Mia','Reynolds',1,10,NULL),
('Ethan','Bell',1,11,NULL),
('Harper','Cole',1,12,NULL),
('James','Woods',1,13,NULL),
('Amelia','Fisher',1,14,NULL),
('Benjamin','Warren',1,15,NULL),
('Evelyn','Hart',1,16,NULL),
('Logan','Santos',1,17,NULL),
('Abigail','Patterson',1,18,NULL),
('Caleb','Gomez',1,19,NULL),
('Ella','Morris',1,20,NULL),
('Oliver','Reyes',1,21,NULL),
('Scarlett','Hunt',1,22,NULL),
('Jacob','Wang',1,23,NULL),
('Luna','Flores',1,24,NULL),
('Daniel','Khan',1,25,NULL),
('Grace','Kim',1,26,NULL),
('Henry','Nguyen',1,27,NULL),
('Zoe','Park',1,28,NULL),
('Owen','Diaz',1,29,NULL),
('Addison','Foster',1,30,NULL);
('Alice','Johnson',1,NULL,1),
('Bob','Smith',1,NULL,2),
('Charlie','Brown',1,NULL,3),
('Diana','Lopez',1,NULL,4),
('Ethan','Wright',1,NULL,5),
('Fiona','Hall',1,NULL,6),
('George','Adams',1,NULL,7),
('Hannah','Scott',1,NULL,8),
('Isaac','Green',1,NULL,9),
('Jasmine','Lee',1,NULL,10),
('Kevin','Clark',1,NULL,11),
('Lily','Evans',1,NULL,12),
('Mason','Turner',1,NULL,13),
('Nora','Perry',1,NULL,14),
('Owen','Collins',1,NULL,15),
('Paige','Mitchell',1,NULL,16),
('Quinn','Roberts',1,NULL,17),
('Riley','Carter',1,NULL,18),
('Sophia','Bennett',1,NULL,19),
('Tyler','Gray',1,NULL,20),
('Uma','Hughes',1,NULL,21),
('Victor','Murphy',1,NULL,22),
('Wendy','Foster',1,NULL,23),
('Xander','Diaz',1,NULL,24),
('Yara','Price',1,NULL,25),
('Zane','Russell',1,NULL,26),
('Abby','Jordan',1,NULL,27),
('Blake','Reed',1,NULL,28),
('Cara','Watson',1,NULL,29),
('Dante','Kelly',1,NULL,30),
('Ella','Bryant',1,NULL,31),
('Finn','Howard',1,NULL,32),
('Gina','Sanders',1,NULL,33),
('Hugo','Powell',1,NULL,34),
('Ivy','Bates',1,NULL,35),
('Jack','Hunt',1,NULL,36);



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
