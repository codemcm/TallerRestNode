/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: 
* Created date: 2020-05-17
* Edited date: 
*/
--DATABASE NAME: mycompany

DROP FUNCTION IF EXISTS  PUBLIC.random(INTEGER,INTEGER);
CREATE OR REPLACE FUNCTION PUBLIC.random(
    IN lowIn INTEGER,
    IN highIN INTEGER)
RETURNS INTEGER AS
$BODY$
BEGIN
 RETURN floor(random()* (highIN-lowIN + 1) + lowIN);
END
$BODY$
    LANGUAGE plpgsql VOLATILE
    COST 100;
	
ALTER FUNCTION PUBLIC.random(INTEGER,INTEGER)
OWNER TO postgres;

--SELECT publiC.random(1,10);