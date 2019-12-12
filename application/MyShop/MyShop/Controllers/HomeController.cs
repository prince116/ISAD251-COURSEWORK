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
        public ActionResult Index()
        {
            ViewBag.Title = "Home";

            return View();
        }

        // GET: About
        [Route("About")]
        public ActionResult About()
        {
            ViewBag.Title = "About";

            return View();
        }

        // GET: Contact
        [Route("Contact")]
        public ActionResult Contact()
        {
            ViewBag.Title = "Contact";

            return View();
        }

        // GET: Cart
        [Route("Cart")]
        public ActionResult Cart()
        {
            ViewBag.Title = "Cart";

            return View();
        }
        
        // GET: ThankYou
        [Route("ThankYou")]
        public ActionResult ThankYou()
        {
            ViewBag.Title = "Thank You";

            return View();
        }
    }
}