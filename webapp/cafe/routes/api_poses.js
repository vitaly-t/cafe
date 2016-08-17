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


// Get list of kitchens
router.get('/', promise.coroutine(function*(req, res, next) {
    try {
        var client = yield db.connect();
        var sql = 
            " SELECT id, name, description " +
            " FROM cf_pos " +
            " ORDER BY name ";
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
