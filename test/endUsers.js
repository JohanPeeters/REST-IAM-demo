var kc = require('./api-calls.js');

module.exports =
{
    initialize: function(){
        return kc.adminAccessToken("admin","Aran","admin-cli").then(function(token) {
          accessToken = token;
        });
    },

    createUsers: function(n, realm){
        // create the result array
        var createPromises = [];
        // n times do
        for (var i = 0; i < n; i++) {
          // create a user
          var userName = randomString(6);
          var password = "password";
          var user = kc.createUser(accessToken, userName, password).then(function(response){
            var location = response.response.headers.location;
            if (response.response.statusCode == 201){
              return {
                'location': location,
                'userName': userName,
                'password': password
              }
            } else {
              return {};
            }
          }, function(err) {
            console.log('unable to create user: ' + err);
          });
          // put into the result array
          createPromises.push(user);
        }
        // return the result
        return createPromises;
  },

  deleteUsers: function(users) {
    var deletePromises = [];
    for (var user of users) {
      var deletePromise = kc.delete(accessToken, user.location).then(function(response){
        expect(response).to.have.status(204);
      }, function(err) {
        console.log('unable to delete: ' + err);
      });
      deletePromises.push(deletePromise);
    }
    return deletePromises;
  }
}

//private
var accessToken;

var randomString = function(length) {
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+=-[]{};'|:';/.,<>?\\\"";
    for(var i = 0; i < length; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}
