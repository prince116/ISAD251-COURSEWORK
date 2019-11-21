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

        [Route("Value")]
        public ActionResult Value()
        {
            ViewBag.Title = "Value";

            return View();
        }
    }
}