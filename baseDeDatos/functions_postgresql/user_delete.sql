/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: Martin Cruz
* Created date: 2020-05-09
* Edited date: 2020-05-09
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS PUBLIC.userDelete(INTEGER,INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.userDelete(
    IN user_idIN INTEGER,
    IN update_byIN INTEGER)
    RETURNS VOID AS
    $BODY$
    BEGIN 
    UPDATE PUBLIC.user SET active='FALSE', updated_by = update_byIN, update_date = NOW() WHERE user_id = user_idIN AND active=true;
    RETURN;
    END;
    $BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.userDelete(INTEGER,INTEGER)
OWNER TO postgres;

--SELECT PUBLIC.userDelete(2,1);