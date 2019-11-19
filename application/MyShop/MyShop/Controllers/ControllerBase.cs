using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MyShop.Models;
using MyShop.DAL;
using Microsoft.AspNet.Identity;

namespace MyShop.Controllers
{
    public class ControllerBase : Controller
    {
        private ShopContext db = new ShopContext();
        private ApplicationDbContext applicationDbContext = new ApplicationDbContext();

        public int GetNoCartItem()
        {
            var userID = User.Identity.GetUserId();
            var currentOrder = db.orders.Where(o => o.CustomerID == userID).Where(o => o.OrderStatus == "pending").FirstOrDefault();

            if( currentOrder == null )
            {
                return 0;
            } 
            else
            {
                var numOfCartItem = db.orderItems.Where(i => i.OrderID == currentOrder.OrderID).Count();
                return numOfCartItem;
            }
        }

        public bool IsAdmin()
        {
            var userId = User.Identity.GetUserId();
            
            var role = applicationDbContext.Roles.Where(r => r.Name.Contains("administrator")).FirstOrDefault();
            var users = applicationDbContext.Users.Where(x => x.Roles.Select(y => y.RoleId).Contains(role.Id)).ToList();
            var IsAdmin = users.Find(x => x.Id == userId);

            if( IsAdmin == null )
            {
                return false;
            }
            return true;
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            ViewBag.IsAdmin = IsAdmin();
            ViewBag.NumOfCartItems = GetNoCartItem();

            base.OnActionExecuting(filterContext);
        }

    }
}