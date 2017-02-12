import Guide from '../screens/guide';

export default function getPage(name){
    let page = null;
    switch(name){
        case 'home':
        page = Guide;
        default:
        break;
    }

    return page;
}