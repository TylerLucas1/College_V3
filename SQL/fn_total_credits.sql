DELIMITER //
DROP FUNCTION IF EXISTS af25nathm1_collegev3.total_credits;//
CREATE FUNCTION af25nathm1_collegev3.total_credits(in_student_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE total INT DEFAULT 0;
  SELECT COALESCE(SUM(c.course_credit_hours),0) INTO total
  FROM af25nathm1_collegev3.section s
  JOIN af25nathm1_collegev3.course c ON c.course_id = s.course_id
  WHERE s.student_id = in_student_id;
  RETURN total;
END//
DELIMITER ;
