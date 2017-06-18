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
            return new JsonResult(from c in User.Claims select new { c.Type, c.Value });
        }
    }
}