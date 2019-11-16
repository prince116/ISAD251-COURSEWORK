using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MyShop.DAL;
using MyShop.Models;
using Microsoft.AspNet.Identity;

namespace MyShop.Controllers
{
    public class OrderController : ControllerBase
    {
        private ShopContext db = new ShopContext();

        // GET: Order
        public ActionResult Index()
        {
            var UserID = User.Identity.GetUserId();

            if( UserID == null)
            {
                return RedirectToRoute(new { action = "Index", controller = "Home" });
            } 
            else
            {
                var order = db.orders.Where(o => o.OrderStatus == "pending").Where(o => o.CustomerID == UserID).FirstOrDefault();

                if( order == null)
                {
                    ViewBag.IsEmpty = true;
                } else
                {
                    ViewBag.IsEmpty = false;

                    var orderItem = db.orderItems.Where(i => i.OrderID == order.OrderID).Include(p => p.Product).ToList();
                    ViewBag.OrderItems = orderItem;
                }
            }

            return View();
            //return View();
            //return View(db.orders.ToList());
        }

        // GET: Order/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        // GET: Order/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Order/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(int ProductID, int Quantity)
        {
            var status = "ERROR";

            if (ModelState.IsValid)
            {
                var userID = User.Identity.GetUserId();
                var currentOrder = db.orders.Where(o => o.OrderStatus == "pending")
                                            .Where(o => o.CustomerID == userID)
                                            .FirstOrDefault();
                int orderID;

                if( currentOrder == null)
                {
                    var orderObj = new Order()
                    {
                        CustomerID = User.Identity.GetUserId(),
                        OrderStatus = "pending",
                        OrderDate = DateTime.Now
                    };

                    db.orders.Add(orderObj);
                    db.SaveChanges();

                    orderID = orderObj.OrderID;
                } 
                else
                {
                    orderID = currentOrder.OrderID;
                }

                var OrderItem = db.orderItems.Where(i => i.OrderID == orderID)
                                            .Where(i => i.ProductID == ProductID).FirstOrDefault();

                if( OrderItem == null)
                {
                    var orderItemObj = new OrderItem()
                    {
                        OrderID = orderID,
                        ProductID = ProductID,
                        Quantity = Quantity
                    };
                    db.orderItems.Add(orderItemObj);
                    db.SaveChanges();

                    if (orderItemObj.ItemID > 0)
                    {
                        status = "SUCCESS";
                    }
                }
                else
                {
                    OrderItem.Quantity += Quantity;
                    db.Entry(OrderItem).State = EntityState.Modified;
                    db.SaveChanges();

                    if( OrderItem.ItemID > 0)
                    {
                        status = "SUCCESS";
                    }
                }
                
                
                //return RedirectToAction("Index");
            }

            return Json(new { status = status });
        }

        // GET: Order/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        // POST: Order/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int ItemID, int Quantity)
        {
            var status = "ERROR";

            var OrderItem = db.orderItems.Where(i => i.ItemID == ItemID).FirstOrDefault();

            if( OrderItem == null)
            {

            }
            else
            {
                OrderItem.Quantity = Quantity;
                db.Entry(OrderItem).State = EntityState.Modified;
                db.SaveChanges();

                status = "SUCCESS";
            }

            return Json(new { status });
        }

        // GET: Order/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Order order = db.orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }
            return View(order);
        }

        // POST: Order/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            OrderItem orderItem = db.orderItems.Find(id);
            db.orderItems.Remove(orderItem);
            db.SaveChanges();
            return Json(new { status = "SUCCESS" });
        }

        [HttpPost, ActionName("Checkout")]
        [ValidateAntiForgeryToken]
        public ActionResult Checkout()
        {
            var status = "ERROR";
            var userID = User.Identity.GetUserId();

            Order order = db.orders.Where(o => o.CustomerID == userID).FirstOrDefault();

            if( order == null)
            {

            }
            else
            {
                order.OrderStatus = "checkout";
                db.Entry(order).State = EntityState.Modified;
                db.SaveChanges();

                status = "SUCCESS";
            }

            return RedirectToAction("ThankYou");

        }

        public ActionResult ThankYou()
        {
            return View();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
