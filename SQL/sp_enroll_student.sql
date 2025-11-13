DELIMITER //
DROP PROCEDURE IF EXISTS af25nathm1_collegev3.sp_enroll_student;
CREATE PROCEDURE af25nathm1_collegev3.sp_enroll_student(
  IN p_student_id INT,
  IN p_semester_id INT,
  IN p_lookup_grade_id INT,
  IN p_audit_user_id INT,
  OUT p_enrollment_id INT
)
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SET p_enrollment_id = -1;
  END;
  START TRANSACTION;
    INSERT INTO af25nathm1_collegev3.enrollment
      (enrollment_status, audit_user_id, student_student_id, semester_id, lookup_grade_id)
    VALUES
      ('Active', p_audit_user_id, p_student_id, p_semester_id, p_lookup_grade_id);
    SET p_enrollment_id = LAST_INSERT_ID();
  COMMIT;
END//
DELIMITER ;
