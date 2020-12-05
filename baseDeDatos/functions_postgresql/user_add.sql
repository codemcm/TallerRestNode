/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: Martin Cruz
* Created date: 2020-05-06
* Edited date: 2020-05-09
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS  PUBLIC.userAdd(VARCHAR(100), VARCHAR(225),INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.userAdd(
    IN usernameIN VARCHAR(100),
    IN passwordIN VARCHAR(225),
    IN created_byIN INTEGER,
    OUT user_idOUT INTEGER)
RETURNS SETOF INTEGER AS
$BODY$
DECLARE user_idx INTEGER;
BEGIN
    INSERT INTO PUBLIC.user (username, password,created_by)
    VALUES (usernameIN, PGP_SYM_ENCRYPT(passwordIN,'AES_KEY'), created_byIN)
    RETURNING user_id INTO user_idx;
    RETURN QUERY
    SELECT user_idx
RETURN;
END;
$BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.userAdd(VARCHAR(100), VARCHAR(225),INTEGER)
OWNER TO postgres;

--SELECT userAdd('Martin','1234');