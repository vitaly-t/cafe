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
    try {
        var client = yield db.connect();
        var sql = "SELECT d.id, d.dt, d.notes, t.name AS type_name FROM cf_day d JOIN cf_menu_type t ON d.menu_type_id=t.id ORDER BY d.dt DESC";
        var rows = yield client.query(sql);
        res.render('index', { days: rows, test: "Blah" });
    } catch (err) {
        console.log(err);
        //TODO - better error handling
        return res.status(500).send(err);
    } finally {
        if (client) client.done();
    }
}));

module.exports = router;
