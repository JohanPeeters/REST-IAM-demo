var chakram = require('chakram'),
    expect = chakram.expect,
    wait = chakram.wait,
    get = chakram.get,
    post = chakram.post,
    put = chakram.put,
    del = chakram.delete;
var users_api = require('./users');

process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";
var keycloak_location = 'https://softwarewolves.org:8443';

var environment = process.env.npm_config_environment

function authorizationHeader(access_token) {
  return {"Authorization" : "Bearer " + access_token};
}

describe("A Colruyt user", function () {
  var realm = 'Colruyt';
  var authHeader;

  before("retrieve an access token", function() {
   return users_api.requestToken(keycloak_location, 'password', 'urbain user', 'this is more than 20 characters', 'ColruytApplication', realm)
   .then(function(token) {
     expect(token).to.have.length.above(100);
     authHeader = authorizationHeader(token);
   });
 })
})

describe("A Colruyt owner", function() {
  var realm = 'Colruyt';
  var authHeader;

  before("retrieve an access token", function() {
   return users_api.requestToken(keycloak_location, 'password', 'odette owner', 'this is more than 20 characters', 'ColruytApplication', realm)
   .then(function(token) {
     expect(token).to.have.length.above(100);
     authHeader = authorizationHeader(token);
   });
 })

})

describe("An Aldi owner", function() {
  var realm = 'Aldi';
  var authHeader;

  before("retrieve an access token", function() {
   return users_api.requestToken(keycloak_location, 'password', 'omer owner', 'this is more than 20 characters', 'AldiApplication', realm)
   .then(function(token) {
     expect(token).to.have.length.above(100);
     authHeader = authorizationHeader(token);
   });
 })

})

describe("A Aldi partner", function() {
   var realm = 'Aldi';
   var authHeader_delhaize;
   var authHeader_carrefour;
   var product_id;

   before("retrieve an access token", function() {
    return users_api.requestToken(keycloak_location, 'password', 'pauline partner',
                                  'this is more than 20 characters', 'AldiApplication', realm)
    .then(function(token) {
      expect(token).to.have.length.above(100);
      authHeader_delhaize = authorizationHeader(token);
      return users_api.requestToken(keycloak_location, 'password', 'patricia partner',
                                  'this is more than 20 characters', 'AldiApplication', realm);
                                })
                              })

})
