import React, {Component} from 'react';
// import { createStore, applyMiddleware, combineReducers } from 'redux';
import { Provider } from 'react-redux';
// import thunk from 'redux-thunk';

// import * as reducers from './reducers';
import configureStore from './configureStore';
import MakeItSlowApp from './makeItSlowApp';

// const createStoreWithMiddleware = applyMiddleware(thunk)(createStore);
// const reducer = combineReducers(reducers);
// const store = createStoreWithMiddleware(reducer);

export default class App extends Component {

constructor(){
  super();
  this.state ={
    store: configureStore(()=>{})
  }
}

  render() {

    return (
      <Provider store={this.state.store}>
        <MakeItSlowApp />
      </Provider>
    );
  }
}
