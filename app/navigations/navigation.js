import React, { Component } from 'react';
import { Text, Navigator } from 'react-native';

import Guide from '../screens/guide';

export default class Navigation extends Component {

  constructor(props){
    super(props);
  }

  renderScene(route, nav){

    const page = <Guide/>;

    switch(route.page){
      case 'home':
      return page;
      default:
      break;
    }
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