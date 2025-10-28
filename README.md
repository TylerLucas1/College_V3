# 📚 Student Information System Database

A relational Student Information System (SIS) database designed for Students, Faculty, and Admins to manage grades, enrollment, courses, rooms, and departments.
[![MariaDB](https://img.shields.io/badge/MariaDB-003545?logo=mariadb&logoColor=white)](#)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=fff)](#)

## Table of Contents

- [Role Features](#role-features)
  - [Students](#students)
  - [Faculty](#faculty)
- [Entity–Relationship Model](#entity–relationship-model)
  - [Diagram](#diagram)
  - [Key Tables](#key-tables)
- [Tech Stack](#tech-stack)
- [Setup](#setup)
- [Authors](#authors)

## Role Features

### Students

View grades and enrollment status.

Access course and section details they are linked to.

### Faculty

View and update grades for students they teach.

Manage sections they are assigned to.

View departmental and course relationships.

## Entity–Relationship Model

The schema enforces role-based access, integrity, and scalability.

### Diagram

Below are the exported diagrams from MySQL Workbench. Click the images to view the full-size versions.

[![EER Diagram](assets/EER_Diagram.png)](assets/EER_Diagram.png)
*EER Diagram — shows tables and relationships.*

[![Catalog Tree](assets/Catalog_Tree.png)](assets/Catalog_Tree.png)
*Catalog Tree — shows the list of tables in the generated schema.*

##  Views

The database includes several custom **SQL views** to simplify querying and reporting across core entities like students, instructors, courses, and academic performance. These views were created to answer common questions and support administrative tasks.

###  Implemented Views

| View Name                        | Description                                                                 |
|----------------------------------|-----------------------------------------------------------------------------|
| `sections_with_rooms_view`      | Displays which instructors are teaching which courses, in which rooms, and at what times. Includes course name, room details, and instructor info. |
| `graduated_students_high_gpa_view` | Lists all students who have **graduated** with a **GPA above 3.5**, including their admission/graduation dates and GPA. |
| `instructor_by_role_view`       | Shows employees with their assigned role titles, security levels, and personal details. Helps identify faculty/staff structure. |
| `semesters_by_student_view`     | Lists all semesters each student has been enrolled in, including enrollment status (e.g., Active, Completed, Withdrawn). Useful for tracking student progress over time. |

> These views were built using `JOIN`, `GROUP BY`, `HAVING`, and `ORDER BY` clauses, and tested on sample data generated using `INSERT` statements.  
> They are reusable across reporting tools or integrations with front-end dashboards.



### Key Tables

- `user` – Authentication & link to student / employee.
- `student` – Admissions, graduation, enrollment link.
- `employee` – Faculty/Admin records with roles.
- `department` – Academic departments.
- `course` – Courses with credit hours.
- `section` – Course offerings, linked to faculty/students.
- `enrollment` – Tracks student enrollment status.
- `semester` – Current and archived academic terms.
- `room` / `building` – Physical classroom resources.
- Lookups – Employee roles, grades.

## Tech Stack

- Database: MySQL / MariaDB
- Modeling: MySQL Workbench (Forward Engineering)

## Setup

Clone the repository:

```powershell
git clone https://github.com/Beast1692/CollegeV2.git
cd CollegeV2
```

Import the .sql schema into MySQL Workbench.

Run the script to create tables and relationships.

## Authors

[Nathan Mulholland](https://github.com/Beast1692)
[Steven Cain](https://github.com/Stevencain3)
