import {combineReducers} from "redux";
import {routerReducer} from "react-router-redux";
import products from "./products";
import keycloak from "./keycloak";

const productState = combineReducers({
  routing: routerReducer,
  products,
  keycloak
});

export default productState;