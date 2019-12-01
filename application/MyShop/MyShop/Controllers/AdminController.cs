using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using MyShop.Models;
using MyShop.DAL;

namespace MyShop.Controllers
{
    public class AdminController : ControllerBase
    {
        private ShopContext db = new ShopContext();

        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Products()
        {
            ViewBag.Id = 1;
            return View("~/Views/Admin/Product/index.cshtml");
        }

        [HttpGet]
        public ActionResult Product(int? id, string act)
        {
            if( act != null)
            {
                ViewBag.Id = id;

                switch (act)
                {
                    case "create":
                        ViewBag.CategoryID = new SelectList(db.productCategories, "CategoryID", "CategoryName");
                        return View("~/Views/Admin/Product/Create.cshtml");
                    case "details":
                        return View("~/Views/Admin/Product/Details.cshtml");
                    case "edit":

                        Product product = db.products.Find(id);
                        if( product != null)
                        {
                            ViewBag.CategoryID = new SelectList(db.productCategories, "CategoryID", "CategoryName", product.CategoryID);
                            return View("~/Views/Admin/Product/Edit.cshtml", product);
                        }
                        else
                        {
                            return RedirectToAction("Products");
                        }
                    case "delete":
                        return View("~/Views/Admin/Product/Delete.cshtml");
                    default:
                        return RedirectToAction("Products");
                }
            }
            
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult CreateProduct(FormCollection formCollection)
        {

            string ProductName = Convert.ToString(formCollection["ProductName"]);

            Response.StatusCode = (int)HttpStatusCode.OK;
            
            return Json(new { ProductName });
        }

        [HttpGet]
        public ActionResult Order(int? id)
        {
            var page = Request["page"];

            if( page == "details")
            {
                ViewBag.Id = id;
                return View("~/Views/Admin/Order/Details.cshtml");
            }
            else
            {
                return View("~/Views/Admin/Order/Index.cshtml");
            }
        }
    }
}