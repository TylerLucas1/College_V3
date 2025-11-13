# SQL Procedures, Functions & Transactions Guide

This guide demonstrates how to use each stored procedure (SP), custom function (FN), and transaction (TX) in the College V3 database.

---

## Table of Contents

- [Custom Functions (FN)](#custom-functions-fn)
  - [fn_get_student_enrollment_count](#fn_get_student_enrollment_count)
  - [fn_get_student_avg_grade_point](#fn_get_student_avg_grade_point)
  - [total_credits](#total_credits)
- [Stored Procedures (SP)](#stored-procedures-sp)
  - [sp_enroll_student](#sp_enroll_student)
  - [sp_assign_employee_to_department](#sp_assign_employee_to_department)
- [Transaction Procedures (TX)](#transaction-procedures-tx)
  - [tx_transfer_student_section](#tx_transfer_student_section)
  - [tx_transfer_student_section_locked](#tx_transfer_student_section_locked)

---

## Custom Functions (FN)

Functions return scalar values and can be used directly in SELECT statements.

### fn_get_student_enrollment_count

**Purpose:** Returns the total number of enrollments for a given student.

**Parameters:**
- `p_student_id` (INT) – The student ID

**Returns:** INT (enrollment count)

**Usage Example:**
```sql
-- Get enrollment count for student 1
SELECT af25nathm1_collegev3.fn_get_student_enrollment_count(1) AS enrollment_count;
-- Output: 1

-- Use in a WHERE clause to find active students
SELECT student_id, af25nathm1_collegev3.fn_get_student_enrollment_count(student_id) AS enrollments
FROM af25nathm1_collegev3.student
WHERE af25nathm1_collegev3.fn_get_student_enrollment_count(student_id) > 0;
```

---

### fn_get_student_avg_grade_point

**Purpose:** Calculates the average grade point value for a student across all enrollments.

**Parameters:**
- `p_student_id` (INT) – The student ID

**Returns:** DECIMAL(5,2) (average GPA)

**Usage Example:**
```sql
-- Get average GPA for student 2
SELECT af25nathm1_collegev3.fn_get_student_avg_grade_point(2) AS avg_gpa;
-- Output: 3.50 (or similar)

-- Find students with GPA above 3.0
SELECT student_id, af25nathm1_collegev3.fn_get_student_avg_grade_point(student_id) AS gpa
FROM af25nathm1_collegev3.student
HAVING gpa > 3.0
ORDER BY gpa DESC;
```

---

### total_credits

**Purpose:** Sums all course credit hours for a student's currently enrolled sections.

**Parameters:**
- `in_student_id` (INT) – The student ID

**Returns:** INT (total credit hours)

**Usage Example:**
```sql
-- Get total credits for student 3
SELECT af25nathm1_collegev3.total_credits(3) AS total_credit_hours;
-- Output: 6 (or the sum of their course credits)

-- Find students with high credit loads (> 12 hours)
SELECT student_id, af25nathm1_collegev3.total_credits(student_id) AS credits
FROM af25nathm1_collegev3.student
WHERE af25nathm1_collegev3.total_credits(student_id) > 12
ORDER BY credits DESC;
```

---

## Stored Procedures (SP)

Procedures perform actions (INSERT, UPDATE, DELETE) and return result sets. Call them using CALL.

### sp_enroll_student

**Purpose:** Enrolls a student in a semester with a grade, returns the enrollment ID.

**Parameters:**
- `p_student_id` (INT IN) – The student to enroll
- `p_semester_id` (INT IN) – The semester
- `p_lookup_grade_id` (INT IN) – Initial grade ID (1=A, 2=B, 3=C, 4=D, 5=F)
- `p_audit_user_id` (INT IN) – User ID for audit trail
- `p_enrollment_id` (INT OUT) – Returns the new enrollment_id (or -1 on error)

**Returns:** OUT parameter with enrollment ID

**Usage Example:**
```sql
-- Enroll student 5 in semester 2 with grade B (lookup_grade_id=2)
CALL af25nathm1_collegev3.sp_enroll_student(5, 2, 2, 1, @enrollment_id);
SELECT @enrollment_id AS new_enrollment_id;
-- Output: new_enrollment_id = 51 (or next auto-increment)

-- Enroll student 10 in semester 3 with grade A
CALL af25nathm1_collegev3.sp_enroll_student(10, 3, 1, 1, @new_id);
SELECT @new_id;
```

---

### sp_assign_employee_to_department

**Purpose:** Assigns an employee as the head of a department. Validates both employee and department exist.

**Parameters:**
- `in_employee_id` (INT IN) – The employee to assign
- `in_department_id` (INT IN) – The department to update

**Returns:** SELECT statement showing updated department row

**Usage Example:**
```sql
-- Assign employee 2 to department 10
CALL af25nathm1_collegev3.sp_assign_employee_to_department(2, 10);
-- Output: Shows department_id, department_name, employee_id

-- Assign employee 5 to department 1
CALL af25nathm1_collegev3.sp_assign_employee_to_department(5, 1);

-- Error case: invalid employee ID
CALL af25nathm1_collegev3.sp_assign_employee_to_department(999, 1);
-- Output: ERROR 1644 (45000): Employee not found
```

---

## Transaction Procedures (TX)

Transactions ensure data consistency using locks and atomic operations.

### tx_transfer_student_section

**Purpose:** Transfers a student from one section to another by swapping their positions. Uses row-level locking to prevent race conditions.

**Parameters:**
- `p_student_id` (INT) – The student to transfer
- `p_from_section` (INT) – Source section ID
- `p_to_section` (INT) – Destination section ID

**Returns:** None (modifies data in-place)

**Behavior:**
- Locks both section rows
- Validates student is in source section
- Swaps student assignments between sections
- Commits atomically or rolls back on error

**Usage Example:**
```sql
-- Transfer student 1 from section 1 to section 2
-- Before: Section 1 has student 1, Section 2 has student 2
CALL af25nathm1_collegev3.tx_transfer_student_section(1, 1, 2);
-- After: Section 1 has student 2, Section 2 has student 1

-- Transfer student 3 from section 3 to section 4
CALL af25nathm1_collegev3.tx_transfer_student_section(3, 3, 4);

-- Error case: student not in source section
CALL af25nathm1_collegev3.tx_transfer_student_section(99, 1, 2);
-- Output: ERROR 1644 (45000): student not in from_section
```

---

### tx_transfer_student_section_locked

**Purpose:** Enhanced version of student transfer with explicit row-level locking and improved validation. Prevents concurrent modifications and provides clear error messages.

**Parameters:**
- `p_student_id` (INT) – The student to transfer
- `p_from_section` (INT) – Source section ID
- `p_to_section` (INT) – Destination section ID

**Returns:** None (modifies data in-place)

**Key Differences from tx_transfer_student_section:**
- Uses explicit `SELECT ... FOR UPDATE` locking with named variables
- Better validation error message
- Automatic rollback and error propagation via RESIGNAL
- Handles NULL checks more carefully

**Usage Example:**
```sql
-- Transfer student 1 from section 1 to section 2
-- Before: Section 1 has student 1, Section 2 has student 2
CALL af25nathm1_collegev3.tx_transfer_student_section_locked(1, 1, 2);
-- After: Section 1 has student 2, Section 2 has student 1

-- Transfer student 5 from section 5 to section 6
CALL af25nathm1_collegev3.tx_transfer_student_section_locked(5, 5, 6);

-- Error case: invalid student ID
CALL af25nathm1_collegev3.tx_transfer_student_section_locked(999, 1, 2);
-- Output: ERROR 1644 (45000): Student is not enrolled in the source section
```

---

## Testing & Verification

### Test All Functions

```sql
-- Test enrollment count function
SELECT af25nathm1_collegev3.fn_get_student_enrollment_count(1) AS enrollments;

-- Test GPA function
SELECT af25nathm1_collegev3.fn_get_student_avg_grade_point(1) AS avg_gpa;

-- Test total credits function
SELECT af25nathm1_collegev3.total_credits(1) AS credits;
```

### Test All Procedures

```sql
-- Test enrollment procedure
CALL af25nathm1_collegev3.sp_enroll_student(2, 1, 1, 1, @enrollment_id);
SELECT @enrollment_id;

-- Test department assignment
CALL af25nathm1_collegev3.sp_assign_employee_to_department(2, 10);

-- Test student transfer (basic)
CALL af25nathm1_collegev3.tx_transfer_student_section(1, 1, 2);

-- Test student transfer (locked)
CALL af25nathm1_collegev3.tx_transfer_student_section_locked(3, 3, 4);
```

---

## Error Handling

All procedures and functions include error handling:

| Error Code | Message | Cause |
|-----------|---------|-------|
| `45000` | Employee not found | Invalid employee_id in sp_assign_employee_to_department |
| `45000` | Department not found | Invalid department_id in sp_assign_employee_to_department |
| `45000` | student not in from_section | Student not enrolled in source section (tx_transfer_student_section) |
| `45000` | Student is not enrolled in the source section | Student validation failed (tx_transfer_student_section_locked) |
| `-1` | N/A | Enrollment insertion failed (sp_enroll_student returns -1) |

---

## Summary Table

| Name | Type | Input | Output | Notes |
|------|------|-------|--------|-------|
| `fn_get_student_enrollment_count` | Function | student_id | COUNT | Read-only, DETERMINISTIC |
| `fn_get_student_avg_grade_point` | Function | student_id | DECIMAL(5,2) | Read-only, DETERMINISTIC |
| `total_credits` | Function | student_id | INT | Read-only, DETERMINISTIC |
| `sp_enroll_student` | Procedure | student, semester, grade, audit_user | enrollment_id (OUT) | Transactional, INSERT |
| `sp_assign_employee_to_department` | Procedure | employee_id, department_id | department row (SELECT) | Transactional, UPDATE |
| `tx_transfer_student_section` | Procedure | student_id, from_section, to_section | None | Transactional, UPDATE (locked) |
| `tx_transfer_student_section_locked` | Procedure | student_id, from_section, to_section | None | Transactional, UPDATE (locked, enhanced) |

---

For questions or additional examples, see the main [README.md](README.md).
