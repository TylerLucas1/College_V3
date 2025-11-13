DELIMITER $$

CREATE PROCEDURE sp_calculate_student_gpa (
    IN p_student_id INT
)
BEGIN
    SELECT 
        st.student_id,
        ROUND(AVG(l.lookup_grade_point_value), 2) AS GPA
    FROM enrollment e
    JOIN lookup_grade l ON e.lookup_grade_id = l.lookup_grade_id
    JOIN student st ON e.student_student_id = st.student_id
    WHERE st.student_id = p_student_id
    GROUP BY st.student_id;
END$$

DELIMITER ;
