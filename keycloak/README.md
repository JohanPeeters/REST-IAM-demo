This project builds a KeyCloak image, pushes it to an AWS repository and deploys it.

The image has a single, administrative user, with username `admin`. The user is added through `keycloak-add-user.js`.

The image exposes listens for HTTPS requests on port 8443.
`standalone.xml` configures the HTTPS listener of the KeyCloak instance running in the Docker container. `standalone.conf` adds Java options that cause the realms defined in the `realms` directory to be loaded. The self-signed certificate and key pair used in the HTTPS connection is in `keystore.jks`. The key store was generated with

    keytool  -genkey -noprompt -trustcacerts -keyalg RSA -alias keytool.softwarewolves -dname "CN=softwarewolves.org" -keypass AranTheDog -keystore keystore.jks -storepass AranTheDog

## Contribution guidelines ##

Do not commit code unless it passes the acceptance tests.

## 2FA ##
Note: currently only Google Authenticator and FreeOTP are supported. This is subject to change: https://issues.jboss.org/browse/KEYCLOAK-4182 . Current limitations include that it is not possible to 'remember' the second factor
Next to the OPTIONAL (each user can choose to activate 2FA) enablement of 2FA, two auth flows have been created: "broker-otp" and "reset-password-require-otp". The first is to require an OTP on social login (when active) and the second is to require an OTP on password reset (when active). This means a user can NEVER ACCESS the account again if the second factor is lost! We can easily disable this requirement, but what's the value of having a second factor then... This aligns with industry standards.
Currently the OPTIONAL means that authenticator is used just if it's configured for particular user ( Authenticator.configuredFor returns true for that user). In case of OTP, it means that OTP form is shown just if OTP is configured for particular user.

## Multi-language support ##
For language setting logic, see https://issues.jboss.org/browse/KEYCLOAK-301.
PAY ATTENTION when impersonating a user! Having a locale cookie before impersonating the user will modify that user's language.
