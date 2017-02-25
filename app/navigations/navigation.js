import React, { Component } from 'react';
import { Text, Navigator } from 'react-native';

import getPage from './navigatorMap';

import { connect } from 'react-redux';

class Navigation extends Component {

  constructor(props){
    super(props);
  }

  renderScene(route, nav){

    let Page = route.page;

    return <Page navigation={nav} />;
  }

  render() {
    const {navigator} = this.props;

    return (
      <Navigator
        initialRoute={navigator}
        renderScene={
          (route, nav) => this.renderScene(route, nav)
        }
        style={{padding: 100}}
      />
    );
  }
}

export default connect(
  (state) => ({
    navigator: state.navigator
  }),
  (dispatch) => ({
    //increment: (id) => dispatch(actions.increment(id))
  })
)(Navigation)