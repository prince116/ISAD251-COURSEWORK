using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyShop.Controllers
{
    public class HomeController : ControllerBase
    {
        // GET: 
        [HttpGet]
        [AllowAnonymous]
        public ActionResult Index()
        {
            ViewBag.Title = "Home";

            return View();
        }

        // GET: About
        [HttpGet]
        [Route("About")]
        [AllowAnonymous]
        public ActionResult About()
        {
            ViewBag.Title = "About";

            return View();
        }

        // GET: Contact
        [HttpGet]
        [Route("Contact")]
        [AllowAnonymous]
        public ActionResult Contact()
        {
            ViewBag.Title = "Contact";

            if( IsAdmin())
            {
                return View("~/Views/Admin/Contact/Index.cshtml");
            }

            return View();
        }

        // GET: Cart
        [HttpGet]
        [Route("Cart")]
        [AllowAnonymous]
        public ActionResult Cart()
        {
            ViewBag.Title = "Cart";

            return View();
        }

        // GET: ThankYou
        [HttpGet]
        [Route("ThankYou")]
        [AllowAnonymous]
        public ActionResult ThankYou()
        {
            ViewBag.Title = "Thank You";

            return View();
        }
    }
}