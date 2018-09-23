const fs = require('fs');
var path = require('path');
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var cors = require('cors');
var createStore = require('./store');

module.exports.run = function (worker) {
	var httpServer = worker.httpServer;
	var scServer = worker.scServer;
	var store = createStore(worker.options);

	httpServer.on('request', app);

	app.set('view engine', 'ejs');
	app.set('views', path.resolve(__dirname, '..', 'views'));
	//app.use('/static', express.static('public'));

	//fs.readFileSync(path.resolve(__dirname, '../public/react.min'), 'utf8')
	app.get('/static/react.min.js', function(req, res){
		res.setHeader('Last-Modified', (new Date()).toUTCString());
		res.send(fs.readFileSync(path.resolve(__dirname, '../public/react.min.js'), 'utf8'));
	});

	//fs.readFileSync(path.resolve(__dirname, '../public/react-dom.min.js'), 'utf8')
	app.get('/static/react-dom.min.js', function(req, res){
		res.setHeader('Last-Modified', (new Date()).toUTCString());
		res.send(fs.readFileSync(path.resolve(__dirname, '../public/react-dom.min.js'), 'utf8'));
	});

	//fs.readFileSync(path.resolve(__dirname, '../public/remotedev-app.min.js'), 'utf8')
	app.get('/static/remotedev-app.min.js', function(req, res){
		res.setHeader('Last-Modified', (new Date()).toUTCString());
		res.send(fs.readFileSync(path.resolve(__dirname, '../public/remotedev-app.min.js'), 'utf8'));
	});

	app.get('/', function (req, res) {
		res.render('index', { port: worker.options.port});
	});

	app.use(cors({methods: 'POST'}));
	app.use(bodyParser.json());
	app.use(bodyParser.urlencoded({extended: false}));
	app.post('/', function (req, res) {
		if (!req.body) return res.status(404).end();
		switch (req.body.op) {
			case 'get':
				store.get(req.body.id).then(function (r) {
					res.send(r || {});
				});
				break;
			case 'list':
				store.list(req.body.query, req.body.fields).then(function (r) {
					res.send(r);
				});
				break;
			default:
				store.add(req.body).then(function (r) {
					res.send({id: r.id, error: r.error});
					scServer.exchange.publish('report', {
						type: 'add', data: store.selectors.byBaseFields(r)
					});
				});
		}
	});

	scServer.addMiddleware(scServer.MIDDLEWARE_EMIT, function (req, next) {
		var channel = req.event;
		var data = req.data;
		if (channel.substr(0, 3) === 'sc-' || channel === 'respond' || channel === 'log') {
			scServer.exchange.publish(channel, data);
		} else if (channel === 'log-noid') {
			scServer.exchange.publish('log', {id: req.socket.id, data: data});
		}
		next();
	});

	scServer.addMiddleware(scServer.MIDDLEWARE_SUBSCRIBE, function (req, next) {
		next();
		if (req.channel === 'report') {
			store.list().then(function (data) {
				req.socket.emit(req.channel, {type: 'list', data: data});
			});
		}
	});

	scServer.on('connection', function (socket) {
		var channelToWatch, channelToEmit;
		socket.on('login', function (credentials, respond) {
			if (credentials === 'master') {
				channelToWatch = 'respond';
				channelToEmit = 'log';
			} else {
				channelToWatch = 'log';
				channelToEmit = 'respond';
			}
			worker.exchange.subscribe('sc-' + socket.id).watch(function (msg) {
				socket.emit(channelToWatch, msg);
			});
			respond(null, channelToWatch);
		});
		socket.on('getReport', function (id, respond) {
			store.get(id).then(function (data) {
				respond(null, data);
			});
		});
		socket.on('disconnect', function () {
			var channel = worker.exchange.channel('sc-' + socket.id);
			channel.unsubscribe();
			channel.destroy();
			scServer.exchange.publish(
				channelToEmit,
				{id: socket.id, type: 'DISCONNECTED'}
			);
		});
	});
};
