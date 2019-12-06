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
using System.Data.SqlClient;

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
            var products = new ArrayList();
            
            QuerySetting querySetting = new QuerySetting{ 
                is_admin = IsAdmin(),
                admin_as_user = false,
                query_by_category = false,
                query_by_keyword = false,
                keywords = "",
                category_id = 0
            };

            if ( keyword != null)
            {
                querySetting.query_by_keyword = true;
                querySetting.keywords = keyword;
            }
            else if ( category_id != null )
            {
                bool isParsable = Int16.TryParse(category_id, out var cid);

                if (isParsable)
                {
                    querySetting.query_by_category = true;
                    querySetting.category_id = cid;
                }
            }

            SqlParameter[] productParams = {
                new SqlParameter("@IS_ADMIN", querySetting.is_admin),
                new SqlParameter("@ADMIN_AS_USER", querySetting.admin_as_user),
                new SqlParameter("@QUERY_BY_KEYWORD", querySetting.query_by_keyword),
                new SqlParameter("@QUERY_BY_CATEGORY", querySetting.query_by_category),
                new SqlParameter("@KEYWORDS", querySetting.keywords),
                new SqlParameter("@CATEGORY_ID", querySetting.category_id)
            };

            var entity = db.Database.SqlQuery<SPGetProducts>("SPGetProducts @IS_ADMIN, @ADMIN_AS_USER, @QUERY_BY_KEYWORD, @QUERY_BY_CATEGORY, @KEYWORDS, @CATEGORY_ID", productParams).ToList();

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
                        category_name = item.CategoryName,
                        price = item.Price.ToString("C"),
                        discounted_price = item.DiscountedPrice.ToString("C"),
                        stock = item.StockQuantity,
                        file_path = "/Uploads/" + item.FilePath
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
                SqlParameter sqlParameter = new SqlParameter("@ProductID", id);
                var stockStatus = db.Database.SqlQuery<SPGetProductStockStatus>("SPGetProductStockStatus @ProductID", sqlParameter).FirstOrDefault();

                var totalStock = stockStatus == null ? product.StockQuantity : stockStatus.RemainStock;

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
                    stock = ( totalStock >= max_quantity_value ) ? max_quantity_value : totalStock,
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
                                stock = (item.StockQuantity > 0) ? "In stock" : "Out of stock",
                                file_path = "/Uploads/" + item.FilePath
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
                var orders = (IsAdmin()) ? db.viewSales.Where(s => s.OrderStatus != "pending").OrderByDescending(s => s.OrderID).ToList() : db.viewSales.Where(s => s.CustomerID == userID).Where(s => s.OrderStatus == "pending").OrderByDescending(s => s.OrderID).ToList();
                
                var records = new ArrayList();

                if(orders.Count > 0)
                {
                    foreach(var record in orders)
                    {
                        records.Add(new {
                            invoice_no = record.OrderID.ToString("D8"),
                            order_no = record.OrderID,
                            order_datetime = record.OrderDate.ToString("yyyy-MM-dd"),
                            order_status = record.OrderStatus.ToUpper(),
                            total_amount = record.TotalAmount.ToString("C"),
                            delivery_type = record.DeliveryType,
                            table_no = record.TableNo
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

                var orderParameter = new SqlParameter("@OrderID", currentOrder);
                var orderDetails = db.Database.SqlQuery<SPSalesDetails>("SPGetOrderDetailsById @OrderID", orderParameter).ToList();
                decimal totalAmount = 0;

                if (orderDetails.Count > 0)
                {
                    foreach (var item in orderDetails)
                    {
                        SqlParameter sqlParameter = new SqlParameter("@ProductID", item.ProductID);
                        var stockStatus = db.Database.SqlQuery<SPGetProductStockStatus>("SPGetProductStockStatus @ProductID", sqlParameter).FirstOrDefault();
                        var totalStock = stockStatus == null ? stockStatus.Stock : stockStatus.RemainStock;

                        orderedItems.Add(new
                        {
                            category = item.CategoryName,
                            item_id = item.ItemID,
                            product_id = item.ProductID,
                            product_name = item.ProductName,
                            product_description = item.ProductDescription,
                            price = item.Price.ToString("C"),
                            sub_total = item.SubTotal.ToString("C"),
                            file_path = "/Uploads/" + item.FilePath,
                            quantity = item.Quantity,
                            stock = item.Quantity >= totalStock ? item.Quantity : totalStock
                        });

                        totalAmount += item.SubTotal;
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
        [ValidateAntiForgeryToken]
        public JsonResult CreateOrder(int ProductID, int Quantity)
        {
            if(ProductID > 0 && Quantity > 0)
            {
                // Check product status
                var productInventory = db.products.Where(p => p.ProductID == ProductID).FirstOrDefault();

                // Check if the product is exist
                if( productInventory != null)
                {
                    // Check if the product is out of stock
                    if( (productInventory.StockQuantity - Quantity) < 0 )
                    {
                        Response.StatusCode = (int)HttpStatusCode.OK;
                        return Json(new { Message = "Sorry, the product is out of stock." });
                    }
                }
                else
                {
                    Response.StatusCode = (int)HttpStatusCode.NotFound;
                    return Json(new { Message = "The product does not exist." });
                }

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
                    SqlParameter sqlParameter = new SqlParameter("@ProductID", OrderItem.ProductID);
                    var stockStatus = db.Database.SqlQuery<SPGetProductStockStatus>("SPGetProductStockStatus @ProductID", sqlParameter).FirstOrDefault();
                    var totalStock = stockStatus == null ? stockStatus.Stock : stockStatus.RemainStock;

                    if( (totalStock + OrderItem.Quantity - Quantity) >= 0)
                    {
                        OrderItem.Quantity = Quantity;
                        db.Entry(OrderItem).State = EntityState.Modified;
                        db.SaveChanges();

                        Response.StatusCode = (int)HttpStatusCode.OK;
                        return Json(new { Status = "SUCCESS", Message = "Record has been updated." });
                    }
                    else
                    {
                        Response.StatusCode = (int)HttpStatusCode.OK;
                        return Json(new { Status = "OUT_OF_STOCK", Message = "Sorry, the product is out of stock." });
                    }

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
            return Json(new { Message = "Record ID " + ItemID + " not found." });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult Checkout(string DeliveryType, int TableNo)
        {
            var userID = GetUserId();

            if ( userID != null)
            {
                var currentOrderID = getCurrentOrder(userID);

                var order = db.orders.Where(o => o.OrderID == currentOrderID).Where(o => o.CustomerID == userID).FirstOrDefault();

                if( order != null)
                {
                    order.OrderStatus = "checkout";
                    order.DeliveryType = DeliveryType;
                    order.TableNo = TableNo;
                    db.Entry(order).State = EntityState.Modified;
                    db.SaveChanges();

                    Response.StatusCode = (int)HttpStatusCode.OK;
                    return Json(new { Message = "Checkout Successful" });
                }
            }

            Response.StatusCode = (int)HttpStatusCode.Unauthorized;
            return Json(new { Message = "Unauthorized." });
        }

        [HttpDelete]
        [ValidateAntiForgeryToken]
        public JsonResult CancelOrder()
        {
            var userID = GetUserId();

            if( userID != null)
            {
                var currentOrderID = getCurrentOrder(userID);

                var orderItems = db.orderItems.Where(o => o.OrderID == currentOrderID).ToList();

                if (orderItems.Count > 0 )
                {
                    foreach(var orderItem in orderItems)
                    {
                        db.orderItems.Remove(orderItem);
                        db.SaveChanges();
                    }

                    Response.StatusCode = (int)HttpStatusCode.OK;
                    return Json(new { Status = "SUCCESS", Message = "Your order has been cancelled." });
                }
            }

            Response.StatusCode = (int)HttpStatusCode.OK;
            return Json(new { Status = "ERROR" });
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