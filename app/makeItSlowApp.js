import React, { Component } from 'react';
import {
  Text,
  View
} from 'react-native';

// import { connect } from 'react-redux';
import Styles from './styles/appStyle';

import Navigation from './navigations/navigation';

export default class MakeItSlowApp extends Component {
  constructor(props) {
    super(props);

    this.state = {
      days: 0
    }
  }

  render() {
    var info = 'Your have ' + this.state.days + ' days left';
    return (<View style={Styles.layout_contain}>
      <Navigation />
    </View>)
  }
}

// export default connect(
//   (state) => ({
//     state: null
//   }),
//   (dispatch) => ({
//     //increment: (id) => dispatch(actions.increment(id))
//   })
// )(MakeItSlowApp)