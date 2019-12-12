using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MyShop.Controllers
{
    public class ProfileController : ControllerBase
    {
        // GET: Profile
        [HttpGet]
        public ActionResult Index()
        {
            if (!User.Identity.IsAuthenticated)
            {
                return RedirectToRoute("Login", "Account");
            }

            ViewBag.Title = "Account";
            return View();
        }

        // GET: Profile/PurchaseHistory/{id}
        [HttpGet]
        public ActionResult PurchaseHistory(int? id)
        {
            if (!User.Identity.IsAuthenticated)
            {
                return RedirectToRoute("Login", "Account");
            }

            if( id == null)
            {
                return RedirectToAction("Index");
            }

            ViewBag.Id = id;
            ViewBag.Title = "Purchase History";

            return View();
        }
    }
}
