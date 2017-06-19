using IdentityServer4;
using IdentityServer4.Models;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SpaIdSrv.Configuration
{
    public class Clients
    {
        public static IEnumerable<Client> GetClients(string spaClientBaseUri)
        {
            return new List<Client>
            {
                // JavaScript Client
                new Client

                {
                    ClientId = spaClientBaseUri,
                    ClientName = "SPAClient",
                    AllowedGrantTypes = GrantTypes.Implicit,
                    AllowAccessTokensViaBrowser = true,

                    RedirectUris =           { spaClientBaseUri + "/callback.html" },
                    PostLogoutRedirectUris = { spaClientBaseUri + "/index.html" },
                    AllowedCorsOrigins =     { spaClientBaseUri },

                    AllowedScopes =
                    {
                        IdentityServerConstants.StandardScopes.OpenId,
                        IdentityServerConstants.StandardScopes.Profile,
                        "productapi"
                    }
                },
                // Postman
                new Client

                {
                    ClientId = "postman",
                    ClientName = "postman",
                    AllowedGrantTypes = GrantTypes.ResourceOwnerPassword,
                    ClientSecrets =
                    {
                      new Secret("secret".Sha256())
                    },
                    AllowedScopes = { "productapi" }
                }
            };
        }
    }
}
