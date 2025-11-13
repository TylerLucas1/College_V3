DROP PROCEDURE IF EXISTS af25nathm1_collegev3.tx_transfer_student_section_locked;

DELIMITER //

CREATE PROCEDURE af25nathm1_collegev3.tx_transfer_student_section_locked(
    IN p_student_id INT,
    IN p_from_section INT,
    IN p_to_section INT
)
BEGIN
    DECLARE v_from_student_id INT DEFAULT NULL;
    DECLARE v_to_student_id INT DEFAULT NULL;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT student_id INTO v_from_student_id
    FROM af25nathm1_collegev3.section
    WHERE section_id = p_from_section
    FOR UPDATE;

    SELECT student_id INTO v_to_student_id
    FROM af25nathm1_collegev3.section
    WHERE section_id = p_to_section
    FOR UPDATE;

    IF v_from_student_id != p_student_id THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Student is not enrolled in the source section';
    END IF;

    UPDATE af25nathm1_collegev3.section
    SET student_id = v_to_student_id
    WHERE section_id = p_from_section;

    UPDATE af25nathm1_collegev3.section
    SET student_id = p_student_id
    WHERE section_id = p_to_section;

    COMMIT;
END//

DELIMITER ;