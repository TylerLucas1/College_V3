DROP PROCEDURE IF EXISTS af25nathm1_collegev3.tx_transfer_student_section;
DELIMITER //
CREATE PROCEDURE af25nathm1_collegev3.tx_transfer_student_section(
  IN p_student_id INT,
  IN p_from_section INT,
  IN p_to_section INT
)
BEGIN
  DECLARE v_from_student INT;
  DECLARE v_to_student INT;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'transaction failed';
  END;

  START TRANSACTION;
    SELECT student_id INTO v_from_student
      FROM af25nathm1_collegev3.section
      WHERE section_id = p_from_section
      FOR UPDATE;

    IF v_from_student IS NULL OR v_from_student != p_student_id THEN
      ROLLBACK;
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'student not in from_section';
    END IF;

    SELECT student_id INTO v_to_student
      FROM af25nathm1_collegev3.section
      WHERE section_id = p_to_section
      FOR UPDATE;

    -- Swap students: put v_to_student into from_section, and p_student_id into to_section
    UPDATE af25nathm1_collegev3.section
      SET student_id = v_to_student
      WHERE section_id = p_from_section;

    UPDATE af25nathm1_collegev3.section
      SET student_id = p_student_id
      WHERE section_id = p_to_section;

  COMMIT;
END//
DELIMITER ;
