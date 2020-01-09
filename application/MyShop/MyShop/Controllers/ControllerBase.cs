using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MyShop.Models;
using Microsoft.AspNet.Identity;

namespace MyShop.Controllers
{
    public class ControllerBase : Controller
    {
        public ApplicationDbContext db = new ApplicationDbContext();

        public int max_quantity_value = 30;

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
            
            var role = db.Roles.Where(r => r.Name.Contains("administrator")).FirstOrDefault();
            var users = db.Users.Where(x => x.Roles.Select(y => y.RoleId).Contains(role.Id)).ToList();
            var IsAdmin = users.Find(x => x.Id == userId);

            if( IsAdmin == null )
            {
                return false;
            }
            return true;
        }

        public string GetUserId()
        {
            return User.Identity.GetUserId();
        }

        public UserInfo GetUserInfo(String userId)
        {
            var userInfo = db.userInfo.Where(u => u.UserId == userId).FirstOrDefault();

            return userInfo;
        }

        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            ViewBag.IsAdmin = IsAdmin();
            ViewBag.NumOfCartItems = GetNoCartItem();

            base.OnActionExecuting(filterContext);
        }

    }
}