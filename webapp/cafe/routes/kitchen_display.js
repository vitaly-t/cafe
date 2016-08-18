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


// View kitchen display
router.get('/', promise.coroutine(function*(req, res, next) {
    res.render('kitchen_display', { 
        kitchenDisplayId: req.query.id,
        menuId: req.query.menu_id
    });
}));

module.exports = router;
