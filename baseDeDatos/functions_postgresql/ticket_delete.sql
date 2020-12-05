/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: Martin Cruz
* Created date: 2020-05-09
* Edited date: 2020-05-09
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS PUBLIC.ticketDelete(INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.ticketDelete(
    IN ticket_idIN INTEGER)
    RETURNS VOID AS
    $BODY$
    BEGIN 
    UPDATE ticket SET active='FALSE' WHERE ticket_id = ticket_idIN AND active=true;
    RETURN;
    END;
    $BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.ticketDelete(INTEGER)
OWNER TO postgres;

--SELECT PUBLIC.ticketDelete(1);