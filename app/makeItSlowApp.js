import React, { Component } from 'react';
import {
  Text,
  View
} from 'react-native';

// import { connect } from 'react-redux';

export default class MakeItSlowApp extends Component {
  constructor(props) {
    super(props);

    this.state = {
      days:0
    }
  }

  render() {
    var info = 'Your have '+ this.state.days +' days left';
    return (<View style={{ flex:1,flexDirection: 'column', justifyContent:'center',alignSelf:'center'}}><Text>{info}</Text></View>)
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