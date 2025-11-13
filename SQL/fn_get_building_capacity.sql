CREATE DEFINER=`af25tylel1`@`localhost` FUNCTION `fn_get_building_capacity`(building_code VARCHAR(10)) 
RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE v_total_capacity INT;

    SELECT SUM(r.room_capacity)
    INTO v_total_capacity
    FROM room r
    WHERE r.building_id = building_id;

    RETURN IFNULL(v_total_capacity, 0);
END
