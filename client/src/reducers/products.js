import * as types from "../actions/types";

const productsReducer = (state = [], action) => {
  switch (action.type) {
    case types.LIST_PRODUCTS:
      return action.payload;
      break;

    default:
      return state;
  }
};

export default productsReducer;