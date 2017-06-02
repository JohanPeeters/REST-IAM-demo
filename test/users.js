var chakram = require('chakram'),
  post = chakram.post;

module.exports =
{
  requestToken: function(keycloak_location, grant_type_value, username_value, password_value, client_id_value, realm) {
    var endpoint = keycloak_location + "/auth/realms/" + realm +"/protocol/openid-connect/token";
    var f = generateLoginFormData(grant_type_value,username_value,password_value, client_id_value);
    return post(endpoint, undefined, {form: f}).then(function(response) {
      return response.body.access_token;
    });
  }
}

var generateLoginFormData = function (grant_type_value, username_value, password_value, client_id_value) {
    return {
        grant_type: grant_type_value,
        username: username_value,
        password: password_value,
        client_id: client_id_value
    };
};
