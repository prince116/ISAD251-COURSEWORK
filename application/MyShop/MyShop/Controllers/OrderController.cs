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
            return View(db.orders.ToList());
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
                        Quantiy = Quantity
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
                    OrderItem.Quantiy += Quantity;
                    db.Entry(OrderItem).State = EntityState.Modified;
                    db.SaveChanges();

                    if( OrderItem.ItemID > 0)
                    {
                        status = "SUCCESS";
                    }
                }
                
                
                //return RedirectToAction("Index");
            }

            return Json(new {status = status });
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
        public ActionResult Edit([Bind(Include = "OrderID,CustomerID,OrderStatus,OrderDate")] Order order)
        {
            if (ModelState.IsValid)
            {
                db.Entry(order).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(order);
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
            Order order = db.orders.Find(id);
            db.orders.Remove(order);
            db.SaveChanges();
            return RedirectToAction("Index");
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
