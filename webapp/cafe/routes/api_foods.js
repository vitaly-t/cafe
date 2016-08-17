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


// Get list of foods
router.get('/', promise.coroutine(function*(req, res, next) {
    try {
        var client = yield db.connect();
        var sql = 
            " SELECT f.id, f.name, f.description, f.food_type_id, t.name as food_type_name " +
            " FROM cf_food f " +
            " JOIN cf_food_type t ON f.food_type_id = t.id " +
            " ORDER BY f.name ";
        var rows = yield client.query(sql);
        return res.send(rows);
    } catch (err) {
        console.log(err);
        res.status(500);
        return res.send(err);
    } finally {
        if (client) client.done();
    }
}));


module.exports = router;
