var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var expressValidator = require('express-validator');

var routes = require('./routes/index');
var menu = require('./routes/menu');
var api_menus = require('./routes/api_menus');
var api_kitchens = require('./routes/api_kitchens');
var api_poses = require('./routes/api_poses');
var api_foods = require('./routes/api_foods');
var api_menu_types = require('./routes/api_menu_types');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(expressValidator());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
// expose node_modules components to browser
app.use('/node_modules',  express.static(__dirname + '/node_modules'));
// add moment to locals
app.locals.moment = require('moment');

app.use('/', routes);
app.use('/menu', menu);
app.use('/api/menus', api_menus);
app.use('/api/kitchens', api_kitchens);
app.use('/api/poses', api_poses);
app.use('/api/foods', api_foods);
app.use('/api/menu_types', api_menu_types);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
