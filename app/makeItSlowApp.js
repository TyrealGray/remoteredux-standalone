import React, { Component } from 'react';
import {
  Text,
  View
} from 'react-native';

// import { connect } from 'react-redux';

export default class MakeItSlowApp extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (<View style={{ flex:1,flexDirection: 'column', justifyContent:'center'}}><Text style={{alignSelf:'center'}}>Text</Text></View>)
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