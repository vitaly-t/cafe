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


// Get list of menus
router.get('/', promise.coroutine(function*(req, res, next) {
    try {
        var client = yield db.connect();
        var sql = 
            " SELECT m.id, m.dt, m.menu_type_id, t.name, m.notes " +
            " FROM cf_menu m " +
            " JOIN cf_menu_type t ON m.menu_type_id = t.id ";
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


// Get menu
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
            " SELECT m.id, m.dt, m.menu_type_id, t.name AS menu_type_name, m.notes " +
            " FROM cf_menu m " +
            " JOIN cf_menu_type t ON m.menu_type_id = t.id " +
			" WHERE m.id = $1 ";
        var rows = yield client.query(sql, [req.params.id]);
        if (rows.length < 1) {
            err = 'Menu ' + req.params.id + ' does not exist.';
            console.log(err);
            return res.status(400).send(err);
        }
        var menu = rows[0];
        var sql = 
            " SELECT i.id, i.food_id, f.name AS food_name, i.kitchen_id, k.name as kitchen_name, i.pos_id, p.name as pos_name, COALESCE(i.qty, 0) AS qty, COALESCE(i.qty_extra, 0) AS qty_extra, COALESCE(i.qty_returned, 0) AS qty_returned " +
            " FROM cf_menu_item i " +
            " JOIN cf_food f ON i.food_id = f.id " +
            " JOIN cf_kitchen k ON i.kitchen_id = k.id " +
            " JOIN cf_pos p ON i.pos_id = p.id " +
            " WHERE i.menu_id = $1 ";
        var rows = yield client.query(sql, [req.params.id]);
        menu.menu_items = rows;
        return res.send(menu);
    } catch (err) {
        console.log(err);
        return res.status(500).send(err);
    } finally {
        if (client) client.done();
    }
}));


// Create menu
router.post('/', promise.coroutine(function*(req, res, next) {
	req.checkBody("dt", "id must be a non-empty string.").notEmpty();
	req.checkBody("menu_type_id", "menu_type_id must be a non-empty string.").notEmpty();
    var errors = req.validationErrors();
    if (errors) {
        err = 'Validation errors: ' + util.inspect(errors);
        console.log(err);
        return res.status(400).send(err);
    }
    try {
        var client = yield db.connect();
        var sql = 
			" INSERT INTO tasks(dt, menu_type_id, notes) " +
			" VALUES ($1, $2, $3) " + 
			" RETURNING id ";
		params = [req.body.dt, req.body.menu_type_id, req.body.notes];
        var rows = yield client.query(sql, params);
        if (rows.length < 1) {
            err = 'Error inserting menu.';
            console.log(err);
            return res.status(400).send(err);
        }
        return res.send({'id': rows[0].id});
    } catch (err) {
        console.log(err);
        return res.status(500).send(err);
    } finally {
        if (client) client.done();
    }
}));


module.exports = router;
