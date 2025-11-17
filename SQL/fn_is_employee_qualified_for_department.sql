DELIMITER //
DROP FUNCTION IF EXISTS af25nathm1_collegev3.fn_is_employee_qualified_for_department;//
CREATE FUNCTION af25nathm1_collegev3.fn_is_employee_qualified_for_department(
  in_employee_id INT,
  in_department_id INT
)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE emp_role_level INT DEFAULT 0;
  DECLARE required_level INT DEFAULT 50; 
  DECLARE is_already_head INT DEFAULT 0;
  
  SELECT COALESCE(ler.lookup_employee_role_security_level, 0) INTO emp_role_level
  FROM af25nathm1_collegev3.employee e
  JOIN af25nathm1_collegev3.lookup_employee_role ler 
    ON e.lookup_employee_role_id = ler.lookup_employee_role_id
  WHERE e.employee_id = in_employee_id;
  
  SELECT COUNT(*) INTO is_already_head
  FROM af25nathm1_collegev3.department
  WHERE employee_id = in_employee_id 
    AND department_id != in_department_id;
  
  RETURN (emp_role_level >= required_level AND is_already_head = 0);
END//
DELIMITER ;
