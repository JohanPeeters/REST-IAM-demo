import "babel-polyfill";
import React from "react";
import ReactDOM from "react-dom";
import {Provider} from "react-redux";
import {applyMiddleware, createStore} from "redux";
import {Router, Route, browserHistory} from "react-router";
import {syncHistoryWithStore} from "react-router-redux";
import thunk from "redux-thunk";
import productState from "./reducers";
import ProductApp from "./components/productApp";
import ProductBox from "./components/productBox";
import ProductDetails from "./components/productDetails";
import Keycloak from "keycloak-js";
import axios from "axios";

const store = createStore(
  productState,
  applyMiddleware(thunk)
);

const history = syncHistoryWithStore(browserHistory, store);

const app = (
  <Provider store={store}>
    <Router history={history}>
      <Route component={ProductApp}>
        <Route path="/" component={ProductBox}/>
        <Route path="products/:productId" component={ProductDetails}/>
      </Route>
    </Router>
  </Provider>
);

const kc = Keycloak({
    url: 'https://softwarewolves.org:8443/auth',
    realm: 'Colruyt',
    clientId: 'colruytApplication'
});
kc.init({ flow: 'implicit' }, {onLoad: 'check-sso'}).success(authenticated => {
  if (authenticated) {
    store.getState().keycloak = kc;
    
    setInterval(() => {
      kc.updateToken(3600).error(() => kc.logout());
    }, 3600000);

    ReactDOM.render(app, document.getElementById("app"));

  } else {
    // show possibly other page here...
    kc.login();
  }
});

axios.interceptors.request.use(config => {
  config.headers = {...config.headers, ...{
    'Content-Type': 'application/json',
    Accept: 'application/json',
    Authorization: 'Bearer ' + kc.token
  }};
  return config;
});