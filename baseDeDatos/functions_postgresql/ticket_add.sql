/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: Martin Cruz
* Created date: 2020-05-09
* Edited date: 2020-05-09
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS  PUBLIC.ticketAdd(INTEGER,INTEGER,INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.ticketAdd(
    IN raffle_idIN INTEGER,
    IN client_idIN INTEGER,
    IN created_byIn INTEGER,
    OUT ticket_idOUT INTEGER)
RETURNS SETOF INTEGER AS
$BODY$
DECLARE ticket_idx INTEGER;
BEGIN
    INSERT INTO PUBLIC.ticket (raffle_id, client_id, created_by)
    VALUES (raffle_idIN, client_idIN, created_byIn)
    RETURNING ticket_id INTO ticket_idx;
    RETURN QUERY
    SELECT ticket_idx
RETURN;
END;
$BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.ticketAdd(INTEGER,INTEGER,INTEGER)
OWNER TO postgres;

/*
SELECT ticketAdd(1,1,1);
SELECT ticketAdd(2,1,1);
SELECT ticketAdd(3,1,1);
SELECT ticketAdd(4,1,1);
SELECT ticketAdd(1,2,1);
SELECT ticketAdd(2,2,1);
SELECT ticketAdd(3,2,1);
SELECT ticketAdd(4,2,1);
*/
