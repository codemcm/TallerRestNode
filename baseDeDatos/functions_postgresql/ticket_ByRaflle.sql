/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: 
* Created date: 2020-05-17
* Edited date: 
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS  PUBLIC.ticketByRaffle(INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.ticketByRaffle(
    IN raffle_idIN INTEGER,
    OUT ticket_idOUT INTEGER,
    OUT client_idOUT INTEGER)
RETURNS SETOF RECORD AS
$BODY$
DECLARE  reg RECORD;
BEGIN
    FOR REG IN SELECT ticket_id, client_id FROM PUBLIC.ticket WHERE raffle_id = raffle_idIN LOOP
       ticket_idOUT  := reg.ticket_id;
       client_idOUT := reg.client_id;
       RETURN NEXT;
    END LOOP;
    RETURN;
END;
$BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.ticketByRaffle(INTEGER)
OWNER TO postgres;


--SELECT ticketByRaffle(1);


