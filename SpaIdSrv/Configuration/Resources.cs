using IdentityModel;
using IdentityServer4.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SpaIdSrv.Configuration
{
    public class Resources
    {
        //Api resource configures the access token
        public static IEnumerable<ApiResource> GetApiResources()
        {
            return new[]
            {           
                // expanded version if more control is needed
                new ApiResource
                {
                    //name will be used for audience
                    Name = "productapi",

                    // include the following using claims in access token (in addition to subject id)
                    //UserClaims = { JwtClaimTypes.PreferredUserName },

                    // this API defines two scopes
                    Scopes =
                    {
                        new Scope()
                        {
                            Name = "product.read",
                            DisplayName = "Read access to product API",
                        },
                        new Scope
                        {
                            Name = "product.readwrite",
                            DisplayName = "Full access to product API"
                        }
                    }
                }
            };
        }
        //Identityresource configures the identity token
        public static IEnumerable<IdentityResource> GetIdentityResources()
            {
                return new List<IdentityResource>
            {
                new IdentityResources.OpenId(),
                new IdentityResources.Profile(),
            };
            }
        }
    }
