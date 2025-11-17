DELIMITER //


CREATE OR REPLACE PROCEDURE af25nathm1_collegev3.sp_enroll_student(
  IN p_student_id INT,
  IN p_semester_id INT,
  IN p_audit_user_id INT,
  OUT p_enrollment_id INT
)
BEGIN
  DECLARE v_exists INT DEFAULT 0;

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SET p_enrollment_id = -1;
  END;

  START TRANSACTION;

  IF p_student_id IS NULL OR p_student_id <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid student_id';
  END IF;

  IF p_semester_id IS NULL OR p_semester_id <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid semester_id';
  END IF;

  IF p_audit_user_id IS NULL OR p_audit_user_id <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid audit_user_id';
  END IF;

  SELECT COUNT(*) INTO v_exists FROM af25nathm1_collegev3.student WHERE student_id = p_student_id;
  IF v_exists = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student not found';
  END IF;

  SELECT COUNT(*) INTO v_exists FROM af25nathm1_collegev3.semester WHERE semester_id = p_semester_id;
  IF v_exists = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Semester not found';
  END IF;

  SELECT COUNT(*) INTO v_exists
  FROM af25nathm1_collegev3.enrollment
  WHERE student_student_id = p_student_id AND semester_id = p_semester_id;
  IF v_exists > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student already enrolled for this semester';
  END IF;

  INSERT INTO af25nathm1_collegev3.enrollment
    (enrollment_status, audit_user_id, student_student_id, semester_id, lookup_grade_id)
  VALUES
    ('Active', p_audit_user_id, p_student_id, p_semester_id, NULL);

  SET p_enrollment_id = LAST_INSERT_ID();

  COMMIT;
END//
DELIMITER ;
