DELIMITER //
DROP FUNCTION IF EXISTS af25nathm1_collegev3.fn_get_student_enrollment_count;//
CREATE FUNCTION af25nathm1_collegev3.fn_get_student_enrollment_count(p_student_id INT) RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE v_cnt INT;
  SELECT COUNT(*) INTO v_cnt
    FROM af25nathm1_collegev3.enrollment
    WHERE student_student_id = p_student_id;
  RETURN IFNULL(v_cnt,0);
END//
DELIMITER ;

DROP FUNCTION IF EXISTS af25nathm1_collegev3.fn_get_student_avg_grade_point;
DELIMITER //
CREATE FUNCTION af25nathm1_collegev3.fn_get_student_avg_grade_point(p_student_id INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
  DECLARE v_avg DECIMAL(5,2);
  SELECT AVG(lg.lookup_grade_point_value) INTO v_avg
    FROM af25nathm1_collegev3.enrollment e
    JOIN af25nathm1_collegev3.lookup_grade lg ON e.lookup_grade_id = lg.lookup_grade_id
    WHERE e.student_student_id = p_student_id;
  RETURN IFNULL(v_avg,0.00);
END//
DELIMITER ;
