using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using IdentityModel;

namespace ProductApi.Controllers
{
    [Produces("application/json")]
    [Route("product")]
    [Authorize]
    public class ProductController : Controller
    {
        [Route("read")]
        //Authorize based on scope, see startup.cs
        [Authorize("read")]
        [HttpGet]
        public IActionResult Get()
        {
            var sub = User.Claims.Where(c => c.Type == JwtClaimTypes.Subject).Select(c => c.Value).SingleOrDefault();
            return new JsonResult("Client has access to the READ functionality, your sub is " + sub);
        }

        [Route("write")]
        //Authorize based on scope, see startup.cs
        [Authorize("readwrite")]
        [HttpGet]
        public IActionResult Get(string product)
        {
            var sub = User.Claims.Where(c => c.Type == JwtClaimTypes.Subject).Select(c => c.Value).SingleOrDefault();
            return new JsonResult("Client has access to the WRITE functionality, your sub is " + sub);
        }
    }


}