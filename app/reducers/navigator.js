import * as types from '../actions/actionTypes';

import getPage from '../navigations/navigatorMap';

const initialState = {
    index: 0,
    name: 'home',
    page: getPage('home')
};

export default function navigator(state = initialState, actions = {}){
    switch (actions.type){
        case types.NAV_PUSH:
         return{
             ...state,
             name: action.page,
             page: getPage(actions.page)
         }
        default:
        return state;
    }
}