using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Web.Mvc;
using MyShop.Models;
using System.Collections;
using System.Data.Entity;
using System.IO;

namespace MyShop.Controllers
{
    public class APIController : ControllerBase
    {
        // GET: API
        public ActionResult Index()
        {
            return HttpNotFound();
        }

        // Contact Section API
        [HttpGet]
        [ActionName("Contacts")]
        public JsonResult GetAllContacts()
        {
            var Contacts = db.contacts.OrderByDescending(c => c.ID).ToList();

            Response.StatusCode = (int)HttpStatusCode.OK;
            return Json(new { Contacts }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        [ActionName("Contact")]
        public JsonResult GetContact(int id)
        {
            var contact = db.contacts.FirstOrDefault(e => e.ID == id);

            if (contact != null)
            {
                Response.StatusCode = (int)HttpStatusCode.OK;
                return Json(new { contact }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                Response.StatusCode = (int)HttpStatusCode.NotFound;
                return Json(new { Message = "Record With ID " + id.ToString() + " not found" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ActionName("Contact")]
        public JsonResult CreateContact(Contact contact)
        {
            try
            {
                contact.CreatedAt = DateTime.Now;
                contact.LastModifiedAt = DateTime.Now;
                contact.UserID = GetUserId();
                db.contacts.Add(contact);
                db.SaveChanges();

                Response.StatusCode = (int)HttpStatusCode.Created;
                return Json( new { Mesasge = "Record has been created." });
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(new { Mesasge = "Bad Request." });
            }

        }

        [HttpPut]
        [ValidateAntiForgeryToken]
        [ActionName("Contact")]
        public JsonResult UpdateContact(int id, Contact contact)
        {
            try
            {
                var record = db.contacts.FirstOrDefault(e => e.ID == id);

                if (record == null)
                {
                    Response.StatusCode = (int)HttpStatusCode.NotFound;
                    return Json(new { Mesasge = "Record with ID " + id.ToString() + " not found to update." });
                }
                else
                {
                    record.FirstName = contact.FirstName;
                    record.LastName = contact.LastName;
                    record.Subject = contact.Subject;
                    record.Message = contact.Message;
                    record.Email = contact.Email;
                    record.LastModifiedAt = DateTime.Now;

                    db.SaveChanges();

                    Response.StatusCode = (int)HttpStatusCode.OK;
                    return Json(new { Mesasge = "Record with ID " + id.ToString() + " has been updated." });
                }


            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(new { Mesasge = "Bad Request." });
            }
        }

        [HttpDelete]
        [ValidateAntiForgeryToken]
        [ActionName("Contact")]
        public JsonResult DeleteContact(int id)
        {
            try
            {
                var record = db.contacts.FirstOrDefault(e => e.ID == id);

                if (record == null)
                {
                    Response.StatusCode = (int)HttpStatusCode.NotFound;
                    return Json(new { Mesasge = "Record with ID " + id.ToString() + " not found to delete." });
                }
                else
                {
                    db.contacts.Remove(record);
                    db.SaveChanges();
                    Response.StatusCode = (int)HttpStatusCode.OK;
                    return Json(new { Mesasge = "Record with ID " + id.ToString() + " has been deleted." });
                }
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(new { Mesasge = "Bad Request." });
            }
        }

        [HttpGet]
        [ActionName("Products")]
        public JsonResult GetAllProducts()
        {
            var keyword = Request["keyword"];
            string category_id = Request["categoryId"];
            var entity = (dynamic)null;

            if( keyword != null)
            {
                entity = db.products.Where(s => s.SalesPeriodStartAt <= DateTime.Now && s.SalesPeriodEndAt >= DateTime.Now)
                                    .Where(p => p.ProductName.Contains(keyword) || p.ProductDescription.Contains(keyword))
                                    .Include(p => p.ProductCategories)
                                    .ToList();
            }
            else if ( category_id != null )
            {
                bool isParsable = Int16.TryParse(category_id, out var cid);

                if(isParsable)
                {
                    entity = db.products.Where(s => s.SalesPeriodStartAt <= DateTime.Now && s.SalesPeriodEndAt >= DateTime.Now)
                                        .Where(p => p.CategoryID == cid)
                                        .Include(p => p.ProductCategories)
                                        .ToList();
                }

            }
            else
            {

                entity = db.products.Where(s => s.SalesPeriodStartAt <= DateTime.Now && s.SalesPeriodEndAt >= DateTime.Now)
                                        .Include(c => c.ProductCategories).OrderByDescending(c => c.ProductID).ToList();
            }

            var products = new ArrayList();

            if( entity != null)
            {
                foreach(var item in entity)
                {
                    var product = new
                    {
                        product_id = item.ProductID,
                        product_name = item.ProductName,
                        product_description = item.ProductDescription,
                        category_id = item.CategoryID,
                        category_name = item.ProductCategories.CategoryName,
                        price = item.Price.ToString("C"),
                        discounted_price = item.DiscountedPrice.ToString("C"),
                        stock = item.StockQuantity
                    };

                    products.Add(product);
                }
            }

            Response.StatusCode = (int)HttpStatusCode.OK;
            return Json(new { products }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        [ActionName("Product")]
        public JsonResult GetProduct(int id)
        {
            var product = db.products.Include(c => c.ProductCategories).FirstOrDefault(e => e.ProductID == id);

            if (product != null)
            {
                var details = new
                {
                    id = product.ProductID,
                    name = product.ProductName,
                    description = product.ProductDescription,
                    category = product.ProductCategories.CategoryName,
                    price = product.Price.ToString("C"),
                    discounted_price = product.DiscountedPrice.ToString("C"),
                    sales_period_start = product.SalesPeriodStartAt.ToString(string.Format("yyyy-MM-dd")),
                    sales_period_end = product.SalesPeriodEndAt.ToString(string.Format("yyyy-MM-dd")),
                    stock = product.StockQuantity,
                    file_path = "/Uploads/" + product.FilePath
                };

                var responseObj = new
                {
                    product = details
                };

                var getRelatedProduct = Request["related"];

                if (getRelatedProduct == "true")
                {
                    var relatedProducts = db.products.Where(p => p.CategoryID == product.CategoryID)
                                                    .Where(p => p.ProductID != id)
                                                    .Where(p => p.SalesPeriodStartAt <= DateTime.Now && p.SalesPeriodEndAt >= DateTime.Now)
                                                    .Take(4)
                                                    .ToList();

                    if( relatedProducts != null)
                    {
                        var related = new ArrayList();

                        foreach(var item in relatedProducts)
                        {
                            var relatedProductDetails = new
                            {
                                id = item.ProductID,
                                name = item.ProductName,
                                price = item.Price.ToString("C"),
                                discounted_price = item.DiscountedPrice.ToString("C"),
                                stock = (item.StockQuantity > 0) ? "In stock" : "Out of stock"
                            };

                            related.Add(relatedProductDetails);
                        }

                        Response.StatusCode = (int)HttpStatusCode.OK;
                        return Json(new { product = details, related_product = related }, JsonRequestBehavior.AllowGet);

                    }
                } 
                else
                {
                    Response.StatusCode = (int)HttpStatusCode.OK;
                    return Json(new { product = details }, JsonRequestBehavior.AllowGet);
                }
            }

            Response.StatusCode = (int)HttpStatusCode.NotFound;
            return Json(new { Message = "Record With ID " + id.ToString() + " not found" }, JsonRequestBehavior.AllowGet);
            
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ActionName("Product")]
        public ActionResult CreateProduct(Product product)
        {
            try
            {
                if( !ModelState.IsValid )
                {
                    var errors = new ArrayList();

                    foreach (ModelState modelState in ViewData.ModelState.Values)
                    {
                        foreach (ModelError error in modelState.Errors)
                        {
                            errors.Add(error.ErrorMessage.ToString());
                        }
                    }
                    return Json(new { errors });
                }

                if( Request.Files.Count > 0 )
                {
                    var file = Request.Files[0];
                    var fileName = "file_" + DateTime.Now.ToString("yyyyMMddhhmmss") + Path.GetExtension(file.FileName);
                    var path = Server.MapPath("~/Uploads/");
                    if( !Directory.Exists(path))
                    {
                        Directory.CreateDirectory(path);
                    }
                    product.FilePath = fileName;
                    file.SaveAs(path + fileName);
                }

                product.CreatedAt = DateTime.Now;
                product.LastModifiedAt = DateTime.Now;
                db.products.Add(product);
                db.SaveChanges();

                Response.StatusCode = (int)HttpStatusCode.Created;
                return Json(new { Mesasge = "Record has been created." });

            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(new { message = ex.Message, innerexception = ex.InnerException.InnerException.Message });
            }

        }

        [HttpPut]
        [ValidateAntiForgeryToken]
        [ActionName("Product")]
        public JsonResult UpdateProduct(int id, Product product)
        {
            if( IsAdmin())
            {
                try
                {
                    var record = db.products.FirstOrDefault(e => e.ProductID == id);

                    if (record == null)
                    {
                        Response.StatusCode = (int)HttpStatusCode.NotFound;
                        return Json(new { Mesasge = "Record with ID " + id.ToString() + " not found to update." });
                    }
                    else
                    {
                        record.ProductName = product.ProductName;
                        record.ProductCategories = product.ProductCategories;
                        record.ProductDescription = product.ProductDescription;
                        record.Price = product.Price;
                        record.DiscountedPrice = product.DiscountedPrice;
                        record.SalesPeriodStartAt = product.SalesPeriodStartAt;
                        record.SalesPeriodEndAt = product.SalesPeriodEndAt;
                        record.StockQuantity = product.StockQuantity;
                        record.LastModifiedAt = DateTime.Now;

                        if (Request.Files.Count > 0)
                        {
                            var file = Request.Files[0];
                            var fileName = "file_" + DateTime.Now.ToString("yyyyMMddhhmmss") + Path.GetExtension(file.FileName);
                            var path = Server.MapPath("~/Uploads/");
                            if (!Directory.Exists(path))
                            {
                                Directory.CreateDirectory(path);
                            }
                            record.FilePath = fileName;
                            file.SaveAs(path + fileName);
                        }

                        db.SaveChanges();

                        Response.StatusCode = (int)HttpStatusCode.OK;
                        return Json(new { Mesasge = "Record with ID " + id.ToString() + " has been updated." });
                    }


                }
                catch (Exception ex)
                {
                    Response.StatusCode = (int)HttpStatusCode.BadRequest;
                    return Json(new { Mesasge = "Bad Request." });
                }

            } 
            else
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(new { Mesasge = "Bad Request." });
            }
        }

        [HttpDelete]
        [ValidateAntiForgeryToken]
        [ActionName("Product")]
        public JsonResult DeleteProduct(int id)
        {
            try
            {
                var record = db.products.FirstOrDefault(e => e.ProductID == id);

                if (record == null)
                {
                    Response.StatusCode = (int)HttpStatusCode.NotFound;
                    return Json(new { Mesasge = "Record with ID " + id.ToString() + " not found to delete." });
                }
                else
                {
                    db.products.Remove(record);
                    db.SaveChanges();
                    Response.StatusCode = (int)HttpStatusCode.OK;
                    return Json(new { Mesasge = "Record with ID " + id.ToString() + " has been deleted." });
                }
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json(new { Mesasge = "Bad Request." });
            }
        }

        [HttpGet]
        [ActionName("Orders")]
        public JsonResult GetAllOrders()
        {
            var userID = GetUserId();

            if( userID != null)
            {
                var orders = (IsAdmin()) ? db.orders.Where(o => o.OrderStatus != "pending").OrderByDescending(o => o.OrderID).ToList() : db.orders.Where(o => o.CustomerID == userID).Where(o => o.OrderStatus != "pending").OrderByDescending(o => o.OrderID).ToList();
                var records = new ArrayList();

                if(orders.Count > 0)
                {
                    foreach(var record in orders)
                    {
                        // Calculate the total amount of the order
                        var total = 0;

                        foreach(var item in record.OrderItems)
                        {
                            total += (int)item.Product.DiscountedPrice > 0 ? (int)item.Product.DiscountedPrice * item.Quantity : (int)item.Product.Price * item.Quantity;
                        }

                        records.Add(new {
                            invoice_no = String.Concat("INV", record.OrderID.ToString("D8")),
                            order_no = record.OrderID,
                            order_datetime = record.OrderDate.ToString("yyyy-MM-dd"),
                            order_status = record.OrderStatus.ToUpper(),
                            total_amount = total.ToString("C")
                        });
                    }

                }

                Response.StatusCode = (int)HttpStatusCode.OK;
                return Json(new { orders = records }, JsonRequestBehavior.AllowGet);
            }

            Response.StatusCode = (int)HttpStatusCode.Unauthorized;
            return Json(new { Message = "Unauthorized" }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        [ActionName("Order")]
        public JsonResult GetOrder(int? id)
        {
            var userId = GetUserId();

            if( userId != null)
            {
                var currentOrder = ( id == null ) ? getCurrentOrder(userId) : id;
                var orderedItems = new ArrayList();

                var entity = db.orderItems.Where(o => o.OrderID == currentOrder).ToList();
                decimal totalAmount = 0;

                if(entity.Count > 0)
                {
                    foreach(var item in entity)
                    {
                        var subTotal = (item.Product.DiscountedPrice > 0) ? (item.Product.DiscountedPrice * item.Quantity) : (item.Product.Price * item.Quantity);
                        orderedItems.Add(new
                        {
                            item_id = item.ItemID,
                            product_id = item.ProductID,
                            product_name = item.Product.ProductName,
                            price = (item.Product.DiscountedPrice > 0) ? item.Product.DiscountedPrice.ToString("C") : item.Product.Price.ToString("C"),
                            sub_total = subTotal.ToString("C"),
                            file_path = "/Uploads/" + item.Product.FilePath,
                            quantity = item.Quantity
                        });

                        totalAmount += subTotal;
                    }
                }

                Response.StatusCode = (int)HttpStatusCode.OK;
                return Json(new { orderedItems, totalAmount = totalAmount.ToString("C") }, JsonRequestBehavior.AllowGet);
            }

            Response.StatusCode = (int)HttpStatusCode.BadRequest;
            return Json(new { Message = "Bad Request." });
        }

        [HttpPost]
        [ActionName("Order")]
        public JsonResult CreateOrder(int ProductID, int Quantity)
        {
            if(ProductID > 0 && Quantity > 0)
            {
                var userID = GetUserId();
                var currentOrder = db.orders.Where(o => o.OrderStatus == "pending")
                                            .Where(o => o.CustomerID == userID)
                                            .FirstOrDefault();

                int orderID;

                if(currentOrder == null)
                {
                    var orderObj = new Order()
                    {
                        CustomerID = userID,
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

                if(OrderItem == null)
                {
                    var orderItemObj = new OrderItem()
                    {
                        OrderID = orderID,
                        ProductID = ProductID,
                        Quantity = Quantity
                    };

                    db.orderItems.Add(orderItemObj);
                    db.SaveChanges();

                    if( orderItemObj.ItemID > 0)
                    {
                        Response.StatusCode = (int)HttpStatusCode.OK;
                    }
                }
                else
                {
                    OrderItem.Quantity += Quantity;
                    db.Entry(OrderItem).State = EntityState.Modified;
                    db.SaveChanges();

                    if( OrderItem.ItemID > 0)
                    {
                        Response.StatusCode = (int)HttpStatusCode.OK;
                    }
                }
                
            }

            return Json(new { Message = "The product has been added to the shopping cart." });
        }

        [HttpPut]
        [ActionName("Order")]
        [ValidateAntiForgeryToken]
        public JsonResult EditOrder(FormCollection formCollection)
        {
            var ItemID = Int16.Parse(formCollection["ItemID"]);
            var Quantity = Int16.Parse(formCollection["Quantity"]);

            if (ItemID > 0)
            {
                var userID = GetUserId();
                var currentOrder = getCurrentOrder(userID);

                var OrderItem = db.orderItems.Where(o => o.OrderID == currentOrder)
                                            .Where(o => o.ItemID == ItemID).FirstOrDefault();

                if(OrderItem != null)
                {
                    OrderItem.Quantity = Quantity;
                    db.Entry(OrderItem).State = EntityState.Modified;
                    db.SaveChanges();

                    Response.StatusCode = (int)HttpStatusCode.OK;
                    return Json(new { Message = "Record has been updated." });
                }
            }

            Response.StatusCode = (int)HttpStatusCode.NotFound;
            return Json(new { Message = "Record not found." });
        }

        [HttpDelete]
        [ActionName("Order")]
        [ValidateAntiForgeryToken]
        public JsonResult DeleteOrder(FormCollection formCollection)
        {
            var ItemID = Int16.Parse(formCollection["ItemID"]);

            if(ItemID > 0)
            {
                var userID = GetUserId();

                if( userID != null)
                {
                    var currentOrder = getCurrentOrder(userID);

                    var orderItem = db.orderItems.Where(o => o.OrderID == currentOrder)
                                                .Where(o => o.ItemID == ItemID)
                                                .FirstOrDefault();

                    if( orderItem != null)
                    {
                        db.orderItems.Remove(orderItem);
                        db.SaveChanges();

                        Response.StatusCode = (int)HttpStatusCode.OK;
                        return Json(new { Message = "Record ID " + ItemID + " has been deleted." });
                    }
                }
                else
                {
                    Response.StatusCode = (int)HttpStatusCode.BadRequest;
                    return Json(new { Message = "Permission Denied." });
                }

            }

            Response.StatusCode = (int)HttpStatusCode.NotFound;
            return Json(new { Message = "Record ID + " + ItemID + " not found." });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult Checkout()
        {
            var userID = GetUserId();
            
            if( userID != null)
            {
                var currentOrderID = getCurrentOrder(userID);

                var order = db.orders.Where(o => o.OrderID == currentOrderID).Where(o => o.CustomerID == userID).FirstOrDefault();

                if( order != null)
                {
                    order.OrderStatus = "checkout";
                    db.Entry(order).State = EntityState.Modified;
                    db.SaveChanges();

                    Response.StatusCode = (int)HttpStatusCode.OK;
                    return Json(new { Message = "Checkout Successful" });
                }
            }

            Response.StatusCode = (int)HttpStatusCode.Unauthorized;
            return Json(new { Message = "Unauthorized." });
        }

        public int getCurrentOrder(string userID)
        {
            var currentOrder = db.orders.Where(o => o.OrderStatus == "pending")
                                        .Where(o => o.CustomerID == userID)
                                        .FirstOrDefault();

            return ( currentOrder != null ) ? currentOrder.OrderID : 0;
        }
    }
}