using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyShop.Controllers
{
    public class AboutController : ControllerBase
    {
        // GET: About
        public ActionResult Index()
        {
            return View();
        }
    }
}