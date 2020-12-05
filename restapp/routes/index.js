var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});


const userModel = require('../src/userModel');
router.get( '/v1/user', userModel.getUsers );

module.exports = router;
