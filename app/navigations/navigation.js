import React, { Component } from 'react';
import { Text, Navigator } from 'react-native';

import Guide from '../screens/guide';

export default class Navigation extends Component {

  constructor(props){
    super(props);
  }

  renderScene(route, nav){

    let Component = null;

    switch(route.page){
      case 'home':
      Component = Guide;
      default:
      break;
    }

    return <Component/>;
  }

  render() {
    return (
      <Navigator
        initialRoute={{ page: 'home',component: Guide}}
        renderScene={
          (route, nav) => this.renderScene(route, nav)
        }
        style={{padding: 100}}
      />
    );
  }
}