/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,
	View,
	Platform
} from 'react-native';

import App from './app/entry';

AppRegistry.registerComponent('MakeItSlow', () => App);

if (Platform.OS == 'web') {
	var app = document.createElement('div');
	document.body.appendChild(app);
	AppRegistry.runApplication('App', {
		rootTag: app
	})
}