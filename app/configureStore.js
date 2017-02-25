import {AsyncStorage} from 'react-native';
import {createStore, applyMiddleware, combineReducers, compose} from 'redux';
import thunk from 'redux-thunk';
import {persistStore, autoRehydrate} from 'redux-persist';

import * as reducers from './reducers';

const reducer = combineReducers(reducers);

/**
 * configure redux store to persist and rehydrate.
 */
export default function configureStore(onComplete) {

	const enhancer = compose(
		applyMiddleware(thunk),
		autoRehydrate()
	);

	const store = createStore(
		reducer,
		{},
		enhancer
	);

	persistStore(store, {storage: AsyncStorage, blacklist:[]}, onComplete).purge();
	return store;
}