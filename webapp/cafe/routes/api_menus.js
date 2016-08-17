var config = require("../config");
var extend = require("extend");
var promise = require('bluebird');
var options = {
    promiseLib: promise
};
var pgp = require('pg-promise')(options);
var util = require('util');
var esc = require('pg-escape');
var moment = require('moment');

var express = require('express');
var router = express.Router();

var db = pgp(config.db);


// Search
router.get('/search', promise.coroutine(function*(req, res, next) {
    console.log("Seaching for menu with dt", req.query.dt);
    req.checkQuery("dt", "Data musi byc podana.").notEmpty();
    var errors = req.validationErrors();
    if (errors) {
        err = 'Validation errors: ' + util.inspect(errors);
        console.log(err);
        return res.status(400).send(err);
    }
    try {
        var client = yield db.connect();
        var sql =
            " SELECT m.id " +
            " FROM cf_menu m " +
			" WHERE m.dt = $1 ";
        var rows = yield client.query(sql, [req.query.dt]);
        console.log("Returning search results:", rows);
        return res.send(rows);
    } catch (err) {
        console.log(err);
        return res.status(500).send(err);
    } finally {
        if (client) client.done();
    }
}));

// Get list of menus
router.get('/', promise.coroutine(function*(req, res, next) {
    try {
        var client = yield db.connect();
        // Cast date to varchar to avoid Node converting it to full 
        // date with local time which causes dates to jump 
        var sql = 
            " SELECT m.id, m.dt::VARCHAR(64), m.menu_type_id, t.name, m.notes " +
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
        // Cast date to varchar to avoid Node converting it to full 
        // date with local time which causes dates to jump 
        var sql =
            " SELECT m.id, m.dt::VARCHAR(64), m.menu_type_id, t.name AS menu_type_name, m.notes " +
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
            " WHERE i.menu_id = $1 " +
            " ORDER BY p.name ";
        var rows = yield client.query(sql, [req.params.id]);
        menu.menu_items = rows;
        console.log("Returning menu:", menu);
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
    console.log("Creating menu:", req.body);
    // validate and sanitize
	req.checkBody("dt", "Data jest wymagana.").notEmpty();
	req.checkBody("menu_type_id", "Typ menu jest wymagany.").notEmpty();
    var errors = req.validationErrors();
    if (errors) {
        console.log("Validation errors:", errors);
        return res.status(400).send(errors);
    }
    // update implementation
    try {
        var client = yield db.connect();
        yield client.query("BEGIN TRANSACTION");
        var sql = 
			" INSERT INTO cf_menu(dt, menu_type_id, notes) " +
			" VALUES ($1, $2, $3) " + 
			" RETURNING id ";
		params = [req.body.dt, req.body.menu_type_id, req.body.notes];
        var rows = yield client.query(sql, params);
        if (rows.length < 1) {
            err = 'Error inserting menu.';
            console.log(err);
            return res.status(400).send(err);
        }
        menu_id = rows[0].id;
        if (req.body.menu_items) {
            var i;
            for (i = 0; i<req.body.menu_items.length; i++) {
                var item = req.body.menu_items[i];
                var sql = 
                    " INSERT INTO cf_menu_item(menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned) " +
                    " VALUES($1, $2, $3, $4, $5, $6, $7) ";
                params = [menu_id, item.food_id, item.kitchen_id, item.pos_id, parseFloat(item.qty), parseFloat(item.qty_extra), parseFloat(item.qty_returned)];
                yield client.query(sql, params);
            }
        }
        yield client.query("COMMIT TRANSACTION");
        return res.send();
    } catch (err) {
        console.log(err);
        yield client.query("ROLLBACK TRANSACTION");
        return res.status(500).send(err);
    } finally {
        if (client) client.done();
    }
}));


// Save menu
router.post('/:id', promise.coroutine(function*(req, res, next) {
    console.log("Saving menu id ", req.params.id, ":", req.body);
    // validate and sanitize
	req.checkBody("dt", "Data jest wymagana.").notEmpty();
	req.checkBody("menu_type_id", "Typ menu jest wymagany.").notEmpty();
    var errors = req.validationErrors();
    if (errors) {
        console.log("Validation errors:", errors);
        return res.status(400).send(errors);
    }
    // update implementation
    try {
        var client = yield db.connect();
        yield client.query("BEGIN TRANSACTION");
        var sql = 
			" UPDATE cf_menu " +
			" SET dt = $2, menu_type_id = $3, notes = $4 " +
            " WHERE id = $1 ";
		params = [req.params.id, req.body.dt, req.body.menu_type_id, req.body.notes];
        yield client.query(sql, params);
        var sql = 
			" DELETE FROM cf_menu_item  " +
			" WHERE menu_id = $1 ";
		params = [req.params.id];
        yield client.query(sql, params);
        if (req.body.menu_items) {
            var i;
            for (i = 0; i < req.body.menu_items.length; i++) {
                var item = req.body.menu_items[i];
                var sql = 
                    " INSERT INTO cf_menu_item(menu_id, food_id, kitchen_id, pos_id, qty, qty_extra, qty_returned) " +
                    " VALUES($1, $2, $3, $4, $5, $6, $7) ";
                params = [req.params.id, item.food_id, item.kitchen_id, item.pos_id, parseFloat(item.qty), parseFloat(item.qty_extra), parseFloat(item.qty_returned)];
                yield client.query(sql, params);
            }
        }
        yield client.query("COMMIT TRANSACTION");
        return res.send();
    } catch (err) {
        console.log(err);
        yield client.query("ROLLBACK TRANSACTION");
        return res.status(500).send(err);
    } finally {
        if (client) client.done();
    }
}));


module.exports = router;
