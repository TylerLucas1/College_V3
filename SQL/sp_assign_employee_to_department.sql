DELIMITER //
DROP PROCEDURE IF EXISTS af25nathm1_collegev3.assign_employee_to_department;//
CREATE PROCEDURE af25nathm1_collegev3.assign_employee_to_department(
    IN in_employee_id INT,
    IN in_department_id INT
)
BEGIN
    DECLARE v_exists INT DEFAULT 0;
    DECLARE v_is_qualified BOOLEAN DEFAULT FALSE;

    START TRANSACTION;

    SELECT COUNT(*) INTO v_exists FROM af25nathm1_collegev3.employee WHERE employee_id = in_employee_id;
    IF v_exists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee not found';
    END IF;

    SELECT COUNT(*) INTO v_exists FROM af25nathm1_collegev3.department WHERE department_id = in_department_id;
    IF v_exists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Department not found';
    END IF;

    SET v_is_qualified = af25nathm1_collegev3.fn_is_employee_qualified_for_department(in_employee_id, in_department_id);
    IF v_is_qualified = FALSE THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee not qualified: insufficient security level or already heads another department';
    END IF;

    UPDATE af25nathm1_collegev3.department
    SET employee_id = in_employee_id
    WHERE department_id = in_department_id;

    SELECT department_id, department_name, employee_id
    FROM af25nathm1_collegev3.department
    WHERE department_id = in_department_id;

    COMMIT;
END //
DELIMITER ;
