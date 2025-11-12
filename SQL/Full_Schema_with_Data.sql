-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema af25nathm1_collegev3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema af25nathm1_collegev3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `af25nathm1_collegev3` ;
USE `af25nathm1_collegev3` ;

-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`building` (
  `building_id` INT(11) NOT NULL AUTO_INCREMENT,
  `building_name` VARCHAR(255) NULL DEFAULT NULL,
  `building_room_number` INT(11) NULL DEFAULT NULL,
  `building_room_capacity` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`building_id`),
  INDEX `BUILDING_NAME` (`building_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`course` (
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
-- Table `af25nathm1_collegev3`.`lookup_employee_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`lookup_employee_role` (
  `lookup_employee_role_id` INT(11) NOT NULL AUTO_INCREMENT,
  `lookup_employee_role_name` VARCHAR(255) NULL DEFAULT NULL,
  `lookup_employee_role_security_level` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`lookup_employee_role_id`),
  INDEX `role` (`lookup_employee_role_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 9;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`employee` (
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
    REFERENCES `af25nathm1_collegev3`.`lookup_employee_role` (`lookup_employee_role_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 9;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`department` (
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
    REFERENCES `af25nathm1_collegev3`.`employee` (`employee_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`course_has_department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`course_has_department` (
  `department_id` INT(11) NOT NULL,
  `course_id` INT(11) NOT NULL,
  INDEX `fk_course_has_department_department1_idx` (`department_id` ASC) VISIBLE,
  INDEX `fk_course_has_department_course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_has_department_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `af25nathm1_collegev3`.`course` (`course_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_course_has_department_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `af25nathm1_collegev3`.`department` (`department_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`lookup_grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`lookup_grade` (
  `lookup_grade_id` INT(11) NOT NULL AUTO_INCREMENT,
  `lookup_grade_letter` VARCHAR(255) NULL DEFAULT NULL,
  `lookup_grade_point_value` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`lookup_grade_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`semester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`semester` (
  `semester_id` INT(11) NOT NULL,
  `semester_season` VARCHAR(255) NULL DEFAULT NULL,
  `audit_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`semester_id`),
  INDEX `semester_season` (`semester_season` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`student` (
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
-- Table `af25nathm1_collegev3`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`enrollment` (
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
    REFERENCES `af25nathm1_collegev3`.`lookup_grade` (`lookup_grade_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_enrollment_semester1`
    FOREIGN KEY (`semester_id`)
    REFERENCES `af25nathm1_collegev3`.`semester` (`semester_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_enrollment_student1`
    FOREIGN KEY (`student_student_id`)
    REFERENCES `af25nathm1_collegev3`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`section` (
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
    REFERENCES `af25nathm1_collegev3`.`course` (`course_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_section_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `af25nathm1_collegev3`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_section_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `af25nathm1_collegev3`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`room` (
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
    REFERENCES `af25nathm1_collegev3`.`building` (`building_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `af25nathm1_collegev3`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `af25nathm1_collegev3`.`section` (`section_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `af25nathm1_collegev3`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;


-- -----------------------------------------------------
-- Table `af25nathm1_collegev3`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `af25nathm1_collegev3`.`user` (
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
    REFERENCES `af25nathm1_collegev3`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `af25nathm1_collegev3`.`student` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5;

-- ---------------------------
-- Reference data: roles, grades, semesters
-- ---------------------------
INSERT INTO lookup_employee_role (lookup_employee_role_id, lookup_employee_role_name, lookup_employee_role_security_level) VALUES
(1, 'Administrator', 90),
(2, 'Registrar', 70),
(3, 'Professor', 50),
(4, 'Instructor', 40),
(5, 'Teaching Assistant', 20);

INSERT INTO lookup_grade (lookup_grade_id, lookup_grade_letter, lookup_grade_point_value) VALUES
(1, 'A', 4),
(2, 'B', 3),
(3, 'C', 2),
(4, 'D', 1),
(5, 'F', 0);

INSERT INTO semester (semester_id, semester_season, audit_user_id) VALUES
(1, 'Fall 2023', 1),
(2, 'Spring 2024', 1),
(3, 'Fall 2024', 1);

-- ---------------------------
-- Employees (20) - explicit IDs for FK stability
-- ---------------------------
INSERT INTO employee (employee_id, employee_start_date, audit_user_id, lookup_employee_role_id) VALUES
(1, '2015-08-01', 1, 1),
(2, '2016-09-15', 1, 2),
(3, '2017-01-10', 1, 3),
(4, '2018-07-01', 1, 4),
(5, '2018-09-01', 1, 3),
(6, '2019-01-15', 1, 4),
(7, '2019-08-20', 1, 3),
(8, '2020-02-01', 1, 4),
(9, '2020-08-01', 1, 3),
(10, '2021-01-05', 1, 4),
(11, '2021-07-10', 1, 5),
(12, '2022-01-20', 1, 5),
(13, '2022-08-15', 1, 4),
(14, '2023-01-10', 1, 4),
(15, '2016-03-12', 1, 3),
(16, '2017-04-22', 1, 3),
(17, '2018-05-30', 1, 4),
(18, '2019-06-14', 1, 4),
(19, '2020-11-11', 1, 5),
(20, '2021-12-01', 1, 5);

-- ---------------------------
-- Students (50)
-- ---------------------------
INSERT INTO student (student_id, student_admission_date, student_graduation_date, audit_user_id) VALUES
(1, '2018-08-20', '2022-05-15', 1),
(2, '2019-01-15', NULL, 1),
(3, '2019-08-30', NULL, 1),
(4, '2020-01-10', NULL, 1),
(5, '2020-08-21', NULL, 1),
(6, '2021-01-12', NULL, 1),
(7, '2021-08-19', NULL, 1),
(8, '2022-01-09', NULL, 1),
(9, '2022-08-22', NULL, 1),
(10, '2023-01-10', NULL, 1),
(11, '2023-08-25', NULL, 1),
(12, '2024-01-16', NULL, 1),
(13, '2020-08-20', NULL, 1),
(14, '2020-09-10', NULL, 1),
(15, '2021-02-14', NULL, 1),
(16, '2021-03-01', NULL, 1),
(17, '2019-08-20', '2023-05-15', 1),
(18, '2019-09-01', '2023-12-15', 1),
(19, '2018-01-10', '2021-05-15', 1),
(20, '2020-05-05', NULL, 1),
(21, '2020-06-06', NULL, 1),
(22, '2020-07-07', NULL, 1),
(23, '2020-08-08', NULL, 1),
(24, '2020-09-09', NULL, 1),
(25, '2020-10-10', NULL, 1),
(26, '2020-11-11', NULL, 1),
(27, '2020-12-12', NULL, 1),
(28, '2021-01-01', NULL, 1),
(29, '2021-02-02', NULL, 1),
(30, '2021-03-03', NULL, 1),
(31, '2021-04-04', NULL, 1),
(32, '2021-05-05', NULL, 1),
(33, '2021-06-06', NULL, 1),
(34, '2021-07-07', NULL, 1),
(35, '2021-08-08', NULL, 1),
(36, '2021-09-09', NULL, 1),
(37, '2021-10-10', NULL, 1),
(38, '2021-11-11', NULL, 1),
(39, '2021-12-12', NULL, 1),
(40, '2022-02-14', NULL, 1),
(41, '2022-03-20', NULL, 1),
(42, '2022-04-01', NULL, 1),
(43, '2022-05-15', NULL, 1),
(44, '2022-06-30', NULL, 1),
(45, '2022-07-22', NULL, 1),
(46, '2022-08-18', NULL, 1),
(47, '2023-01-11', NULL, 1),
(48, '2023-03-07', NULL, 1),
(49, '2023-05-09', NULL, 1),
(50, '2023-09-01', NULL, 1);

-- ---------------------------
-- Courses (30)
-- ---------------------------
INSERT INTO course (course_id, course_name, course_credit_hours, audit_user_id) VALUES
(1, 'Intro to Programming', 3, 1),
(2, 'Data Structures', 3, 1),
(3, 'Algorithms', 3, 1),
(4, 'Databases', 3, 1),
(5, 'Operating Systems', 4, 1),
(6, 'Computer Networks', 3, 1),
(7, 'Software Engineering', 3, 1),
(8, 'Artificial Intelligence', 3, 1),
(9, 'Machine Learning', 3, 1),
(10, 'Calculus I', 4, 1),
(11, 'Calculus II', 4, 1),
(12, 'Statistics', 3, 1),
(13, 'Linear Algebra', 3, 1),
(14, 'Physics I', 4, 1),
(15, 'Chemistry I', 4, 1),
(16, 'Biology I', 3, 1),
(17, 'Philosophy 101', 3, 1),
(18, 'Sociology 101', 3, 1),
(19, 'Political Science 101', 3, 1),
(20, 'Psychology 101', 3, 1),
(21, 'Web Development', 3, 1),
(22, 'Mobile App Development', 3, 1),
(23, 'Network Security', 3, 1),
(24, 'Cloud Computing', 3, 1),
(25, 'Game Development', 3, 1),
(26, 'Econometrics', 3, 1),
(27, 'Philosophy 201', 3, 1),
(28, 'Cognitive Science', 3, 1),
(29, 'Ethics in Technology', 3, 1),
(30, 'Human-Computer Interaction', 3, 1);

-- ---------------------------
-- Departments (10)
-- ---------------------------
INSERT INTO department (department_id, department_name, audit_user_id, employee_id) VALUES
(1, 'Computer Science', 1, 3),
(2, 'Engineering', 1, 5),
(3, 'Mathematics', 1, 15),
(4, 'Physics', 1, 14),
(5, 'Chemistry', 1, 16),
(6, 'Biology', 1, 17),
(7, 'Humanities', 1, 4),
(8, 'Social Sciences', 1, 2),
(9, 'Information Technology', 1, 6),
(10, 'Design & Media', 1, 11);

-- ---------------------------
-- Link courses to departments
-- ---------------------------
INSERT INTO course_has_department (department_id, course_id) VALUES
(1,1),(1,2),(1,3),(1,4),(1,7),(1,8),(1,9),(1,21),(1,22),(1,24),
(3,10),(3,11),(3,12),(3,13),(3,26),
(4,14),(4,23),(4,24),
(5,15),(6,16),(7,17),(7,27),(7,29),(8,18),(8,19),(8,20),(9,6),(9,23),(10,25),(10,30);

-- ---------------------------
-- Sections (30)
-- ---------------------------
INSERT INTO section (section_id, section_days, section_times, section_delivery_method, course_id, employee_id, student_id) VALUES
(1, 'MWF', '09:00-09:50', 'In-Person', 1, 3, 1),
(2, 'TTh', '10:00-11:15', 'Online', 2, 5, 2),
(3, 'MWF', '13:00-13:50', 'Hybrid', 3, 15, 3),
(4, 'TTh', '15:00-16:15', 'In-Person', 4, 6, 4),
(5, 'MWF', '08:00-08:50', 'In-Person', 5, 9, 5),
(6, 'TTh', '12:00-13:15', 'Hybrid', 6, 7, 6),
(7, 'MWF', '10:00-10:50', 'Online', 7, 3, 7),
(8, 'TTh', '13:00-14:15', 'In-Person', 8, 5, 8),
(9, 'MWF', '09:00-09:50', 'Hybrid', 9, 15, 9),
(10, 'TTh', '14:00-15:15', 'Online', 10, 16, 10),
(11, 'MWF', '11:00-11:50', 'In-Person', 11, 15, 11),
(12, 'TTh', '10:00-11:15', 'Hybrid', 12, 2, 12),
(13, 'MWF', '13:00-13:50', 'Online', 13, 15, 13),
(14, 'TTh', '15:00-16:15', 'In-Person', 14, 14, 14),
(15, 'MWF', '08:00-08:50', 'Hybrid', 15, 16, 15),
(16, 'TTh', '12:00-13:15', 'Online', 16, 17, 16),
(17, 'MWF', '10:00-10:50', 'In-Person', 17, 4, 17),
(18, 'TTh', '13:00-14:15', 'Hybrid', 18, 2, 18),
(19, 'MWF', '09:00-09:50', 'Online', 19, 2, 19),
(20, 'TTh', '14:00-15:15', 'In-Person', 20, 4, 20),
(21, 'MWF', '11:00-11:50', 'Hybrid', 21, 11, 21),
(22, 'TTh', '10:00-11:15', 'Online', 22, 11, 22),
(23, 'MWF', '13:00-13:50', 'In-Person', 23, 6, 23),
(24, 'TTh', '15:00-16:15', 'Hybrid', 24, 6, 24),
(25, 'MWF', '08:00-08:50', 'Online', 25, 11, 25),
(26, 'TTh', '12:00-13:15', 'In-Person', 26, 15, 26),
(27, 'MWF', '10:00-10:50', 'Hybrid', 27, 4, 27),
(28, 'TTh', '13:00-14:15', 'Online', 28, 11, 28),
(29, 'MWF', '09:00-09:50', 'In-Person', 29, 4, 29),
(30, 'TTh', '14:00-15:15', 'Hybrid', 30, 11, 30);

-- ---------------------------
-- Buildings (6)
-- ---------------------------
INSERT INTO building (building_id, building_name, building_room_number, building_room_capacity) VALUES
(1, 'Main Hall', 100, 200),
(2, 'Engineering Building', 200, 120),
(3, 'Science Center', 300, 150),
(4, 'Humanities Hall', 400, 80),
(5, 'IT Center', 500, 100),
(6, 'Design Studio', 600, 60);

-- ---------------------------
-- Rooms (20)
-- ---------------------------
INSERT INTO room (room_id, room_name, room_capacity, audit_user_id, section_id, student_id, building_id, employee_id) VALUES
(1, 'MH 101', 120, 1, 1, 1, 1, 3),
(2, 'EB 201', 60, 1, 2, 2, 2, 5),
(3, 'SC 301', 50, 1, 3, 3, 3, 15),
(4, 'SC 302', 40, 1, 4, 4, 3, 6),
(5, 'HH 101', 80, 1, 5, 5, 4, 9),
(6, 'IT 201', 35, 1, 6, 6, 5, 7),
(7, 'DS 101', 30, 1, 7, 7, 6, 3),
(8, 'MH 102', 120, 1, 8, 8, 1, 5),
(9, 'EB 202', 60, 1, 9, 9, 2, 15),
(10, 'SC 303', 45, 1, 10, 10, 3, 16),
(11, 'MH 201', 90, 1, 11, 11, 1, 15),
(12, 'IT 202', 40, 1, 12, 12, 5, 2),
(13, 'HH 102', 35, 1, 13, 13, 4, 15),
(14, 'SC 304', 50, 1, 14, 14, 3, 14),
(15, 'EB 203', 55, 1, 15, 15, 2, 16),
(16, 'DS 102', 28, 1, 16, 16, 6, 17),
(17, 'IT 203', 36, 1, 17, 17, 5, 4),
(18, 'MH 301', 100, 1, 18, 18, 1, 2),
(19, 'SC 305', 42, 1, 19, 19, 3, 2),
(20, 'EB 204', 60, 1, 20, 20, 2, 4);

-- ---------------------------
-- Enrollments (50) - map students to semesters and grades
-- ---------------------------
INSERT INTO enrollment (enrollment_id, enrollment_status, audit_user_id, student_student_id, semester_id, lookup_grade_id) VALUES
(1, 'Active', 1, 1, 3, 1),
(2, 'Completed', 1, 2, 2, 2),
(3, 'Active', 1, 3, 3, 1),
(4, 'Withdrawn', 1, 4, 1, 5),
(5, 'Active', 1, 5, 2, 2),
(6, 'Completed', 1, 6, 2, 3),
(7, 'Active', 1, 7, 3, 1),
(8, 'Withdrawn', 1, 8, 1, 4),
(9, 'Active', 1, 9, 2, 2),
(10, 'Completed', 1, 10, 2, 3),
(11, 'Active', 1, 11, 3, 1),
(12, 'Withdrawn', 1, 12, 1, 5),
(13, 'Active', 1, 13, 3, 2),
(14, 'Completed', 1, 14, 2, 3),
(15, 'Active', 1, 15, 3, 1),
(16, 'Withdrawn', 1, 16, 1, 4),
(17, 'Active', 1, 17, 3, 2),
(18, 'Completed', 1, 18, 2, 3),
(19, 'Active', 1, 19, 3, 1),
(20, 'Withdrawn', 1, 20, 1, 4),
(21, 'Active', 1, 21, 3, 2),
(22, 'Completed', 1, 22, 2, 3),
(23, 'Active', 1, 23, 3, 1),
(24, 'Withdrawn', 1, 24, 1, 4),
(25, 'Active', 1, 25, 3, 2),
(26, 'Completed', 1, 26, 2, 3),
(27, 'Active', 1, 27, 3, 1),
(28, 'Withdrawn', 1, 28, 1, 4),
(29, 'Active', 1, 29, 3, 2),
(30, 'Completed', 1, 30, 2, 3),
(31, 'Active', 1, 31, 3, 1),
(32, 'Withdrawn', 1, 32, 1, 4),
(33, 'Active', 1, 33, 3, 2),
(34, 'Completed', 1, 34, 2, 3),
(35, 'Active', 1, 35, 3, 1),
(36, 'Withdrawn', 1, 36, 1, 4),
(37, 'Active', 1, 37, 3, 2),
(38, 'Completed', 1, 38, 2, 3),
(39, 'Active', 1, 39, 3, 1),
(40, 'Withdrawn', 1, 40, 1, 4),
(41, 'Active', 1, 41, 3, 2),
(42, 'Completed', 1, 42, 2, 3),
(43, 'Active', 1, 43, 3, 1),
(44, 'Withdrawn', 1, 44, 1, 4),
(45, 'Active', 1, 45, 3, 2),
(46, 'Completed', 1, 46, 2, 3),
(47, 'Active', 1, 47, 3, 1),
(48, 'Withdrawn', 1, 48, 1, 4),
(49, 'Active', 1, 49, 3, 2),
(50, 'Completed', 1, 50, 2, 3);

-- ---------------------------
-- Users (employees and students)
-- ---------------------------
INSERT INTO `user` (user_id, user_fname, user_lname, audit_id, employee_employee_id, student_id) VALUES
(1, 'Alice', 'Johnson', 1, 1, NULL),
(2, 'Bob', 'Smith', 1, 2, NULL),
(3, 'Charlie', 'Brown', 1, NULL, 1),
(4, 'Diana', 'Lopez', 1, NULL, 2),
(5, 'Ethan', 'White', 1, 3, NULL),
(6, 'Fiona', 'Green', 1, 4, NULL),
(7, 'George', 'Adams', 1, NULL, 3),
(8, 'Hannah', 'Nelson', 1, NULL, 4),
(9, 'Ian', 'Baker', 1, 5, NULL),
(10, 'Julia', 'Carter', 1, 6, NULL),
(11, 'Kevin', 'Mitchell', 1, NULL, 5),
(12, 'Laura', 'Perez', 1, NULL, 6),
(13, 'Mike', 'Roberts', 1, 7, NULL),
(14, 'Nina', 'Turner', 1, 8, NULL),
(15, 'Oscar', 'Phillips', 1, NULL, 7),
(16, 'Paula', 'Campbell', 1, NULL, 8),
(17, 'Quinn', 'Parker', 1, 9, NULL),
(18, 'Rachel', 'Evans', 1, 10, NULL),
(19, 'Sam', 'Edwards', 1, NULL, 9),
(20, 'Tina', 'Collins', 1, NULL, 10),
(21, 'Ulysses', 'Stewart', 1, 11, NULL),
(22, 'Vera', 'Morris', 1, 12, NULL),
(23, 'Will', 'Murphy', 1, NULL, 11),
(24, 'Xena', 'Cook', 1, NULL, 12),
(25, 'Yuri', 'Rogers', 1, 13, NULL),
(26, 'Zoe', 'Reed', 1, 14, NULL),
(27, 'Oliver', 'King', 1, 15, NULL),
(28, 'Emma', 'Scott', 1, 16, NULL),
(29, 'Noah', 'Reed', 1, 17, NULL),
(30, 'Ava', 'Murphy', 1, 18, NULL),
(31, 'Liam', 'Brooks', 1, 19, NULL),
(32, 'Sophia', 'Jenkins', 1, 20, NULL),
(33, 'Mason', 'Perez', 1, NULL, 21),
(34, 'Isabella', 'Long', 1, NULL, 22),
(35, 'Lucas', 'Cruz', 1, NULL, 23),
(36, 'Mia', 'Reynolds', 1, NULL, 24),
(37, 'Ethan', 'Bell', 1, NULL, 25),
(38, 'Harper', 'Cole', 1, NULL, 26),
(39, 'James', 'Woods', 1, NULL, 27),
(40, 'Amelia', 'Fisher', 1, NULL, 28),
(41, 'Benjamin', 'Warren', 1, NULL, 29),
(42, 'Evelyn', 'Hart', 1, NULL, 30),
(43, 'Logan', 'Santos', 1, NULL, 31),
(44, 'Abigail', 'Patterson', 1, NULL, 32),
(45, 'Caleb', 'Gomez', 1, NULL, 33),
(46, 'Ella', 'Morris', 1, NULL, 34),
(47, 'Oliver', 'Reyes', 1, NULL, 35),
(48, 'Scarlett', 'Hunt', 1, NULL, 36),
(49, 'Jacob', 'Wang', 1, NULL, 37),
(50, 'Luna', 'Flores', 1, NULL, 38),
(51, 'Daniel', 'Khan', 1, NULL, 39),
(52, 'Grace', 'Kim', 1, NULL, 40),
(53, 'Henry', 'Nguyen', 1, NULL, 41),
(54, 'Zoe', 'Park', 1, NULL, 42),
(55, 'Owen', 'Diaz', 1, NULL, 43),
(56, 'Addison', 'Foster', 1, NULL, 44),
(57, 'Aileen', 'Morales', 1, NULL, 45),
(58, 'Brandon', 'Lee', 1, NULL, 46),
(59, 'Catherine', 'Young', 1, NULL, 47),
(60, 'Derek', 'Hughes', 1, NULL, 48);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
