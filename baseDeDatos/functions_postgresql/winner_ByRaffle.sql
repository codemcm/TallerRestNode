/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: 
* Created date: 2020-05-17
* Edited date: 
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS  PUBLIC.winnerByRaflle(INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.winnerByRaflle(
    IN raffle_idIN INTEGER,
    OUT ticket_idOUT INTEGER,
    OUT nameOUT VARCHAR,
    OUT last_nameOUT VARCHAR,
    OUT cellOUT VARCHAR,
    OUT productOUT VARCHAR
    )
RETURNS SETOF RECORD AS
$BODY$
DECLARE  reg RECORD;
BEGIN
    FOR REG IN  
    SELECT T.ticket_id, C.name, C.last_name, C.cell, P.product
    FROM ticket T 
    INNER JOIN client C 
    ON T.client_id = C.client_id 
    JOIN winner W
    ON W.ticket_id = T.ticket_id
    JOIN prize P
    ON P.prize_id = W.prize_id
    WHERE T.raffle_id = raffle_idIN
    ORDER BY ticket_id DESC 
    LOOP
        ticket_idOUT := reg.ticket_id;
       nameOUT      := reg.name;
       last_nameOUT := reg.last_name;
       cellOUT      := reg.cell;
       productOUT   := reg.product;
       RETURN NEXT;
    END LOOP;
    RETURN;
    END;
$BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.winnerByRaflle(INTEGER)
OWNER TO postgres;

--SELECT winnerByRaflle(1);