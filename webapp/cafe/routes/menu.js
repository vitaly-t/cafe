var config = require("../config");
var extend = require("extend");
var promise = require('bluebird');
var options = {
    promiseLib: promise
};
var pgp = require('pg-promise')(options);
var util = require('util');
var esc = require('pg-escape');

var express = require('express');
var router = express.Router();

var db = pgp(config.db);


// Add / Edit menu page
router.get('/', promise.coroutine(function*(req, res, next) {
    res.render('menu', { menuId: (req.query.id)?(req.query.id):"null" });
}));

module.exports = router;
