var chakram = require('chakram');

module.exports =
{
    initialize: function(keycloak_endpoint_value, realm_value){
        keycloakEndpoint = keycloak_endpoint_value,
        realm = realm_value

        initializeDefaultFields();
    },

    adminAccessToken: function(username_value, password_value, client_id_value) {
      var result;
      return this.requestToken('password', username_value, password_value, client_id_value, true)
        .then(function(response) {
          chakram.expect(response).to.have.status(200);
          return response.body.access_token;
        }, function(err) {
          console.log("cannot retrieve access token: " + err);
        });
    },

    requestToken: function(grant_type_value, username_value, password_value, client_id_value, isMaster) {
      var endpoint = oidcTokenEndpoint;
      if (isMaster) {
        endpoint = keycloakEndpoint + "/auth/realms/master/protocol/openid-connect/token";
      }
      return chakram.post(endpoint, undefined, {form:generateLoginFormData(grant_type_value,username_value,password_value, client_id_value)});
    },

    requestClients: function(access_token_value){
        return chakram.get(keycloakAuthAdminRealm+"clients",{headers:generateAuthenticationHeader(access_token_value)});
    },

    createUser: function(access_token_value,username_value,password_value){
        return chakram.post(keycloakAuthAdminRealm+"users",generateCreateUserJsonData(username_value), {headers:generateAuthenticationHeader(access_token_value)});
    },

    delete: function(access_token_value, url){
        return chakram.delete(url, undefined, {headers:generateAuthenticationHeader(access_token_value)});
    }
};

//private
var keycloakEndpoint, realm;
var keycloakAuthRealm;
var keycloakAuthAdminRealm;
var oidcTokenEndpoint;

var initializeDefaultFields = function(){
    keycloakAuthRealm = keycloakEndpoint + "/auth/realms/" + realm +"/";
    keycloakAuthAdminRealm = keycloakEndpoint + "/auth/admin/realms/" + realm + "/";
    oidcTokenEndpoint = keycloakAuthRealm + "protocol/openid-connect/token";
};

var generateAuthenticationHeader = function(access_token_value){
    return { 'Authorization': 'Bearer ' + access_token_value };
}

var generateLoginFormData = function (grant_type_value, username_value, password_value, client_id_value) {
    return {
        grant_type: grant_type_value,
        username: username_value,
        password: password_value,
        client_id: client_id_value
    };
};


var generateCreateUserJsonData = function(username_value){
    return {
        username: username_value
    };
};
