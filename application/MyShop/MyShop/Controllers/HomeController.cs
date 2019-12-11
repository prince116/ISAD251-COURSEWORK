﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyShop.Controllers
{
    public class HomeController : ControllerBase
    {
        public ActionResult Index()
        {
            ViewBag.Title = "Home";

            return View();
        }

        [Route("About")]
        public ActionResult About()
        {
            ViewBag.Title = "About";

            return View();
        }

        [Route("Contact")]
        public ActionResult Contact()
        {
            ViewBag.Title = "Contact";

            return View();
        }

        [Route("Cart")]
        public ActionResult Cart()
        {
            ViewBag.Title = "Cart";

            return View();
        }
        

        [Route("ThankYou")]
        public ActionResult ThankYou()
        {
            ViewBag.Title = "Thank You";

            return View();
        }
    }
}