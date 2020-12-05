/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: Martin Cruz
* Created date: 2020-05-09
* Edited date: 2020-05-09
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS PUBLIC.winnerDelete(INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.winnerDelete(
    IN winner_idIN INTEGER)
    RETURNS VOID AS
    $BODY$
    BEGIN 
    UPDATE PUBLIC.winner SET active='FALSE' WHERE winner_id = winner_idIN AND active=true;
    RETURN;
    END;
    $BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.winnerDelete(INTEGER)
OWNER TO postgres;

--SELECT PUBLIC.winnerDelete(1);