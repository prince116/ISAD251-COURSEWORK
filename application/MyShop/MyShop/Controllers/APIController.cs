using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Web.Mvc;
using MyShop.Models;
using MyShop.ViewModels;
using MyShop.DAL;
using System.Collections;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.ComponentModel.DataAnnotations;
using System.IO;

namespace MyShop.Controllers
{
    public class APIController : ControllerBase
    {
        private ShopContext db = new ShopContext();

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
    }
}