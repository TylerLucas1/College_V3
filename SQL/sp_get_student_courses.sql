DELIMITER $$

CREATE PROCEDURE sp_get_student_courses (
    IN p_student_id INT
)
BEGIN
    SELECT 
        s.section_id,
        c.course_name,
        se.semester_season AS semester,
        s.section_days,
        s.section_times,
        s.section_delivery_method,
        e.enrollment_status
    FROM enrollment e
    JOIN section s ON e.section_id = s.section_id
    JOIN course c ON s.course_id = c.course_id
    JOIN semester se ON e.semester_id = se.semester_id
    WHERE e.student_student_id = p_student_id
    ORDER BY se.semester_id, c.course_name;
END$$

DELIMITER ;
