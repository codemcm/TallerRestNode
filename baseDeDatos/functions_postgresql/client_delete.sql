/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: Martin Cruz
* Created date: 2020-05-09
* Edited date: 2020-05-09
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS PUBLIC.clientDelete(INTEGER,INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.clientDelete(
    IN client_idIN INTEGER,
    IN updated_byIN INTEGER)
    RETURNS VOID AS
    $BODY$
    BEGIN 
    UPDATE client SET active='FALSE', updated_by = updated_byIN, updated_date = NOW() WHERE client_id = client_idIN AND active=true;
    RETURN;
    END;
    $BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.clientDelete(INTEGER,INTEGER)
OWNER TO postgres;

--SELECT PUBLIC.clientDelete(1,2);