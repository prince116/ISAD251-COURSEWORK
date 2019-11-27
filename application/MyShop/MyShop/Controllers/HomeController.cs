using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using MyShop.DAL;

namespace MyShop.Controllers
{
    public class HomeController : ControllerBase
    {
        private ShopContext db = new ShopContext();
        public ActionResult Index()
        {
            var products = db.products.Where(s => s.SalesPeriodStartAt <= DateTime.Now && s.SalesPeriodEndAt >= DateTime.Now).Include(p => p.ProductCategories).ToList();

            return View(products.ToList());
        }

        [Route("About")]
        public ActionResult About()
        {
            ViewBag.Title = "About";

            return View();
        }

        [Route("Contact")]
        public ActionResult Contact()
        {
            ViewBag.Title = "Contact";

            return View();
        }

        //[Route("")]
        //public ActionResult AdminProductList()
        //{
        //    ViewBag.Title = "Admin Product";
        //    return View();
        //}

        //[Route("Admin/Product/{id}/{action}")]
        //public ActionResult AdminProduct(int id, string action)
        //{
        //    ViewBag.id = id;
        //    ViewBag.action = action;
        //    return View();
        //}

        [Route("Admin/Value")]
        public ActionResult Value()
        {
            ViewBag.Title = "Value";

            return View();
        }
    }
}