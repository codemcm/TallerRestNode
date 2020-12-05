/*
* Company: Universe Code
* Author: Laura Duran
* Edited by: Martin Cruz
* Created date: 2020-05-06
* Edited date: 2020-05-09
*/
--DATABASE NAME: mycompany
CREATE EXTENSION pgcrypto;

DROP TABLE IF EXISTS PUBLIC.ticket;
DROP TABLE IF EXISTS PUBLIC.prize;
DROP TABLE IF EXISTS PUBLIC.winner;
DROP TABLE IF EXISTS PUBLIC.raffle;
DROP TABLE IF EXISTS PUBLIC.client;
DROP TABLE IF EXISTS PUBLIC.user;


CREATE TABLE PUBLIC.user(
    user_id SERIAL NOT NULL,
    username VARCHAR(100),
    password VARCHAR(225),
    created_by INTEGER DEFAULT 1,
    created_date TIMESTAMP DEFAULT NOW(),
    updated_date TIMESTAMP DEFAULT NOW(),
    updated_by INTEGER DEFAULT 1,
    active BOOLEAN DEFAULT TRUE,
	  PRIMARY KEY (user_id)
);

--usuario 1
INSERT INTO PUBLIC.user(username,password) values ('Martin',PGP_SYM_ENCRYPT('1234','AES_KEY'));


ALTER TABLE PUBLIC.user 
ADD CONSTRAINT constraint_users_created FOREIGN KEY (created_by) REFERENCES PUBLIC.user (user_id);

ALTER TABLE PUBLIC.user 
ADD CONSTRAINT constraint_users_updated FOREIGN KEY (updated_by) REFERENCES PUBLIC.user (user_id);


CREATE TABLE PUBLIC.client(
    client_id SERIAL NOT NULL,
    name VARCHAR(50),
    last_name VARCHAR(100),
    cell VARCHAR(10) UNIQUE,
    email VARCHAR(50),
    observations VARCHAR(300),
    created_date TIMESTAMP DEFAULT NOW(),
    created_by INTEGER DEFAULT 1,
    updated_date TIMESTAMP DEFAULT NOW(),
    updated_by INTEGER DEFAULT 1,
    active BOOLEAN DEFAULT TRUE,
	  PRIMARY KEY (client_id),
      FOREIGN KEY (created_by)
        REFERENCES PUBLIC.user (user_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      FOREIGN KEY (updated_by)
        REFERENCES PUBLIC.user (user_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);



CREATE TABLE PUBLIC.raffle (
    raffle_id SERIAL NOT NULL,
    description VARCHAR(300),
    start_data TIMESTAMP,
    raffle_date TIMESTAMP NOT NULL,
    created_date TIMESTAMP DEFAULT NOW(),
    created_by INTEGER DEFAULT 1,
    updated_date TIMESTAMP DEFAULT NOW(),
    updated_by INTEGER DEFAULT 1,
    active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (raffle_id),
      FOREIGN KEY (created_by)
        REFERENCES PUBLIC.user (user_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      FOREIGN KEY (updated_by)
        REFERENCES PUBLIC.user (user_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);


CREATE TABLE PUBLIC.ticket (
  ticket_id SERIAL NOT NULL,
  raffle_id INT NOT NULL,
  client_id INT NOT NULL,
  created_date TIMESTAMP DEFAULT NOW(),
  created_by INTEGER DEFAULT 1,
  active BOOLEAN DEFAULT TRUE,
  PRIMARY KEY (ticket_id),
    FOREIGN KEY (raffle_id)
      REFERENCES PUBLIC.raffle (raffle_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    FOREIGN KEY (client_id)
      REFERENCES PUBLIC.client (client_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    FOREIGN KEY (created_by)
      REFERENCES PUBLIC.user (user_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);



CREATE TABLE PUBLIC.prize (
  prize_id SERIAL NOT NULL,
  product VARCHAR(100) NULL,
  raffle_id INT NOT NULL,
  created_date TIMESTAMP DEFAULT NOW(),
  created_by INTEGER DEFAULT 1,
  updated_date TIMESTAMP DEFAULT NOW(),
  updated_by INTEGER DEFAULT 1,
  active BOOLEAN DEFAULT TRUE,
  PRIMARY KEY (prize_id),
    FOREIGN KEY (raffle_id)
      REFERENCES PUBLIC.raffle (raffle_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    FOREIGN KEY (created_by)
      REFERENCES PUBLIC.user (user_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    FOREIGN KEY (updated_by)
      REFERENCES PUBLIC.user (user_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE PUBLIC.winner(
    winner_id SERIAL NOT NULL,
    ticket_id INT NOT NULL,
    prize_id INT NOT NULL,
    created_date TIMESTAMP DEFAULT NOW(),
    created_by INTEGER DEFAULT 1,
    active BOOLEAN DEFAULT TRUE,
	  PRIMARY KEY (winner_id),
      FOREIGN KEY (prize_id)
        REFERENCES PUBLIC.prize (prize_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      FOREIGN KEY (ticket_id)
        REFERENCES PUBLIC.ticket (ticket_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
      FOREIGN KEY (created_by)
        REFERENCES PUBLIC.user (user_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);
