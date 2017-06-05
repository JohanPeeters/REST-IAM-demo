import * as types from "./types";
import axios from "axios";

export function allProducts() {
  return dispatch => {
    axios.get('/restheart/products')
      .then(response => {
        dispatch({
          type: types.LIST_PRODUCTS,
          payload: response.data._embedded
        })
      })
  }
}

export function addProduct(product) {
  return (dispatch, getState) => {
    console.debug(getState().keycloak.tokenParsed.preferred_username + ' added the product ' + product.title);
    axios.post('/restheart/products/', product)
      .then(() => {
        dispatch(allProducts());
      })
  }
}

export function deleteProduct(product) {
  return (dispatch, getState) => {
    console.debug(getState().keycloak.tokenParsed.preferred_username + ' deletes the product ' + product.title);
    axios.delete('/restheart/products/' + product._id.$oid)
      .then(() => {
        dispatch(allProducts());
      })
  }
}