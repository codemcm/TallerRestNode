/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: Martin Cruz
* Created date: 2020-05-09
* Edited date: 2020-05-09
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS  PUBLIC.prizeAdd(VARCHAR(100), INTEGER, INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.prizeAdd(
    IN productIN VARCHAR(50),
    IN raffle_idIN INTEGER,
    IN created_byIN INTEGER,
    OUT prize_idOUT INTEGER)
RETURNS SETOF INTEGER AS
$BODY$
DECLARE prize_idx INTEGER;
BEGIN
    INSERT INTO PUBLIC.prize (product, raffle_id,created_by)
    VALUES (productIN, raffle_idIN,created_byIN)
    RETURNING prize_id INTO prize_idx;
    RETURN QUERY
    SELECT prize_idx
RETURN;
END;
$BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;

ALTER FUNCTION PUBLIC.prizeAdd(VARCHAR(100), INTEGER,INTEGER)
OWNER TO postgres;

/*
SELECT prizeAdd('aceite',1,1);
SELECT prizeAdd('playera',2,1);
SELECT prizeAdd('cambio de aceite',3,1);
SELECT prizeAdd('filtro',4,1);
*/


