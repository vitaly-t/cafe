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

/* GET home page. */
router.get('/', promise.coroutine(function*(req, res, next) {
    // TODO - replace with real page
    res.redirect('/cafe/menus');
}));

module.exports = router;
