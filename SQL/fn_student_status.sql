CREATE DEFINER=`af25tylel1`@`localhost` FUNCTION `fn_student_status`(p_student_id INT) RETURNS varchar(50) CHARSET utf8mb4 COLLATE utf8mb4_general_ci
    DETERMINISTIC
BEGIN
    DECLARE v_status VARCHAR(50);
DECLARE v_grad_date DATE;

SELECT student_graduation_date
INTO v_grad_date
FROM student
WHERE student_id = p_student_id;

IF v_grad_date IS NULL THEN
    SET v_status = 'Active';
ELSEIF v_grad_date <= CURDATE() THEN
    SET v_status = 'Graduated';
ELSE
    SET v_status = 'Unknown';
END IF;

RETURN v_status;

END
