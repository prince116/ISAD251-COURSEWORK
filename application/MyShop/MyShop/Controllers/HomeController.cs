using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using MyShop.Models;
using MyShop.ViewModels;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

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

        [Route("Users")]
        public ActionResult Users()
        {
            var userRoles = new List<RolesViewModel>();
            var context = new ApplicationDbContext();
            var userStore = new UserStore<ApplicationUser>(context);
            var userManager = new UserManager<ApplicationUser>(userStore);

            //Get all the usernames
            foreach (var user in userStore.Users)
            {
                var r = new RolesViewModel
                {
                    UserName = user.UserName
                };
                userRoles.Add(r);
            }
            //Get all the Roles for our users
            foreach (var user in userRoles)
            {
                user.RoleNames = userManager.GetRoles(userStore.Users.First(s => s.UserName == user.UserName).Id);
            }

            return View(userRoles);
        }

    }
}