const promise = require('bluebird');
const options = { promiseLib: promise };
const pgp = require('pg-promise')(options);

// Preparing the connection details:
const cn = 'postgres://postgres:root@localhost:5432/mycompany';

// Creating a new database instance from the connection details:
const db = pgp(cn);
// Exporting the database object for shared use:
module.exports = db;