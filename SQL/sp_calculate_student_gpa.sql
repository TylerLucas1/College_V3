CREATE DEFINER=`af25tylel1`@`localhost` PROCEDURE `sp_calculate_student_gpa`(
    IN p_student_id INT
)
BEGIN
    DECLARE v_gpa DECIMAL(4,2);

    -- Start a transaction
    START TRANSACTION;

    -- Lock the student row to prevent concurrent updates
    SELECT student_id
    FROM student
    WHERE student_id = p_student_id
    FOR UPDATE;

    -- Lock related enrollment rows to ensure consistent GPA calculation
    SELECT e.enrollment_id
    FROM enrollment e
    WHERE e.student_student_id = p_student_id
    FOR UPDATE;

    -- Calculate GPA
    SELECT 
        st.student_id,
        ROUND(AVG(l.lookup_grade_point_value), 2) AS GPA
    FROM enrollment e
    JOIN lookup_grade l ON e.lookup_grade_id = l.lookup_grade_id
    JOIN student st ON e.student_student_id = st.student_id
    WHERE st.student_id = p_student_id
    GROUP BY st.student_id;

    -- Commit transaction
    COMMIT;
END
