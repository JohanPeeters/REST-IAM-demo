using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace InvoiceApi.Controllers
{
    [Produces("application/json")]
    [Route("invoice")]
    [Authorize]
    public class InvoiceController : Controller
    {
        [HttpGet]

        public IActionResult Get()
        //public String Get()
        {
            //  return "to be configured for Keycloak, see https://www.nuget.org/packages/Owin.Security.Keycloak";
            var mail = User.Claims.Where(c => c.Type == System.Security.Claims.ClaimValueTypes.Email).Select(c => c.Value).SingleOrDefault();
            return new JsonResult("Client has access to the invoice api, your mail is " + mail);
        }
    }
}