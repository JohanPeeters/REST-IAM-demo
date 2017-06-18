//Keycloak methods start
function logKeycloak() {
    document.getElementById('resultsKeycloak').innerText = '';

    Array.prototype.forEach.call(arguments, function (msg) {
        if (msg instanceof Error) {
            msg = "Error: " + msg.message;
        }
        else if (typeof msg !== 'string') {
            msg = JSON.stringify(msg, null, 2);
        }
        document.getElementById('resultsKeycloak').innerHTML += msg + '\r\n';
    });
}

var kcmgr = makeRequest('GET', 'appsettings.json')
    .then(function (data) {
        var parsedData = JSON.parse(data);
        var config = {
            authority: parsedData.keyCloakBaseUri,
            client_id: parsedData.keyCloakClientId,
            redirect_uri: parsedData.serverurls + "/callback.html",
            response_type: "id_token token",
            scope: "openid profile",
            post_logout_redirect_uri: parsedData.serverurls + "/index.html"
        };
        var kcmgr = new Oidc.UserManager(config);
        return kcmgr;
    })
    .catch(function (err) {
        console.error('Error: ', err.statusText);
    });


kcmgr.then(
    kcmgr => kcmgr.getUser().then(function (user) {
        if (user) {
            logKeycloak("User logged in with Keycloak", user.profile);
        }
        else {
            logKeycloak("User not logged in with Keycloak");
        }
    })
);

function loginKeycloak() {
    kcmgr.then(
        kcmgr => kcmgr.signinRedirect()
    );
}

var invoiceApi = makeRequest('GET', 'appsettings.json')
    .then(function (data) {
        var parsedData = JSON.parse(data);
        var invoiceApi = parsedData.invoiceApiBaseUri;
        return invoiceApi;
    })
    .catch(function (err) {
        console.error('Error: ', err.statusText);
    });

function kcapi() {
    path = "/invoice";
    kcmgr.then(
        kcmgr => kcmgr.getUser().then(function (user) {
            var url = invoiceApi.then(function (kcapi) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", kcapi + path);
                xhr.onload = function () {
                    logKeycloak(xhr.status, JSON.parse(xhr.responseText));
                };
                xhr.setRequestHeader("Authorization", "Bearer " + user.access_token);
                xhr.send();
            });
        })
    );
}

function logoutKeycloak() {
    kcmgr.then(
        kcmgr => kcmgr.signoutRedirect()
    );
}
//Keycloak methods end



