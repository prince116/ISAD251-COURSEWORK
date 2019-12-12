using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using MyShop.Models;

namespace MyShop.Controllers
{
    public class AdminController : ControllerBase
    {
        // GET: Admin
        public ActionResult Index()
        {
            return RedirectToRoute("Index", "Home");
        }

        [HttpGet]
        public ActionResult Products()
        {
            if (IsAdmin())
            {
                return View("~/Views/Admin/Product/index.cshtml");
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpGet]
        public ActionResult Product(int? id, string act)
        {
            if (IsAdmin())
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
                            // Check if the product is exist before redirect to edit product page
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

                return RedirectToAction("Products");
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpGet]
        public ActionResult Order(int? id)
        {
            if(IsAdmin())
            {
                var page = Request["page"];

                if( page == "details")
                {
                    ViewBag.Id = id;
                    ViewBag.Title = "Order Details";
                    return View("~/Views/Admin/Order/Details.cshtml");
                }
                else
                {
                    ViewBag.Title = "Orders";
                    return View("~/Views/Admin/Order/Index.cshtml");
                }
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }
    }
}