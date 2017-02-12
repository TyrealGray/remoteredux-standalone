import React, { Component } from 'react';
import { Text, Navigator } from 'react-native';

import getPage from './navigatorMap';

export default class Navigation extends Component {

  constructor(props){
    super(props);
  }

  renderScene(route, nav){

    let Page = getPage(route.page);

    return <Page/>;
  }

  render() {
    return (
      <Navigator
        initialRoute={{ page: 'home'}}
        renderScene={
          (route, nav) => this.renderScene(route, nav)
        }
        style={{padding: 100}}
      />
    );
  }
}