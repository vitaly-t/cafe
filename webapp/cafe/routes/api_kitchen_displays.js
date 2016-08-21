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


// Get list of kitchen displays
router.get('/', promise.coroutine(function*(req, res, next) {
    try {
        var client = yield db.connect();
        var sql = 
            " SELECT id, name, description, kitchen_id " +
            " FROM cf_kitchen_display " +
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

// Get kitchen display
router.get('/:id', promise.coroutine(function*(req, res, next) {
    req.checkParams("id", "id must be a non-empty string.").notEmpty();
    var errors = req.validationErrors();
    if (errors) {
        err = 'Validation errors: ' + util.inspect(errors);
        console.log(err);
        return res.status(400).send(err);
    }
    try {
        var client = yield db.connect();
        var sql = 
            " SELECT id, name, description, kitchen_id " +
            " FROM cf_kitchen_display " +
            " WHERE id = $1";
        var rows = yield client.query(sql, [req.params.id]);
        display = rows[0];
        console.log("Returning kitchen displays", display);
        return res.send(display);
    } catch (err) {
        console.log(err);
        res.status(500);
        return res.send(err);
    } finally {
        if (client) client.done();
    }
}));

module.exports = router;
