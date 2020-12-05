/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: Martin Cruz
* Created date: 2020-05-06
* Edited date: 2020-05-09
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS  PUBLIC.winnerAdd(INTEGER,INTEGER,INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.winnerAdd(
    IN ticket_idIN INTEGER,
    IN prize_idIN INTEGER,
    IN created_byIn INTEGER,
    OUT winner_idOUT INTEGER)
RETURNS SETOF INTEGER AS
$BODY$
DECLARE winner_idx INTEGER;
BEGIN
    INSERT INTO PUBLIC.winner (ticket_id, prize_id, created_by)
    VALUES (ticket_idIN, prize_idIN, created_byIn)
    RETURNING winner_id INTO winner_idx;
    RETURN QUERY
    SELECT winner_idx
RETURN;
END;
$BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.winnerAdd(INTEGER,INTEGER,INTEGER)
OWNER TO postgres;

--SELECT winnerAdd(1,1,1);
