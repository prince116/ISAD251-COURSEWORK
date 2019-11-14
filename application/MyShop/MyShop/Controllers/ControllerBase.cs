using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MyShop.Models;
using MyShop.DAL;
using System.Data.Entity;
using Microsoft.AspNet.Identity;

namespace MyShop.Controllers
{
    public class ControllerBase : Controller
    {
        private ShopContext db = new ShopContext();
        // GET: ControllerBase
        public int GetNoCartItem()
        {
            var userID = User.Identity.GetUserId();
            var currentOrder = db.orders.Where(o => o.CustomerID == userID).Where(o => o.OrderStatus == "pending").FirstOrDefault();

            if( currentOrder == null)
            {
                return 0;
            } 
            else
            {
                var numOfCartItem = db.orderItems.Where(i => i.OrderID == currentOrder.OrderID).Count();
                return numOfCartItem;
            }
        }

    }
}