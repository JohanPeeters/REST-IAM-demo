﻿using IdentityServer4;
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
                    AlwaysIncludeUserClaimsInIdToken = true,

                    RedirectUris =           { spaClientBaseUri + "/callback.html" },
                    PostLogoutRedirectUris = { spaClientBaseUri + "/index.html" },
                    AllowedCorsOrigins =     { spaClientBaseUri },

                    AllowedScopes =
                    {
                        IdentityServerConstants.StandardScopes.OpenId,
                        IdentityServerConstants.StandardScopes.Profile,
                        IdentityServerConstants.StandardScopes.Email,
                        IdentityServerConstants.StandardScopes.Address,
                        "product.read",
                        "product.readwrite",
                    }
                },
                // Postman resource owner flow
                new Client

                {
                    ClientId = "postman",
                    ClientName = "postman",
                    AllowedGrantTypes = GrantTypes.ResourceOwnerPassword,
                    ClientSecrets =
                    {
                      new Secret("secret".Sha256())
                    },
                    AllowedScopes = { "product.read" }
                },

                // Postman client credentials
                new Client

                {
                    ClientId = "postmanclientgrant",
                    ClientName = "postmanclientgrant",
                    AllowedGrantTypes = GrantTypes.ClientCredentials,
                    ClientSecrets =
                    {
                      new Secret("secret".Sha256())
                    },
                    AllowedScopes = { "product.read" }
                }
            };
        }
    }
}
