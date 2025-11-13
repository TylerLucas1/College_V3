CREATE DEFINER=`af25tylel1`@`localhost` PROCEDURE `sp_assign_room`(
    IN p_room_id INT,
    IN p_section_id INT,
    IN p_student_id INT,
    IN p_employee_id INT,
    IN p_building_id INT,
    IN p_audit_user_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error occurred while assigning room.';
    END;

    START TRANSACTION;

    -- Lock the room to prevent double booking
    SELECT * 
    FROM room
    WHERE room_id = p_room_id
    FOR UPDATE;

    -- Ensure no other section is using the room at the same time
    IF EXISTS (
        SELECT 1
        FROM room r
        JOIN section s ON r.section_id = s.section_id
        WHERE r.room_id = p_room_id
          AND s.section_times = (SELECT section_times FROM section WHERE section_id = p_section_id)
          AND s.section_days = (SELECT section_days FROM section WHERE section_id = p_section_id)
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Room is already assigned at this time.';
    END IF;

    -- Assign room
    INSERT INTO room (
        room_name,
        room_capacity,
        section_id,
        student_id,
        employee_id,
        building_id,
        audit_user_id
    ) VALUES (
        CONCAT('Room ', p_room_id),
        (SELECT building_room_capacity FROM building WHERE building_id = p_building_id),
        p_section_id,
        p_student_id,
        p_employee_id,
        p_building_id,
        p_audit_user_id
    );

    COMMIT;
END
