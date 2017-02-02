import * as types from '../actions/actionTypes';

const initialState = {
    page:'home'
};

export default function navigator(state = initialState, actions = {}){
    switch (action.type){
        case types.NAV_PUSH:
         return{
             ...state
         }
        default:
        return state;
    }
}