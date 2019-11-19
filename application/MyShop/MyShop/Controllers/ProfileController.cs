using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using MyShop.Models;
using MyShop.ViewModels;
using MyShop.DAL;
using System.Collections;

namespace MyShop.Controllers
{
    public class ProfileController : ControllerBase
    {
        private ShopContext db = new ShopContext();

        // GET: Profile
        public ActionResult Index()
        {
            if( !User.Identity.IsAuthenticated )
            {
                return RedirectToRoute("Login", "Account");
            }

            var userId = User.Identity.GetUserId();
            var orders = ( IsAdmin() ) ? db.orders.Where(o => o.OrderStatus != "pending").ToList() : db.orders.Where(o => o.CustomerID == userId).Where(o => o.OrderStatus != "pending").ToList();

            var orderDetails = new ArrayList();
            var orderIdPrefix = "INV";

            foreach (var order in orders)
            {
                int total = 0;
                foreach (var item in order.OrderItems)
                {
                    total += (int)item.Product.Price * item.Quantity;
                }

                OrderHistory orderHistory = new OrderHistory();
                orderHistory.InvoiceNo = String.Concat(orderIdPrefix, order.OrderID.ToString("D8"));
                orderHistory.OrderID = order.OrderID;
                orderHistory.OrderDateTime = order.OrderDate;
                orderHistory.OrderStatus = order.OrderStatus;
                orderHistory.TotalAmount = total;
                orderDetails.Add(orderHistory);
            }

            ViewBag.Orders = orderDetails;

            return View();
        }

        public ActionResult PurchaseHistory(int? id)
        {
            if (!User.Identity.IsAuthenticated)
            {
                return RedirectToRoute("Login", "Account");
            }

            if ( id == null )
            {
                return RedirectToAction("Index");
            }

            var order = db.orders.Where(o => o.OrderID == id).FirstOrDefault();

            if (order == null)
            {
                return RedirectToAction("Index");
            }

            var orderIdPrefix = "INV";
            ViewBag.OrderID = String.Concat(orderIdPrefix, order.OrderID.ToString("D8"));
            ViewBag.OrderItems = order.OrderItems;

            return View();
        }

        // GET: Profile/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Profile/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Profile/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Profile/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Profile/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Profile/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Profile/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
