﻿

//Identityserver methods start
function logIdentityserver() {
    document.getElementById('resultsIdentityserver').innerText = '';

    Array.prototype.forEach.call(arguments, function (msg) {
        if (msg instanceof Error) {
            msg = "Error: " + msg.message;
        }
        else if (typeof msg !== 'string') {
            msg = JSON.stringify(msg, null, 2);
        }
        document.getElementById('resultsIdentityserver').innerHTML += msg + '\r\n';
    });
}

var mgr = makeRequest('GET', 'appsettings.json')
    .then(function (data) {
        var parsedData = JSON.parse(data);
        var config = {
            authority: parsedData.idSrvBaseUri,
            client_id: parsedData.serverurls,
            redirect_uri: parsedData.serverurls + "/callback.html",
            response_type: "id_token token",
            scope: "openid email address profile product.read product.readwrite",
            post_logout_redirect_uri: parsedData.serverurls + "/index.html"
        };
        var mgr = new Oidc.UserManager(config);
        return mgr;
    })
    .catch(function (err) {
        console.error('Error: ', err.statusText);
    });


mgr.then(
    mgr => mgr.getUser().then(function (user) {
    if (user) {
        logIdentityserver("User logged in with Identityserver", user.profile);
    }
    else {
        logIdentityserver("User not logged in with Identityserver");
    }
})
    );

function login() {
    mgr.then(
        mgr => mgr.signinRedirect()
    );
}

var productApi = makeRequest('GET', 'appsettings.json')
    .then(function (data) {
        var parsedData = JSON.parse(data);
        var productApi = parsedData.productApiBaseUri;
        return productApi;
    })
    .catch(function (err) {
        console.error('Error: ', err.statusText);
    });

function readproductapi() {
    path = "/product/read";
    mgr.then(
        mgr => mgr.getUser().then(function (user) {
            var url = productApi.then(function (readproductapi) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", readproductapi + path);
                xhr.onload = function () {
                    logIdentityserver(xhr.status, JSON.parse(xhr.responseText));
                };
                xhr.setRequestHeader("Authorization", "Bearer " + user.access_token);
                xhr.send();
            });
        })
        );
}

function writeproductapi() {
    path = "/product/write?productname=test";
    mgr.then(
        mgr => mgr.getUser().then(function (user) {
            var url = productApi.then(function (writeproductapi) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", writeproductapi + path);
                xhr.onload = function () {
                    logIdentityserver(xhr.status, JSON.parse(xhr.responseText));
                };
                xhr.setRequestHeader("Authorization", "Bearer " + user.access_token);
                xhr.send();
            });
        })
    );
}

function logout() {
    mgr.then(
        mgr => mgr.signoutRedirect()
    );
}
//Identityserver methods end


