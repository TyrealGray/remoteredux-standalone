import * as types from '../actions/actionTypes';

import Guide from '../screens/guide';

function ggetPage(name){
    let page = null;
    
    switch(name){
        case 'home':
        page = Guide;
        default:
        break;
    }

    return page;
}

const initialState = {
    name: 'home',
    page: Guide
};

export default function navigator(state = initialState, actions = {}){
    switch (action.type){
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