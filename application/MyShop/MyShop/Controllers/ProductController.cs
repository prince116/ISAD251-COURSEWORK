using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Web.Mvc;
using MyShop.DAL;

namespace MyShop.Controllers
{
    public class ProductController : ControllerBase
    {
        private ShopContext db = new ShopContext();
        
        // GET: Product
        public ActionResult Index()
        {
            return View();
        }

        // GET: Product/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return RedirectToAction("Index");
            }

            ViewBag.Id = id;
            return View();
        }

    }
}
