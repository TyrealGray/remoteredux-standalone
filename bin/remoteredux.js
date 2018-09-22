#!/usr/bin/env node
var electron = require('electron');
var spawn = require('cross-spawn');
var argv = process.argv.slice(2);
var path = require('path');


var result = spawn.sync(
	electron,
	[path.join( __dirname, "remotedev" )].concat(argv),
	{stdio: 'ignore'}
);
process.exit(result.status);